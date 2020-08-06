import 'package:xmw_shop/bean/LoginRspEntity.dart';

import '../MyApplication.dart';

class XmwRequestParams {
  static Map RequestParams() {
    Map<String, String> map = new Map();
    String token = "";
    String memberId = "";
    LoginRspData loginRspData = MyApplication.loginRspData;
    if (loginRspData != null) {
      if (loginRspData.token != null) {
        token = loginRspData.token;
      }
      if (loginRspData.memberId != null) {
        memberId = loginRspData.memberId;
      }
    }
    map['token'] = token;
    map['memberId'] = memberId;
    return map;
  }
}
