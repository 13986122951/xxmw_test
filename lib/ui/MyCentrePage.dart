
import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/UserInfoEntity.dart';
import 'package:xmw_shop/common/InputCallBack.dart';
import 'package:xmw_shop/common/PictureCallBack.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/Tool.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/BaseTitleBar.dart';
import 'package:xmw_shop/widgets/BottomInputDialog.dart';
import 'package:xmw_shop/widgets/PopRoute.dart';
import 'package:xmw_shop/widgets/SelectImgSheet.dart';

import '../MyApplication.dart';

MyCentreState centreState;

class MyCentrePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    centreState = new MyCentreState();
    return centreState;
  }
}

class NickCallBack implements ResponseCallBack {
  String valueStr = "";

  NickCallBack(String value) {
    valueStr = value;
  }

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
        UserInfoData userInfoData = MyApplication.userInfoData;
        userInfoData.nickName = valueStr;
        MyApplication.userInfoData = userInfoData;
        Tool.saveUserInfo(userInfoData);
        centreState.setUserInfo();
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class DescCallBack implements ResponseCallBack {
  String valueStr = "";

  DescCallBack(String value) {
    valueStr = value;
  }

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
        UserInfoData userInfoData = MyApplication.userInfoData;
        userInfoData.remarks = valueStr;
        MyApplication.userInfoData = userInfoData;
        Tool.saveUserInfo(userInfoData);
        centreState.setUserInfo();
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class InfoCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    UserInfoEntity baseBean = UserInfoEntity.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        MyApplication.userInfoData = baseBean.data;
        Tool.saveUserInfo(baseBean.data);
        centreState.setUserInfo();
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
}

class HeadCallBack implements ResponseCallBack {
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
        ReqQuoteApi.getInstance().getMemberInfo(new InfoCallBack());
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

updateNick(String key, String value) {
  ReqQuoteApi.getInstance().improveInfo(new NickCallBack(value), key, value);
}

updateDesc(String key, String value) {
  ReqQuoteApi.getInstance().improveInfo(new DescCallBack(value), key, value);
}

updateHead(String fileName, String photo) {
  ReqQuoteApi.getInstance()
      .improveInfoHead(new HeadCallBack(), photo, fileName);
}

class MyCentreState extends State<MyCentrePage>
    implements PictureCallBack, InputCallBack {
  loginOut() {
    UiHelpDart.showAlertDialog(context, confirm, "确认退出登录？");
  }

  confirm() {
    UiHelpDart.redirectToBackPage(context);
    UiHelpDart.loginOut();
    UiHelpDart.redirectToBackPage(context);
  }

  @override
  void onInputContent(int type, String content) {
    if (type == 0) {
      //昵称
      if (!StringUtils.isEmpty(content)) {
        UiHelpDart.showLoadingDialog();
        updateNick("nickName", content);
      }
    } else if (type == 1) {
      //简介
      if (!StringUtils.isEmpty(content)) {
        UiHelpDart.showLoadingDialog();
        updateDesc("desc", content);
      }
    }
  }

  userNick() {
    Navigator.push(
        context,
        PopRoute(
            child: BottomInputDialog(
          this,
          0,
          maxLength: 10,
        )));
  }

  userInfo() {
    Navigator.push(
        context,
        PopRoute(
            child: BottomInputDialog(
          this,
          1,
          maxLength: 20,
        )));
  }

  authentica() {}

  headClick() async {
    _openModalBottomSheet(0);
  }

  Future _openModalBottomSheet(int index) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SelectImgSheet(this, index);
        });
  }

  @override
  void callBack(File file, int index) {
    if (file != null) {
      getMultipartFile(file);
    }
  }

  Future getMultipartFile(File file) async {
    if (file != null) {
      List<int> result = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        quality: 80,
      );
      if (result.length > (1024 * 1024 * 5)) {
        UiHelpDart.showToast("图片过大");
        return;
      }
      String photo = convert.base64Encode(result);
      String path = file.path;
      String name = path.substring(path.lastIndexOf("/") + 1, path.length);
      if (!StringUtils.isEmpty(name) && !StringUtils.isEmpty(photo)) {
        updateHead(name, photo);
      } else {
        UiHelpDart.showToast("图片错误");
      }
    }
  }

  String headImag = "";
  String nameStr = "登录/注册";
  String descStr = "个人描述";

  @override
  void initState() {
    super.initState();
    setUserInfo();
    ReqQuoteApi.getInstance().getMemberInfo(new InfoCallBack());
  }

  setUserInfo() {
    if (MyApplication.isUserLogin && MyApplication.userInfoData != null) {
      nameStr = MyApplication.userInfoData.nickName;
      if (!StringUtils.isEmpty(MyApplication.userInfoData.remarks)) {
        descStr = MyApplication.userInfoData.remarks;
      } else {
        descStr = "个人描述";
      }
      headImag = MyApplication.userInfoData.photo;
    } else {
      headImag = "";
      nameStr = "登录/注册";
      descStr = "登录了解更多";
    }
    setState(() {});
  }

  @override
  void dispose() {
    eventBus.fire(LoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseTitleBar("个人设置", true),
      body: Column(
        children: [
          getUserInfoWidget(headImag, headClick),
          getUserDescWidget("昵称", nameStr, userNick),
          getUserDescWidget("个人描述", descStr, userInfo),
//          getMenuItem("实名认证", authentica),
          new Padding(
            padding: new EdgeInsets.fromLTRB(15, 20.0, 15, 20.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new RaisedButton(
                    onPressed: loginOut,
                    //通过控制 Text 的边距来控制控件的高度
                    child: new Padding(
                      padding: new EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 15.0),
                      child: new Text(
                        "退出登录",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getMenuItem(String title, onClick) {
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onClick,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(title,
                          style: TextStyle(
                              color: ResColors.color_font_1_color,
                              fontSize: 16)),
                    )),
                Container(
                  width: 14,
                  height: 14,
                  child: Image.asset("assets/images/my_arrow_right.png"),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              height: 1,
              color: ResColors.color_bg_color,
            )
          ],
        )
      ],
    );
  }

  Widget getUserInfoWidget(String headImag, onClick) {
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onClick,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("头像",
                          style: TextStyle(
                              color: ResColors.color_font_1_color,
                              fontSize: 16)),
                    )),
                new ClipOval(
                  child: Container(
                    width: 44,
                    height: 44,
                    color: ResColors.color_font_4_color,
                    child: CachedNetworkImage(
                      errorWidget: (context, url, error) => new Image.asset(
                          "assets/images/radio_default_cover.png"),
                      imageUrl: headImag,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  width: 14,
                  height: 14,
                  child: Image.asset("assets/images/my_arrow_right.png"),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
              height: 0,
              color: ResColors.divided_color,
            ))
          ],
        )
      ],
    );
  }

  Widget getUserDescWidget(String title, String text, onClick) {
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onClick,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(title,
                      style: TextStyle(
                          color: ResColors.color_font_1_color, fontSize: 16)),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(text,
                          style: TextStyle(
                              color: ResColors.color_font_3_color,
                              fontSize: 16)),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  width: 14,
                  height: 14,
                  child: Image.asset("assets/images/my_arrow_right.png"),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
              height: 0,
              color: ResColors.divided_color,
            ))
          ],
        )
      ],
    );
  }
}