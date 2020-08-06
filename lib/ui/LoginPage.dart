import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/LoginRspEntity.dart';
import 'package:xmw_shop/bean/UserInfoEntity.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/Tool.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/BaseTitleBar.dart';
import 'package:xmw_shop/widgets/ITextField.dart';

import '../MyApplication.dart';
import 'BaseDart.dart';

LoginState loginState;

class LoginPage extends BaseDart {
  @override
  State<StatefulWidget> initbuild() {
    loginState = new LoginState();
    return loginState;
  }
}

String phoneStr, msgStr;

class CodeCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast("短信发送失败");
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    BaseBean baseBean = BaseBean.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        UiHelpDart.showToast("短信发送成功");
        loginState._startTimer();
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
}

class LognCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast("登录失败");
  }

  @override
  void onSuccess(String var3) {
    Map<String, dynamic> json = jsonDecode(var3);
    LoginRspEntity baseBean = LoginRspEntity.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        MyApplication.loginRspData = baseBean.data;
        ReqQuoteApi.getInstance()
            .getMemberInfo(new InfoCallBack(baseBean.data));
      } else {
        UiHelpDart.hideLoadingDialog();
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
}

class InfoCallBack implements ResponseCallBack {
  LoginRspData loginRspData;

  InfoCallBack(LoginRspData baseBean) {
    this.loginRspData = baseBean;
  }

  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast("登录失败");
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    UserInfoEntity baseBean = UserInfoEntity.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        UiHelpDart.showToast("登录成功");
        Tool.saveloginInfo(loginRspData);
        Tool.saveUserInfo(baseBean.data);
        MyApplication.isUserLogin = true;
        MyApplication.loginRspData = loginRspData;
        MyApplication.userInfoData = baseBean.data;
        loginState.loginSuc();
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
}

class LoginState extends State<LoginPage> {
  String phoneNumStr = "";
  ITextField _phoneCode = new ITextField(
    maxLength: 11,
    maxLines: 1,
    isShowDel: true,
    inputBorder: InputBorder.none,
    keyboardType: ITextInputType.number,
    hintText: '请输入手机号',
    hintStyle: TextStyle(color: ResColors.color_font_3_color, fontSize: 14),
    textStyle: TextStyle(color: ResColors.color_font_1_color, fontSize: 16),
    fieldCallBack: (content) {
      phoneStr = content;
    },
  );
  ITextField msgCode = new ITextField(
    maxLength: 6,
    maxLines: 1,
    isShowDel: false,
    keyboardType: ITextInputType.number,
    inputBorder: InputBorder.none,
    hintText: '请输入验证码',
    hintStyle: TextStyle(color: ResColors.color_font_3_color, fontSize: 14),
    textStyle: TextStyle(color: ResColors.color_font_1_color, fontSize: 16),
    fieldCallBack: (content) {
      msgStr = content;
    },
  );

  void onLogin() {
    if (StringUtils.isEmpty(phoneStr)) {
      UiHelpDart.showToast("手机号不能为空");
      return;
    }
    if (phoneStr.length != 11) {
      UiHelpDart.showToast("手机号错误");
      return;
    }
    if (StringUtils.isEmpty(msgStr)) {
      UiHelpDart.showToast("验证码不能为空");
      return;
    }
    if (msgStr.length != 6) {
      UiHelpDart.showToast("验证码错误");
      return;
    }
    UiHelpDart.showLoadingDialog();
    ReqQuoteApi.getInstance()
        .loginOrRegister(new LognCallBack(), phoneStr, msgStr);
  }

  loginSuc() {
    eventBus.fire(LoginEvent());
    UiHelpDart.redirectToBackPage(context);
  }

  void sendMsg() {
    if (StringUtils.isEmpty(phoneStr)) {
      UiHelpDart.showToast("手机号不能为空");
      return;
    }
    if (phoneStr.length != 11) {
      UiHelpDart.showToast("手机号错误");
      return;
    }
    if (_seconds == 61) {
      UiHelpDart.showLoadingDialog();
      ReqQuoteApi.getInstance().sendCaptcha(new CodeCallBack(), phoneStr);
    }
  }

  Timer _timer;
  String _verifyStr = '获取验证码';
  int _seconds = 61;

  void _startTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 1) {
        _seconds = 61;
        _verifyStr = '获取验证码';
        _cancelTimer();
        setState(() {});
      } else {
        _seconds--;
        _verifyStr = _seconds.toString() + 's后重新获取';
        setState(() {});
      }
    });
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    super.dispose();
    phoneStr = null;
    msgStr = null;
    _cancelTimer();
  }

  @override
  void initState() {
    if (MyApplication.loginRspData != null &&
        !StringUtils.isEmpty(MyApplication.loginRspData.mobile)) {
      phoneNumStr = MyApplication.loginRspData.mobile;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: BaseTitleBar("手机号快捷登录", true),
      body: Column(
        children: <Widget>[
          Container(
            width: 100,
            margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: Image.asset("assets/images/login_logo.png"),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
            decoration: new BoxDecoration(
                border: new Border.all(
                    color: ResColors.color_font_4_color, width: 1),
                borderRadius: new BorderRadius.circular((10.0))),
            child: _phoneCode,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
            decoration: new BoxDecoration(
                border: new Border.all(
                    color: ResColors.color_font_4_color, width: 1),
                borderRadius: new BorderRadius.circular((10.0))),
            child: Row(
              children: [
                Expanded(child: msgCode),
                Container(
                  height: 30,
                  width: 1,
                  color: ResColors.color_font_4_color,
                ),
                Container(
                  width: 120,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: sendMsg,
                    child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          _verifyStr,
                          style: TextStyle(
                              color: ResColors.color_1_color, fontSize: 14),
                        )),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(40, 20.0, 40, 20.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new RaisedButton(
                    onPressed: onLogin,
                    //通过控制 Text 的边距来控制控件的高度
                    child: new Padding(
                      padding: new EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 15.0),
                      child: new Text(
                        "登录",
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
}
