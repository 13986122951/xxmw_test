import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/UserInfoEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/Tool.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/BaseTitleBar.dart';

import '../MyApplication.dart';

//我的金币
MyGoldState goldState;

class MyGoldPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    goldState = new MyGoldState();
    return goldState;
  }
}

int xinPoint = 0;
EasyRefreshController _controller = EasyRefreshController();

class InfoCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast("查询失败");
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    UserInfoEntity baseBean = UserInfoEntity.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        xinPoint = baseBean.data.xinPoint;
        Tool.saveUserInfo(baseBean.data);
        MyApplication.userInfoData = baseBean.data;
        goldState.update();
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
}

Future<Null> _refresh() async {
  ReqQuoteApi.getInstance().getMemberInfo(new InfoCallBack());
}

class MyGoldState extends State<MyGoldPage> {
  @override
  void initState() {
    _refresh();
  }

  update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 20;
    double height = width * 210 / 351;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseTitleBar("我的芯币", true),
        body: EasyRefresh(
            controller: _controller,
            enableControlFinishRefresh: true,
            header: MaterialHeader(
              backgroundColor: Colors.blue,
            ),
            onRefresh: _refresh,
            child: Column(
              children: <Widget>[
                getHeadWidget(width, height),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text("芯币规则"),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      height: 1,
                      color: ResColors.color_bg_color,
                    ))
                  ],
                ),
                getItemInfo("1、每天登录APP可以获取1个；"),
                getItemInfo("2、浏览满30分钟账获取5个；"),
                getItemInfo("3、分享APP内链接获取10个；"),
                getItemInfo("4、个人信息补充完整获取20个。"),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text("芯币规则"),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      height: 1,
                      color: ResColors.color_bg_color,
                    ))
                  ],
                ),
                getItemInfo(
                    "用于下载APP内的数据手册、文献资料到个人手机，导出BOM清单到个人手机；下载一份文档或者导出一份BOM清单，消耗2个芯币；目的是避免用户大量下载APP内的数据手册和资料。"),
              ],
            )));
  }

  Widget getItemInfo(String text) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Text(text),
        ))
      ],
    );
  }

  Widget getHeadWidget(double width, double height) {
    return Container(
      margin: EdgeInsets.all(10),
      height: height,
      width: width,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: new AssetImage("assets/images/gold_bg.png"),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "当前可用芯币",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Image.asset("assets/images/gold_hint.png"),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    xinPoint.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(" 芯币",
                      style: TextStyle(color: Colors.white, fontSize: 16))
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
