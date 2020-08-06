
import 'dart:convert';

import 'package:xmw_shop/bean/LoginRspEntity.dart';
import 'package:xmw_shop/bean/UserInfoEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';

import '../MyApplication.dart';
import 'Constants.dart';
import 'SharedPreferencesUtil.dart';
import 'StringUtils.dart';
import 'TextUtils.dart';

class Tool {
  static String version = "";
  static String uuid = "";
  static String systemMark = "";
  static String phoneMark = "";
  static String platformIP = "";

  Tool() {
    initloginInfo();
    initUserInfo();
  }


  static saveloginInfo(LoginRspData loginRspEntity) {
    if (loginRspEntity != null) {
      if (loginRspEntity.memberId != null) {
        SharedPreferencesUtil.setString(
            Constants.key_memberId, loginRspEntity.memberId);
      }
      if (loginRspEntity.token != null) {
        SharedPreferencesUtil.setString(
            Constants.key_token, loginRspEntity.token);
      }
      if (loginRspEntity.mobile != null) {
        SharedPreferencesUtil.setString(
            Constants.key_mobile, loginRspEntity.mobile);
      }
    }
  }

  static delloginInfo() {
    SharedPreferencesUtil.setString(Constants.key_memberId, "");
    SharedPreferencesUtil.setString(Constants.key_token, "");
    SharedPreferencesUtil.setString(Constants.key_mobile, "");
    SharedPreferencesUtil.setString(Constants.key_nickName, "");
    SharedPreferencesUtil.setString(Constants.key_photo, "");
    SharedPreferencesUtil.setInt(Constants.key_memberType, 0);
    SharedPreferencesUtil.setString(Constants.key_remarks, "");
  }

  static saveUserInfo(UserInfoData userInfoData) {
    if (userInfoData != null) {
      if (userInfoData.memberId != null) {
        SharedPreferencesUtil.setString(
            Constants.key_memberId, userInfoData.memberId);
      }
      if (userInfoData.token != null) {
        SharedPreferencesUtil.setString(
            Constants.key_token, userInfoData.token);
      }
      if (userInfoData.acctMobile != null) {
        SharedPreferencesUtil.setString(
            Constants.key_mobile, userInfoData.acctMobile);
      }
      if (userInfoData.nickName != null) {
        SharedPreferencesUtil.setString(
            Constants.key_nickName, userInfoData.nickName);
      }
      if (userInfoData.photo != null) {
        SharedPreferencesUtil.setString(
            Constants.key_photo, userInfoData.photo);
      }
      if (userInfoData.memberType != null) {
        SharedPreferencesUtil.setInt(
            Constants.key_memberType, userInfoData.memberType);
      }
      if (userInfoData.remarks != null) {
        SharedPreferencesUtil.setString(
            Constants.key_remarks, userInfoData.remarks);
      }
    }
  }

  static initloginInfo() {
    LoginRspData loginRspData = new LoginRspData();
    String memberId = "";
    String mobile = "";
    String token = "";
    Future<String> result =
        SharedPreferencesUtil.getString(Constants.key_memberId);
    result.then((value) {
      memberId = value;
      loginRspData.mobile = mobile;
      loginRspData.memberId = memberId;
      loginRspData.token = token;
      MyApplication.loginRspData = loginRspData;

      Future<String> result1 =
          SharedPreferencesUtil.getString(Constants.key_token);
      result1.then((value) {
        token = value;
        loginRspData.mobile = mobile;
        loginRspData.memberId = memberId;
        loginRspData.token = token;
        if (!StringUtils.isEmpty(token) && !StringUtils.isEmpty(memberId)) {
          MyApplication.isUserLogin = true;
          ReqQuoteApi.getInstance().getMemberInfo(new InfoCallBack());
        }
        MyApplication.loginRspData = loginRspData;
      });
    });

    Future<String> result2 =
        SharedPreferencesUtil.getString(Constants.key_mobile);
    result2.then((value) {
      mobile = value;
      loginRspData.mobile = mobile;
      loginRspData.memberId = memberId;
      loginRspData.token = token;
      MyApplication.loginRspData = loginRspData;
    });
  }

  static initUserInfo() {
    UserInfoData userInfoData = new UserInfoData();
    String memberId = "";
    String mobile = "";
    String token = "";
    int memberType = 0;
    String photo = "";
    String nickName = "";
    String remarks = "";
    Future<String> result =
        SharedPreferencesUtil.getString(Constants.key_memberId);
    result.then((value) {
      memberId = value;
      userInfoData.acctMobile = mobile;
      userInfoData.memberId = memberId;
      userInfoData.token = token;
      userInfoData.memberType = memberType;
      userInfoData.photo = photo;
      userInfoData.nickName = nickName;
      MyApplication.userInfoData = userInfoData;
      userInfoData.remarks = remarks;
    });

    Future<String> result1 =
        SharedPreferencesUtil.getString(Constants.key_token);
    result1.then((value) {
      token = value;
      userInfoData.acctMobile = mobile;
      userInfoData.memberId = memberId;
      userInfoData.token = token;
      userInfoData.memberType = memberType;
      userInfoData.photo = photo;
      userInfoData.nickName = nickName;
      userInfoData.remarks = remarks;
      MyApplication.userInfoData = userInfoData;
    });

    Future<String> result2 =
        SharedPreferencesUtil.getString(Constants.key_mobile);
    result2.then((value) {
      mobile = value;
      userInfoData.acctMobile = mobile;
      userInfoData.memberId = memberId;
      userInfoData.token = token;
      userInfoData.memberType = memberType;
      userInfoData.photo = photo;
      userInfoData.nickName = nickName;
      userInfoData.remarks = remarks;
      MyApplication.userInfoData = userInfoData;
    });

    Future<String> result3 =
        SharedPreferencesUtil.getString(Constants.key_photo);
    result3.then((value) {
      photo = value;
      userInfoData.acctMobile = mobile;
      userInfoData.memberId = memberId;
      userInfoData.token = token;
      userInfoData.memberType = memberType;
      userInfoData.photo = photo;
      userInfoData.nickName = nickName;
      userInfoData.remarks = remarks;
      MyApplication.userInfoData = userInfoData;
    });

    Future<String> result4 =
        SharedPreferencesUtil.getString(Constants.key_nickName);
    result4.then((value) {
      nickName = value;
      userInfoData.acctMobile = mobile;
      userInfoData.memberId = memberId;
      userInfoData.token = token;
      userInfoData.memberType = memberType;
      userInfoData.photo = photo;
      userInfoData.nickName = nickName;
      userInfoData.remarks = remarks;
      MyApplication.userInfoData = userInfoData;
    });

    Future<int> result5 =
        SharedPreferencesUtil.getInt(Constants.key_memberType);
    result5.then((value) {
      memberType = value;
      userInfoData.acctMobile = mobile;
      userInfoData.memberId = memberId;
      userInfoData.token = token;
      userInfoData.memberType = memberType;
      userInfoData.photo = photo;
      userInfoData.nickName = nickName;
      userInfoData.remarks = remarks;
      MyApplication.userInfoData = userInfoData;
    });
    Future<String> result6 =
        SharedPreferencesUtil.getString(Constants.key_remarks);
    result6.then((value) {
      remarks = value;
      userInfoData.acctMobile = mobile;
      userInfoData.memberId = memberId;
      userInfoData.token = token;
      userInfoData.memberType = memberType;
      userInfoData.photo = photo;
      userInfoData.nickName = nickName;
      userInfoData.remarks = remarks;
      MyApplication.userInfoData = userInfoData;
    });
  }
}

class InfoCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {}

  @override
  void onSuccess(String var3) {
    Map<String, dynamic> json = jsonDecode(var3);
    UserInfoEntity baseBean = UserInfoEntity.fromJson(json);
    if (baseBean != null && baseBean.code == 0) {
      Tool.saveUserInfo(baseBean.data);
      MyApplication.isUserLogin = true;
      MyApplication.userInfoData = baseBean.data;
    }
  }
}
