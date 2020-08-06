
import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xmw_shop/bean/CenterAdvEntity.dart';
import 'package:xmw_shop/bean/ProdsCateEntity.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/Constants.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

import '../MyApplication.dart';
import 'MyCentrePage.dart';

MyPageState state;

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    state = new MyPageState();
    return state;
  }
}

class CallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    Map<String, dynamic> json = jsonDecode(var3);
    CenterAdvEntity entity = CenterAdvEntity.fromJson(json);
    if (entity != null) {
      if (entity.code == 0 && entity.data != null) {
        state.updateAvd(entity.data.imgPath);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

int temp = 0;
double liveImgHeight = 50, liveImgWidth;
String nameStr = "登录/注册";
String descStr = "个人描述";
String headImag = "";

class MyPageState extends State<MyPage> {
  StreamSubscription loginSubscription;

  onAboutClick() {}

  onGoldClck() {
    UiHelpDart.redirectToMyGoldPage(context);
  }

  onCollect() {
    UiHelpDart.redirectToMyCollectPage(context);
  }

  onHistory() {
    UiHelpDart.redirectToMyHistoryPage(context);
  }

  onAttention() {
    UiHelpDart.redirectToMyAttentionPage(context);
  }

  onMessage() {
    UiHelpDart.redirectToMyMessagePage(context);
  }

  getCenterAdv() {
    ReqQuoteApi.getInstance().getCenterAdv(new CallBack());
  }

  onUserInfo() async {
    if (MyApplication.isUserLogin) {
      int result = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyCentrePage()));
      if (result == 1) {
        setUesrInfo();
      }
    } else {
      UiHelpDart.redirectToLoginPage(context);
    }
  }

  onEnquiry() {
    UiHelpDart.redirectTMyEnquiryPage(context);
  }

  String avdUrl = "";

  updateAvd(String avdurl) {
    avdUrl = StringUtils.getTextEmpty(avdurl);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loginSubscription = eventBus.on<LoginEvent>().listen((event) {
      setUesrInfo();
    });
    getCenterAdv();
  }

  setUesrInfo() {
    if (MyApplication.isUserLogin) {
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
    super.dispose();
    loginSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    liveImgWidth = MediaQuery.of(context).size.width - 20;
    liveImgHeight = liveImgWidth / 3.2;
    return EasyRefresh(
        child: Column(
      children: <Widget>[
        getUserInfoWidget(onUserInfo),
        getAvdImageWidget(),
        getMenuItem("assets/images/my_img_gold.png", "我的芯币", onGoldClck),
        getMenuItem("assets/images/my_img_collect.png", "我的收藏", onCollect),
        getMenuItem("assets/images/my_img_history.png", "浏览记录", onHistory),
        getMenuItem("assets/images/my_img_attention.png", "我的关注", onAttention),
        getMenuItem("assets/images/my_img_message.png", "我的消息", onMessage),
        getMenuItem("assets/images/my_img_price.png", "我的询价单", onEnquiry),
        getServiceWidget(),
      ],
    ));
  }

  Widget getUserInfoWidget(onClick) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onClick,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Row(
          children: <Widget>[
            new ClipOval(
              child: Container(
                width: 55,
                height: 55,
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) =>
                      new Image.asset("assets/images/head_default_pic.png"),
                  imageUrl: headImag,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  child: Text(
                    nameStr,
                    style: TextStyle(
                        color: ResColors.color_font_1_color,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 20, 0),
                  child: Text(descStr,
                      style: TextStyle(
                          color: ResColors.color_font_3_color, fontSize: 14)),
                )
              ],
            )),
            Container(
              width: 14,
              height: 14,
              child: Image.asset("assets/images/my_arrow_right.png"),
            )
          ],
        ),
      ),
    );
  }

  Widget getMenuItem(String imagePath, String title, onClick) {
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
                  width: 20,
                  height: 20,
                  child: Image.asset(imagePath),
                ),
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

  Widget getAvdImageWidget() {
    bool off = StringUtils.isEmpty(avdUrl) ? true : false;
    return Offstage(
      offstage: off,
      child: Container(
          child: new ClipRRect(
            child: new GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: liveImgHeight,
                width: liveImgWidth,
                color: ResColors.color_bg_color,
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) => Container(
                    color: ResColors.color_bg_color,
                  ),
                  imageUrl: avdUrl,
                  fit: BoxFit.fill,
                  height: liveImgHeight,
                  width: liveImgWidth,
                ),
              ),
              onTap: null,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10)),
    );
  }

  Widget getServiceWidget() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 200,
        height: 60,
        //设置 child 居中
        alignment: Alignment.center,
        margin: EdgeInsets.all(20),
        //边框设置
        decoration: new BoxDecoration(
          //背景
          color: Colors.white,
          //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          //设置四周边框
          border: new Border.all(
              width: 1, color: ResColors.indicator_unselect_color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Image.asset("assets/images/home_service_tel.png"),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "客服热线",
                  style: TextStyle(
                      fontSize: 16, color: ResColors.color_font_2_color),
                ),
                Text(
                  Constants.SERVICE_PHONE,
                  style: TextStyle(
                      fontSize: 16, color: ResColors.color_font_1_color),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}