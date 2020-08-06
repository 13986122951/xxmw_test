import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/BomCreateEntity.dart';
import 'package:xmw_shop/bean/BomInfoEntity.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/BaseTitleBar.dart';

//新增BOM清单
BomAddState bomAddState;
String titleStr = "创建";

class BomAddPage extends StatefulWidget {
  String id;

  BomAddPage(this.id) {
    if (!StringUtils.isEmpty(id)) {
      titleStr = "修改";
    } else {
      titleStr = "创建";
    }
  }

  @override
  State<StatefulWidget> createState() {
    bomAddState = new BomAddState();
    return bomAddState;
  }
}

class GetCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(titleStr + "失败");
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    BomInfoEntity entity = BomInfoEntity.fromJson(json);
    if (entity != null) {
      if (entity != null && entity.code == 0) {
        bomAddState.updata(entity.data);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class CallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(titleStr + "失败");
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    BaseBean entity = BaseBean.fromJson(json);
    if (entity != null) {
      if (entity.code == 0) {
        bomAddState.redirectToBackPage();
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

int nameLength = 10;
int companyLength = 20;
TextEditingController namecontroller = new TextEditingController();
TextEditingController devUnitcontroller = new TextEditingController();
TextEditingController systemcontroller = new TextEditingController();
TextEditingController partSystemcontroller = new TextEditingController();
TextEditingController singleMachinecontroller = new TextEditingController();
TextEditingController machineDevStepcontroller = new TextEditingController();
TextEditingController remarkscontroller = new TextEditingController();
//BOM名称
String bomName = "";
//研制单位
String devUnit = "";
//系统
String system = "";
//分系统
String partSystem = "";
//单机
String singleMachine = "";
//单机研制阶段
String machineDevStep = "";
//备注信息
String remarks = "";

class BomAddState extends State<BomAddPage> {
  void save() {
    if (StringUtils.isEmpty(bomName)) {
      UiHelpDart.showToast("名称不能为空");
      return;
    }
    if (bomName.length > 10) {
      UiHelpDart.showToast("名称不能超过10个字符");
      return;
    }
    if (StringUtils.isEmpty(devUnit)) {
      UiHelpDart.showToast("单位不能为空");
      return;
    }
    if (devUnit.length > 20) {
      UiHelpDart.showToast("单位不能超过20个字符");
      return;
    }

    BomCreateEntity entity = new BomCreateEntity();
    entity.bomName = bomName;
    entity.devUnit = devUnit;
    entity.system = system;
    entity.partSystem = partSystem;
    entity.singleMachine = singleMachine;
    entity.machineDevStep = machineDevStep;
    entity.remarks = remarks;
    entity.bomOrderId = widget.id;
    UiHelpDart.showLoadingDialog();
    ReqQuoteApi.getInstance().createBomOrder(new CallBack(), entity);
  }

  void redirectToBackPage() {
    eventBus.fire(MainChange4Event(4));
    Navigator.pop(context);
  }

  getBomInfo(String bomOrderId) {
    ReqQuoteApi.getInstance().getBomInfo(new GetCallBack(), bomOrderId);
  }

  updata(BomInfoData infoData) {
    if (infoData != null) {
      namecontroller.text = infoData.bomName;
      devUnitcontroller.text = infoData.devUnit;
      systemcontroller.text = infoData.sysName;
      partSystemcontroller.text = infoData.partName;
      singleMachinecontroller.text = infoData.singleMach;
      machineDevStepcontroller.text = infoData.singleStep;
      remarkscontroller.text = infoData.remarks;
      setState(() {});
    }
  }

  @override
  void initState() {
    namecontroller.addListener(() {
      bomName = namecontroller.text;
    });
    devUnitcontroller.addListener(() {
      devUnit = devUnitcontroller.text;
    });
    systemcontroller.addListener(() {
      system = systemcontroller.text;
    });
    partSystemcontroller.addListener(() {
      partSystem = partSystemcontroller.text;
    });
    singleMachinecontroller.addListener(() {
      singleMachine = singleMachinecontroller.text;
    });
    machineDevStepcontroller.addListener(() {
      machineDevStep = machineDevStepcontroller.text;
    });
    remarkscontroller.addListener(() {
      remarks = remarkscontroller.text;
    });
    namecontroller.text = "";
    devUnitcontroller.text = "";
    systemcontroller.text = "";
    partSystemcontroller.text = "";
    singleMachinecontroller.text = "";
    machineDevStepcontroller.text = "";
    remarkscontroller.text = "";
    if (!StringUtils.isEmpty(widget.id)) {
      getBomInfo(widget.id);
    }
  }

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseTitleBar(titleStr + "BOM清单", true),
      backgroundColor: Colors.white,
      body: EasyRefresh(
        child: Container(
          child: Column(
            children: <Widget>[
              getHeadWidget(),
              getNameWidget(
                  "清单名称", "请输入清单名称", true, nameLength, namecontroller),
              getDivWidget(),
              getNameWidget("单机研制单位", "请输入单机研制单位", true, companyLength,
                  devUnitcontroller),
              getDivWidget(),
              getNameWidget("系统", "请输入系统", false, nameLength, systemcontroller),
              getDivWidget(),
              getNameWidget(
                  "分系统", "请输入分系统", false, nameLength, partSystemcontroller),
              getDivWidget(),
              getNameWidget(
                  "单机", "请输入单机", false, nameLength, singleMachinecontroller),
              getDivWidget(),
              getNameWidget("单机研制阶段", "请输入单机研制阶段", false, nameLength,
                  machineDevStepcontroller),
              getDivWidget(),
              getNameWidget(
                  "备注信息", "请输入备注信息", false, companyLength, remarkscontroller),
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

  Widget getNameWidget(String title, String hintText, bool isShowRed,
      int maxlength, TextEditingController namecontroller) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                width: 110,
                child: Text(
                  title,
                  style: TextStyle(
                      color: ResColors.color_font_1_color, fontSize: 16),
                ),
              ),
              Expanded(
                  child: Container(
                child: TextField(
                  maxLines: 1,
                  controller: namecontroller,
                  maxLength: maxlength,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                ),
              )),
              Offstage(
                offstage: !isShowRed,
                child: Container(
                  width: 5,
                  height: 5,
                  child: Image.asset("assets/images/bg_subscript.png"),
                ),
              )
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
              onPressed: save,
              //通过控制 Text 的边距来控制控件的高度
              child: new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                child: new Text(
                  titleStr,
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
