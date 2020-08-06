import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xmw_shop/bean/EnquiryLsitEntity.dart';
import 'package:xmw_shop/bean/MyEnquiryListEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/widgets/BaseTitleBar.dart';

//询价单
String bomOrderId;
EnquiryState state;

class MyEnquiryDetailPage extends StatefulWidget {
  MyEnquiryDetailPage(String id) {
    bomOrderId = id;
  }

  @override
  State<StatefulWidget> createState() {
    state = new EnquiryState();
    return state;
  }
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
    MyEnquiryListEntity entity = MyEnquiryListEntity.fromJson(json);
    if (entity != null) {
      if (entity != null && entity.code == 0) {
        state.updateList(entity.data);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

void getInquiryList() {
  ReqQuoteApi.getInstance().myInquiryDetail(new CallBack(), bomOrderId);
}

class EnquiryState extends State<MyEnquiryDetailPage> {
  double itemHeight = 80;

  List<MyEnquiryListDataProdlist> prodList = [];
  String sumPrice = "";

  @override
  void initState() {
    getInquiryList();
  }

  updateList(MyEnquiryListData data) {
    sumPrice = StringUtils.getTextEmpty(data.sumPrice);
    prodList.clear();
    prodList.addAll(data.prodList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseTitleBar("元器件询价单", true),
      backgroundColor: Colors.white,
      body: EasyRefresh(
          child: Column(
        children: <Widget>[
          getHeadWidget(),
          ListView.builder(
              itemCount: prodList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                MyEnquiryListDataProdlist item = prodList[index];
                return getItemWidget(item);
              }),
          getBottomWidget(sumPrice),
          new Padding(
              padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
              child: Offstage(
                offstage: true,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new RaisedButton(
                        onPressed: () {
                          UiHelpDart.redirectToBackPage(context);
                        },
                        //通过控制 Text 的边距来控制控件的高度
                        child: new Padding(
                          padding:
                              new EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 15.0),
                          child: new Text(
                            "提交",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      )),
    );
  }

  Widget getHeadWidget() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: ResColors.color_font_4_color)),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  "型号规格",
                  style: TextStyle(
                      color: ResColors.color_font_1_color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            width: 1, color: ResColors.color_font_4_color),
                        left: BorderSide(
                            width: 1, color: ResColors.color_font_4_color))),
                child: Text(
                  "质量等级",
                  style: TextStyle(
                      color: ResColors.color_font_1_color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  "封装形式",
                  style: TextStyle(
                      color: ResColors.color_font_1_color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            width: 1, color: ResColors.color_font_4_color),
                        left: BorderSide(
                            width: 1, color: ResColors.color_font_4_color))),
                child: Text(
                  "名称",
                  style: TextStyle(
                      color: ResColors.color_font_1_color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  "数量",
                  style: TextStyle(
                      color: ResColors.color_font_1_color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }

  String xinHao = "";
  String fillMethod = "";
  String perGrade = "";
  String prodName = "";
  String prodNum = "";

  Widget getItemWidget(MyEnquiryListDataProdlist item) {
    xinHao = StringUtils.getTextEmpty(item.xinHao);
    fillMethod = StringUtils.getTextEmpty(item.fillMethod);
    perGrade = StringUtils.getTextEmpty(item.perGrade);
    prodName = StringUtils.getTextEmpty(item.prodName);
    prodNum = item.prodNum.toString();
    return Container(
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(width: 1, color: ResColors.color_font_4_color),
              left: BorderSide(width: 1, color: ResColors.color_font_4_color),
              bottom:
                  BorderSide(width: 1, color: ResColors.color_font_4_color))),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                height: itemHeight,
                alignment: Alignment.center,
                child: Text(
                  xinHao,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ResColors.color_font_3_color, fontSize: 14),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                height: itemHeight,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            width: 1, color: ResColors.color_font_4_color),
                        left: BorderSide(
                            width: 1, color: ResColors.color_font_4_color))),
                child: Text(
                  perGrade,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ResColors.color_font_3_color, fontSize: 14),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                height: itemHeight,
                child: Text(
                  fillMethod,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ResColors.color_font_3_color, fontSize: 14),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                height: itemHeight,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            width: 1, color: ResColors.color_font_4_color),
                        left: BorderSide(
                            width: 1, color: ResColors.color_font_4_color))),
                child: Text(
                  prodName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ResColors.color_font_3_color, fontSize: 14),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                height: itemHeight,
                child: Text(
                  prodNum,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ResColors.color_font_3_color, fontSize: 14),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget getBottomWidget(String price) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: ResColors.color_font_4_color),
              right: BorderSide(width: 1, color: ResColors.color_font_4_color),
              left: BorderSide(width: 1, color: ResColors.color_font_4_color))),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  "销售价格",
                  style: TextStyle(
                      color: ResColors.color_font_1_color,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              )),
              Expanded(
                  flex: 4,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(price),
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                width: 1,
                                color: ResColors.color_font_4_color))),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
