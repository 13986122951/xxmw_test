import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/UserSayItemEntity.dart';
import 'package:xmw_shop/common/InputCallBack.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/BaseRightImgTitleBar.dart';
import 'package:xmw_shop/widgets/BottomInputDialog.dart';
import 'package:xmw_shop/widgets/PopRoute.dart';
import 'package:xmw_shop/widgets/UserSayItemWidget.dart';

import '../MyApplication.dart';

UseSayState pageState;
int recordNum = 1;
int pageSize = 30;
bool isRefresh = true;
bool isMore = false;

class UseSayPage extends StatefulWidget {
  String pid = "";

  UseSayPage(this.pid) {
    pageState = new UseSayState();
  }

  @override
  State<StatefulWidget> createState() {
    return pageState;
  }
}

Future<Null> _refresh() async {
  isRefresh = true;
  recordNum = 1;
  pageState.customUseSay();
}

Future<Null> _onload() async {
  isRefresh = false;
  pageState.customUseSay();
}

class CallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    Map<String, dynamic> json = jsonDecode(var3);
    UserSayItemEntity entity = UserSayItemEntity.fromJson(json);
    if (entity != null) {
      if (entity.code == 0 && entity.data != null) {
        recordNum += 1;
        pageState.upData(entity.data);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class addBack implements ResponseCallBack {
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
        _refresh();
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

EasyRefreshController _controller = EasyRefreshController();

class UseSayState extends State<UseSayPage> implements InputCallBack {
  List<UserSayItemData> prodMap = [];

  upData(List<UserSayItemData> data) {
    if (isRefresh) {
      prodMap.clear();
    }
    if (data != null && data.length == pageSize) {
      isMore = true;
    } else {
      isMore = false;
    }
    prodMap.addAll(data);
    setState(() {});
  }

  @override
  void onInputContent(int type, String content) {
    if (type == 0) {
      if (!StringUtils.isEmpty(content)) {
        UiHelpDart.showLoadingDialog();
        submitCustomSay(content);
      }
    }
  }

  onClick() {
    if (!MyApplication.isUserLogin) {
      UiHelpDart.redirectToLoginPage(context);
    } else {
      Navigator.push(
          context,
          PopRoute(
              child: BottomInputDialog(
            this,
            0,
            maxLength: 50,
          )));
    }
  }

  @override
  void initState() {
    isRefresh = true;
    recordNum = 1;
    customUseSay();
  }

  @override
  void dispose() {
    eventBus.fire(EvaluateAddEvent());
  }

  customUseSay() {
    ReqQuoteApi.getInstance()
        .customUseSay(new CallBack(), widget.pid, recordNum, pageSize);
  }

  submitCustomSay(String text) {
    ReqQuoteApi.getInstance().submitCustomSay(new addBack(), widget.pid, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseRightImgTitleBar(
          "使用心得", onClick, "assets/images/bom_title_add.png"),
      backgroundColor: Colors.white,
      body: EasyRefresh(
        header: MaterialHeader(
          backgroundColor: Colors.blue,
        ),
        footer: MaterialFooter(
          backgroundColor: Colors.blue,
        ),
        onRefresh: _refresh,
        onLoad: isMore ? _onload : null,
        enableControlFinishRefresh: true,
        controller: _controller,
        child: Column(
          children: <Widget>[
            getHotBBSWidget(),
          ],
        ),
      ),
    );
  }

  Widget getHotBBSWidget() {
    return ListView.builder(
        itemCount: prodMap.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return UserSayItemWidget(
              prodMap[index], (index + 1) == prodMap.length);
        });
  }
}
