import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }
}
