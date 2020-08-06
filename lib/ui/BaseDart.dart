import 'package:flutter/cupertino.dart';
import 'package:xmw_shop/utils/DeviceUtil.dart';

abstract class BaseDart extends StatefulWidget {
  State<StatefulWidget> initbuild();

  @override
  State<StatefulWidget> createState() {
    DeviceUtil.setBarStatus(true);
    return initbuild();
  }
}
