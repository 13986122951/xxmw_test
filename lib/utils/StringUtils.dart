import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';

class StringUtils {
  static double toDouble(String str) {
    try {
      return double.parse(str);
    } catch (exception) {
      return 0;
    }
  }

  static int toInt(String str) {
    try {
      return int.parse(str);
    } catch (exception) {
      return 0;
    }
  }

  ///格式化 保留两位小数
  static String formatDouble(String vol, int digits) {
    double temp = toDouble(vol);
    String tempstr = "";
    if (temp.abs() > 100000000) {
      if (temp / 100000000 > 10000) {
        tempstr = (temp / 1000000000000.0).toStringAsFixed(2) + "万亿";
      } else {
        tempstr = (temp / 100000000.0).toStringAsFixed(2) + "亿";
      }
    } else if (temp.abs() > 10000) {
      tempstr = (temp / 10000.0).toStringAsFixed(2) + "万";
    } else {
      tempstr = temp.toStringAsFixed(digits);
    }
    return tempstr;
  }

  static bool isEmpty(String value) {
    if (value == null || value.length == 0) {
      return true;
    }
    return false;
  }

  static String getTextEmpty(String value) {
    if (value == null || value.length == 0) {
      return "";
    }
    return value;
  }

  static String getTimeLine(BuildContext context, int timeMillis) {
    if (timeMillis == 0) {
      return "";
    } else {
      return TimelineUtil.format(timeMillis, dayFormat: DayFormat.Full);
    }
  }

  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  static String todayDate() {
    var today = DateTime.now();
    return today.year.toString() +
        today.month.toString() +
        today.day.toString();
  }
}
