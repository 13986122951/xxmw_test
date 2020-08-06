
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/BomProdListEntity.dart';
import 'package:xmw_shop/common/InputCallBack.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/BomDetailTitleBar.dart';
import 'package:xmw_shop/widgets/BomProdItemWidget.dart';

BomDetailState pageState;

//bom清单详情列表
class BomDetailPage extends StatefulWidget {
  String bomOrderId;
  String rightStr = "编辑";
  bool isShowDel = false;

  BomDetailPage(this.bomOrderId) {}

  @override
  State<StatefulWidget> createState() {
    pageState = new BomDetailState();
    return pageState;
  }
}

Future<Null> _refresh() async {
  pageState.getBomInfo();
}

class addCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    BomProdListEntity entity = BomProdListEntity.fromJson(json);
    if (entity != null) {
      if (entity.code == 0) {
        pageState.upData(entity.data.prodList);
      } else if (entity.code == 28) {
        UiHelpDart.showToast("暂无数据");
        pageState.upDateState();
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

List<String> selectList = [];

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
        pageState.getBomInfo();
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
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

EasyRefreshController _controller = EasyRefreshController();

class BomDetailState extends State<BomDetailPage> {
  List<BomProdListDataProdlist> prodList = [];

  upData(List<BomProdListDataProdlist> prodLists) {
    prodList = prodLists;
    setState(() {});
  }

  upDateState() {
    prodList.clear();
    widget.rightStr = "编辑";
    widget.isShowDel = false;
    setState(() {});
  }

  getBomInfo() {
    ReqQuoteApi.getInstance().getBomProds(new addCallBack(), widget.bomOrderId);
  }

  onClick() {
    if (prodList.length != 0) {
      UiHelpDart.redirectToEnquiryPage(context, widget.bomOrderId);
    } else {
      UiHelpDart.showToast("暂无数据");
    }
  }

  onClickT() {
    if (prodList.length == 0) {
      return;
    }
    widget.isShowDel = !widget.isShowDel;
    if (widget.isShowDel) {
      widget.rightStr = "完成";
    } else {
      widget.rightStr = "编辑";
    }
    selectList.clear();
    setState(() {});
  }

  @override
  void initState() {
    UiHelpDart.showLoadingDialog();
    getBomInfo();
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
    ReqQuoteApi.getInstance()
        .removeBomProd(new DelCallBack(), widget.bomOrderId, favorIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BomDetailTitleBar("BOM清单", onClick,
          "assets/images/icon_finance_news.png", onClickT, widget.rightStr),
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          EasyRefresh(
            header: MaterialHeader(
              backgroundColor: Colors.blue,
            ),
            onRefresh: _refresh,
            child: Column(
              children: <Widget>[
                getHotBBSWidget(),
                Offstage(
                  offstage: !widget.isShowDel,
                  child: Container(
                    height: 50,
                  ),
                )
              ],
            ),
          ),
          Offstage(
            offstage: !widget.isShowDel,
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
        itemCount: prodList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return BomProdItemWidget((index + 1) == prodList.length,
              prodList[index], !widget.isShowDel, new Input());
        });
  }
}