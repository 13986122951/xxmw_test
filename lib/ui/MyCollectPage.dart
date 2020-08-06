import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/MyCollectItemEntity.dart';
import 'package:xmw_shop/common/InputCallBack.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/CollectItemWidget.dart';
import 'package:xmw_shop/widgets/FeverTitleBar.dart';

//我的收藏
MyCollectState collectState;
bool isShowDel = false;
String rightStr = "编辑";
int recordNum = 1;
int pageSize = 30;
bool isRefresh = true;
bool isMore = false;

class MyCollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    collectState = new MyCollectState();
    return collectState;
  }
}

Future<Null> _refresh() async {
  isRefresh = true;
  recordNum = 1;
  myFavorite();
}

Future<Null> _onload() async {
  isRefresh = false;
  myFavorite();
}

class CallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    MyCollectItemEntity entity = MyCollectItemEntity.fromJson(json);
    if (entity != null && entity.data != null) {
      if (entity.code == 0) {
        recordNum += 1;
        collectState.update(entity.data);
      } else if (entity.code == 9) {
        collectState.updateClear();
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class DelCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    BaseBean entity = BaseBean.fromJson(json);
    if (entity != null) {
      if (entity != null && entity.code == 0) {
        myFavorite();
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

myFavorite() {
  ReqQuoteApi.getInstance().myFavorite(new CallBack(), recordNum, pageSize);
}

List<String> selectList = [];

cancelFavorite() {
  if (selectList == null || selectList.length == 0) {
    UiHelpDart.showToast("请至少选择一个");
    return;
  }
  String favorIds = "";
  for (int i = 0; i < selectList.length; i++) {
    favorIds = favorIds + selectList[i] + ",";
  }
  UiHelpDart.showLoadingDialog();
  ReqQuoteApi.getInstance().cancelFavorite(new DelCallBack(), favorIds);
}

class Input implements InputCallBack {
  @override
  void onInputContent(int type, String content) {
    if (type == 0) {
      selectList.remove(content);
    } else {
      selectList.add(content);
    }
  }
}

class MyCollectState extends State<MyCollectPage> {
  List<MyCollectItemData> productList = [];

  onClick() {
    isShowDel = !isShowDel;
    if (isShowDel) {
      rightStr = "完成";
    } else {
      rightStr = "编辑";
    }
    selectList.clear();
    setState(() {});
  }

  update(List<MyCollectItemData> data) {
    if (isRefresh) {
      productList.clear();
    }
    if (data != null && data.length == pageSize) {
      isMore = true;
    } else {
      isMore = false;
    }
    productList.addAll(data);
    setState(() {});
  }

  updateClear() {
    productList.clear();
    isMore = false;
    isShowDel = false;
    rightStr = "编辑";
    setState(() {});
  }

  @override
  void initState() {
    isRefresh = true;
    recordNum = 1;
    myFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FeverTitleBar("我的收藏", rightStr, onClick),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          EasyRefresh(
            header: MaterialHeader(
              backgroundColor: Colors.blue,
            ),
            footer: MaterialFooter(
              backgroundColor: Colors.blue,
            ),
            onRefresh: _refresh,
            onLoad: isMore ? _onload : null,
            child: Column(
              children: <Widget>[
                getHotBBSWidget(),
                Offstage(
                  offstage: !isShowDel,
                  child: Container(
                    height: 50,
                  ),
                )
              ],
            ),
          ),
          Offstage(
            offstage: !isShowDel,
            child: GestureDetector(
              onTap: cancelFavorite,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    color: Colors.blue,
                    child: Text(
                      "删除",
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getHotBBSWidget() {
    return ListView.builder(
        itemCount: productList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return CollectItemWidget((index + 1) == productList.length,
              productList[index], !isShowDel, new Input());
        });
  }
}
