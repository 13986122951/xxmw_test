import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/HomePageEntity.dart';
import 'package:xmw_shop/bean/MyHistoryEntity.dart';
import 'package:xmw_shop/common/InputCallBack.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/FeverTitleBar.dart';
import 'package:xmw_shop/widgets/HistoryItemWidget.dart';

//我的历史记录
int recordNum = 1;
int pageSize = 30;
bool isRefresh = true;
bool isMore = false;
bool isShowDel = false;
String rightStr = "编辑";
MyHistoryState historyState;

class MyHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    historyState = new MyHistoryState();
    return historyState;
  }
}

Future<Null> _refresh() async {
  isRefresh = true;
  recordNum = 1;
  myViewProdHis();
}

Future<Null> _onload() async {
  isRefresh = false;
  myViewProdHis();
}

EasyRefreshController _controller = EasyRefreshController();

class PageCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    Map<String, dynamic> json = jsonDecode(var3);
    MyHistoryEntity entity = MyHistoryEntity.fromJson(json);
    if (entity != null) {
      if (entity.code == 0) {
        recordNum += 1;
        historyState.updateMyHistoryData(entity.data);
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
      if (entity.code == 0) {
        selectList.clear();
        recordNum = 1;
        isRefresh = true;
        myViewProdHis();
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

myViewProdHis() {
  ReqQuoteApi.getInstance()
      .myViewProdHis(new PageCallBack(), recordNum, pageSize);
}

clearFootView(String viewIds) {
  ReqQuoteApi.getInstance().clearFootView(new DelCallBack(), viewIds);
}

List<String> selectList = [];

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

class MyHistoryState extends State<MyHistoryPage> {
  List<MyHistoryData> datas = [];

  updateMyHistoryData(List<MyHistoryData> data) {
    if (isRefresh) {
      datas.clear();
    }
    if (data != null && data.length == pageSize) {
      isMore = true;
    } else {
      isMore = false;
    }
    datas.addAll(data);
    if (datas.length == 0) {
      rightStr = "编辑";
      isShowDel = false;
    }
    setState(() {});
  }

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
    clearFootView(favorIds);
  }

  @override
  void initState() {
    isRefresh = true;
    recordNum = 1;
    myViewProdHis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FeverTitleBar("浏览记录", rightStr, onClick),
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
        itemCount: datas.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          MyHistoryData data = datas[index];
          HomePageDataNewprod dataNewprod = new HomePageDataNewprod();
          dataNewprod.imgPath = data.imgPath;
          dataNewprod.title = data.prodName;
          dataNewprod.dengJi = data.perGrade;
          dataNewprod.xinHao = data.xinHao;
          dataNewprod.danWei = data.createComp;
          dataNewprod.pkId = data.prodId;
          return HistoryItemWidget(dataNewprod, !isShowDel, new Input());
        });
  }
}
