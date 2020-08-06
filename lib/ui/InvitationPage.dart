import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/InvitationBaseEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/InvitationAllListWidget.dart';
import 'package:xmw_shop/widgets/InvitationListWidget.dart';
import 'package:xmw_shop/widgets/InvitationTitleBar.dart';

//话题下的帖子列表
String pkid;
InvitationState invitationState;
int doType = 1; //关注   3取消关注

class InvitationPage extends StatefulWidget {
  InvitationPage(String id) {
    pkid = id;
  }

  @override
  State<StatefulWidget> createState() {
    invitationState = new InvitationState();
    return invitationState;
  }
}

class InfoCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    InvitationBaseEntity baseBean = InvitationBaseEntity.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        invitationState.updateData(baseBean);
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
}

class praisePostCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    BaseBean baseBean = BaseBean.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        invitationState.updata();
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
}

class InvitationState extends State<InvitationPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    UiHelpDart.showLoadingDialog();
    ReqQuoteApi.getInstance().getTopicBase(new InfoCallBack(), pkid);
  }

  String title = "";
  String desc = "";
  String topicId = "";
  String praiseStr = "关注";
  bool ispraise = false;

  updateData(InvitationBaseEntity baseBean) {
    if (baseBean.data != null) {
      title = baseBean.data.title;
      desc = baseBean.data.remarks;
      topicId = baseBean.data.id;
      if (baseBean.data.ifFocus == 0) {
        praiseStr = "关注";
        ispraise = false;
      } else {
        ispraise = true;
        praiseStr = "取消关注";
      }
      setState(() {});
    }
  }

  updata() {
    if (doType == 3) {
      praiseStr = "关注";
      ispraise = false;
    } else {
      ispraise = true;
      praiseStr = "取消关注";
    }
    setState(() {});
  }

  void praisePost() {
    if (ispraise) {
      doType = 3;
    } else {
      doType = 1;
    }
    UiHelpDart.showLoadingDialog();
    ReqQuoteApi.getInstance()
        .praisePost(new praisePostCallBack(), topicId, doType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      new AssetImage("assets/images/invitation_detial_bg.png"),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InvitationTitleBar(topicId),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          title,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ActionChip(
                          label: Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: Text(
                              praiseStr,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                          //点击事件
                          onPressed: () {
                            praisePost();
                          },
                          elevation: 0,
                          backgroundColor: ResColors.bg_quote_round_game_color,
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Text(
                      desc,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: 200,
                  height: 36,
                  child: TabBar(
                      controller: controller,
                      labelColor: ResColors.color_1_color,
                      unselectedLabelColor: ResColors.color_font_1_color,
                      indicatorColor: ResColors.color_1_color,
                      indicatorWeight: 2,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                      unselectedLabelStyle:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      tabs: <Widget>[
                        Tab(
                          text: "全部",
                        ),
                        Tab(
                          text: "精华",
                        )
                      ]),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  color: ResColors.divided_color,
                  height: 1,
                ))
              ],
            ),
            Expanded(
                flex: 1,
                child: TabBarView(controller: controller, children: <Widget>[
                  new InvitationAllListWidget(pkid),
                  new InvitationListWidget(pkid)
                ]))
          ],
        ));
  }
}
