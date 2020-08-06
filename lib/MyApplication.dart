import 'package:xmw_shop/utils/Tool.dart';

import 'bean/LoginRspEntity.dart';
import 'bean/UserInfoEntity.dart';

class MyApplication {
  static bool isUserLogin = false; //是否登录app
  static LoginRspData loginRspData; //用户登录信息
  static UserInfoData userInfoData; //用户基本信息

  ///全局初始化
  MyApplication() {
    new Tool();
  }
}
