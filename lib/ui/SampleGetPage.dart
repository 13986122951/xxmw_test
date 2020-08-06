import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/SampleSheetReq.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/BaseTitleBar.dart';

//样片索取
SampleGetState getState;

class SampleGetPage extends StatefulWidget {
  String pid;

  SampleGetPage(this.pid) {}

  @override
  State<StatefulWidget> createState() {
    getState = new SampleGetState();
    return getState;
  }
}

class PageCallBack implements ResponseCallBack {
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
        getState.redirectToBackPage();
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

sampleSheet(SampleSheetReq req) {
  ReqQuoteApi.getInstance().sampleSheet(new PageCallBack(), req);
}

TextEditingController namecontroller = new TextEditingController();
TextEditingController unitcontroller = new TextEditingController();
TextEditingController prodcontroller = new TextEditingController();
TextEditingController usercontroller = new TextEditingController();
TextEditingController numcontroller = new TextEditingController();
TextEditingController addrcontroller = new TextEditingController();
TextEditingController phonecontroller = new TextEditingController();

class SampleGetState extends State<SampleGetPage> {
  onClick() {
    if (StringUtils.isEmpty(userName)) {
      UiHelpDart.showToast("姓名不能为空");
      return;
    }
    if (StringUtils.isEmpty(unitName)) {
      UiHelpDart.showToast("单位名称不能为空");
      return;
    }
    if (StringUtils.isEmpty(prodName)) {
      UiHelpDart.showToast("产品名称不能为空");
      return;
    }
    if (StringUtils.isEmpty(useScene)) {
      UiHelpDart.showToast("应用背景不能为空");
      return;
    }
    if (needNum == 0) {
      UiHelpDart.showToast("数量不能为0");
      return;
    }
    if (StringUtils.isEmpty(receiveAddr)) {
      UiHelpDart.showToast("收货地址不能为空");
      return;
    }
    if (StringUtils.isEmpty(linkPhone)) {
      UiHelpDart.showToast("手机号不能为空");
      return;
    }
    if (linkPhone.length != 11) {
      UiHelpDart.showToast("手机号错误");
      return;
    }
    SampleSheetReq req = new SampleSheetReq();
    req.prodId = widget.pid;
    req.prodName = prodName;
    req.linkPhone = linkPhone;
    req.needNum = needNum;
    req.receiveAddr = receiveAddr;
    req.unitName = unitName;
    req.userName = userName;
    req.useScene = useScene;
    UiHelpDart.showLoadingDialog();
    sampleSheet(req);
  }

  String userName = "";
  String unitName = "";
  String prodName = "";
  String useScene = "";
  int needNum = 0;
  String receiveAddr = "";
  String linkPhone = "";

  @override
  void initState() {
    namecontroller.addListener(() {
      userName = namecontroller.text;
    });
    unitcontroller.addListener(() {
      unitName = unitcontroller.text;
    });
    prodcontroller.addListener(() {
      prodName = prodcontroller.text;
    });
    usercontroller.addListener(() {
      useScene = usercontroller.text;
    });
    numcontroller.addListener(() {
      needNum = StringUtils.toInt(numcontroller.text);
    });
    addrcontroller.addListener(() {
      receiveAddr = addrcontroller.text;
    });
    phonecontroller.addListener(() {
      linkPhone = phonecontroller.text;
    });
  }

  redirectToBackPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseTitleBar("样片索取", true),
      backgroundColor: Colors.white,
      body: EasyRefresh(
        child: Container(
          child: Column(
            children: <Widget>[
              getHeadWidget(),
              getNameWidget(
                  "申请人", "请输入姓名", namecontroller, 8, TextInputType.text),
              getDivWidget(),
              getNameWidget(
                  "申请单位", "请输入单位名称", unitcontroller, 20, TextInputType.text),
              getDivWidget(),
              getNameWidget(
                  "应用产品", "请输入产品名称", prodcontroller, 120, TextInputType.text),
              getDivWidget(),
              getNameWidget(
                  "应用背景", "请输入应用背景", usercontroller, 20, TextInputType.text),
              getDivWidget(),
              getNameWidget(
                  "样品数量", "请输入数量", numcontroller, 8, TextInputType.number),
              getDivWidget(),
              getNameWidget(
                  "收货地址", "请输入详细收货地址", addrcontroller, 30, TextInputType.text),
              getDivWidget(),
              getNameWidget(
                  "联系电话", "请输入手机号", phonecontroller, 11, TextInputType.number),
              getDivWidget(),
              subWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget getHeadWidget() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: Text(
            "请填写并核对信息",
            style: TextStyle(color: ResColors.color_font_3_color),
          ),
        ))
      ],
    );
  }

  Widget getNameWidget(
      String title,
      String hintText,
      TextEditingController controller,
      int maxlength,
      TextInputType keyboardType) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                width: 90,
                child: Text(
                  title,
                  style: TextStyle(
                      color: ResColors.color_font_1_color, fontSize: 16),
                ),
              ),
              Expanded(
                  child: Container(
                child: TextField(
                  maxLength: maxlength,
                  controller: controller,
                  keyboardType: keyboardType,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                ),
              ))
            ],
          ),
        ))
      ],
    );
  }

  Widget subWidget() {
    return new Padding(
      padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new RaisedButton(
              onPressed: onClick,
              //通过控制 Text 的边距来控制控件的高度
              child: new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                child: new Text(
                  "提交申请",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget getDivWidget() {
    return Container(
      height: 1,
      color: ResColors.color_bg_color,
    );
  }
}
