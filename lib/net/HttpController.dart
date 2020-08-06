import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/LoginRspEntity.dart';
import 'package:xmw_shop/common/event_bus.dart';

import '../MyApplication.dart';
import 'CommentCallBack.dart';
import 'InfoCallBack.dart';
import 'PraiseCallBack.dart';
import 'ResponseCallBack.dart';

class HttpController {
  static String BASE_HTTPS_LOCAL_URL = "http://www.ic2035.com/xxs/app/";

  static void getlocal(
      String url, Map<String, String> params, ResponseCallBack callBack) async {
    if (params != null && params.isNotEmpty) {
      url = BASE_HTTPS_LOCAL_URL + url;
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    try {
      Dio dio = new Dio();
      dio.options.connectTimeout = 5000;
      dio.options.receiveTimeout = 5000;
      dio.options.responseType = ResponseType.plain;
      var response = await dio.get(url);
      if (callBack != null) {
        String rsp = response.data.toString();
        Map<String, dynamic> json = jsonDecode(rsp);
        BaseBean entity = BaseBean.fromJson(json);
        if (entity != null && entity.code == 5) {
          MyApplication.isUserLogin = false;
          eventBus.fire(LoginEvent());
        }
        callBack.onSuccess(rsp);
      }
    } catch (exception) {
      if (callBack != null) {
        callBack.onFailure(exception.toString());
      }
    }
  }

  static void postlocal(
      String url, Map<String, String> params, ResponseCallBack callBack) async {
    try {
      url = BASE_HTTPS_LOCAL_URL + url;
      var dio = new Dio();
      dio.options.connectTimeout = 5000; //5s
      dio.options.receiveTimeout = 3000;
      dio.options.responseType = ResponseType.plain;
      FormData formData = new FormData.fromMap(params);
      var response = await dio.post(url, data: formData);
      if (callBack != null) {
        String rsp = response.data.toString();
        Map<String, dynamic> json = jsonDecode(rsp);
        BaseBean entity = BaseBean.fromJson(json);
        if (entity != null && entity.code == 5) {
          MyApplication.isUserLogin = false;
          eventBus.fire(LoginEvent());
        }
        callBack.onSuccess(rsp);
      }
    } catch (exception) {
      if (callBack != null) {
        callBack.onFailure(exception.toString());
      }
    }
  }

  static void getlocalInfo(
      String url, Map<String, String> params, InfoCallBack callBack) async {
    if (params != null && params.isNotEmpty) {
      url = BASE_HTTPS_LOCAL_URL + url;
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    try {
      Dio dio = new Dio();
      dio.options.connectTimeout = 5000;
      dio.options.receiveTimeout = 5000;
      dio.options.responseType = ResponseType.plain;
      var response = await dio.get(url);
      if (callBack != null) {
        String rsp = response.data.toString();
        Map<String, dynamic> json = jsonDecode(rsp);
        BaseBean entity = BaseBean.fromJson(json);
        if (entity != null && entity.code == 5) {
          MyApplication.isUserLogin = false;
          eventBus.fire(LoginEvent());
        }
        callBack.onInfoSuccess(rsp);
      }
    } catch (exception) {
      if (callBack != null) {
        callBack.onInfoFailure(exception.toString());
      }
    }
  }

  static void postPraiselocal(
      String url, Map<String, String> params, PraiseCallBack callBack) async {
    try {
      url = BASE_HTTPS_LOCAL_URL + url;
      var dio = new Dio();
      dio.options.connectTimeout = 5000; //5s
      dio.options.receiveTimeout = 3000;
      dio.options.responseType = ResponseType.plain;
      FormData formData = new FormData.fromMap(params);
      var response = await dio.post(url, data: formData);
      if (callBack != null) {
        String rsp = response.data.toString();
        Map<String, dynamic> json = jsonDecode(rsp);
        BaseBean entity = BaseBean.fromJson(json);
        if (entity != null && entity.code == 5) {
          MyApplication.isUserLogin = false;
          eventBus.fire(LoginEvent());
        }
        callBack.onPraiseSuccess(rsp);
      }
    } catch (exception) {
      if (callBack != null) {
        callBack.onPraiseFailure(exception.toString());
      }
    }
  }

  static void postComment(
      String url, Map<String, String> params, CommentCallBack callBack) async {
    try {
      url = BASE_HTTPS_LOCAL_URL + url;
      var dio = new Dio();
      dio.options.connectTimeout = 5000; //5s
      dio.options.receiveTimeout = 3000;
      dio.options.responseType = ResponseType.plain;
      FormData formData = new FormData.fromMap(params);
      var response = await dio.post(url, data: formData);
      if (callBack != null) {
        String rsp = response.data.toString();
        Map<String, dynamic> json = jsonDecode(rsp);
        BaseBean entity = BaseBean.fromJson(json);
        if (entity != null && entity.code == 5) {
          MyApplication.isUserLogin = false;
          eventBus.fire(LoginEvent());
        }
        callBack.onCommentSuccess(rsp);
      }
    } catch (exception) {
      if (callBack != null) {
        callBack.onCommentFailure(exception.toString());
      }
    }
  }
}
