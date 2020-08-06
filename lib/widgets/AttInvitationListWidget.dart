
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/MyAttenInvitaEntity.dart';
import 'package:xmw_shop/bean/MyCollectItemEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';

//我的关注 文章
int attentionType = 5;
int startNum = 0;
int pageSize = 30;
AttInvitationListState state;
bool isRefresh = true;
bool isMore = false;

class AttInvitationListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    state = new AttInvitationListState();

    return state;
  }
}

myAttention() {
  ReqQuoteApi.getInstance()
      .myAttention(new CallBack(), attentionType, startNum, pageSize);
}

class CallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    MyAttenInvitaEntity entity = MyAttenInvitaEntity.fromJson(json);
    if (entity != null) {
      if (entity != null && entity.code == 0 && entity.data != null) {
        state.update(entity.data);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

EasyRefreshController _controller = EasyRefreshController();

class AttInvitationListState extends State<AttInvitationListWidget>
    with AutomaticKeepAliveClientMixin {
  Future<Null> _onload() async {
    isRefresh = false;
    myAttention();
  }

  Future<Null> _refresh() async {
    startNum = 0;
    isRefresh = true;
    myAttention();
  }

  @override
  bool get wantKeepAlive => true;
  List<MyAttenInvitaData> data = [];

  update(List<MyAttenInvitaData> list) {
    if (isRefresh) {
      data.clear();
    } else {
      startNum += 1;
    }
    if (list != null && list.length == pageSize) {
      isMore = true;
    } else {
      isMore = false;
    }
    data.addAll(list);
    setState(() {});
  }

  @override
  void initState() {
    myAttention();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        topBouncing: false,
        taskIndependence: true,
        header: MaterialHeader(
          backgroundColor: Colors.blue,
        ),
        footer: MaterialFooter(
          backgroundColor: Colors.blue,
        ),
        onRefresh: _refresh,
        onLoad: data.length == pageSize ? _onload : null,
        enableControlFinishRefresh: true,
        controller: _controller,
        child: ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              MyAttenInvitaData invitaData = data[index];
              String title = StringUtils.getTextEmpty(invitaData.title);
              String headDesc = StringUtils.getTextEmpty(invitaData.headDesc);
              int praiseNum = invitaData.praiseNum;
              int commentsNum = invitaData.commentsNum;
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        height: 1,
                        color: ResColors.color_bg_color,
                      ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(title),
                      ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Text(
                          headDesc,
                          style: TextStyle(color: ResColors.color_font_3_color),
                        ),
                      ))
                    ],
                  ),
                  Container(
                    height: 40,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text("",
                              style: TextStyle(
                                  color: ResColors.color_font_3_color,
                                  fontSize: 12)),
                        )),
                        Container(
                            height: 15,
                            width: 15,
                            child: Image.asset(
                                "assets/images/invitation_msg.png")),
                        Container(
                          constraints: BoxConstraints(
                            minWidth: 20,
                          ),
                          margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                          child: Text(commentsNum.toString(),
                              style: TextStyle(
                                  color: ResColors.color_font_3_color,
                                  fontSize: 12)),
                        ),
                        Container(
                            height: 15,
                            width: 15,
                            child: Image.asset(
                                "assets/images/invitation_collect.png")),
                        Container(
                          constraints: BoxConstraints(
                            minWidth: 20,
                          ),
                          margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                          child: Text(praiseNum.toString(),
                              style: TextStyle(
                                  color: ResColors.color_font_3_color,
                                  fontSize: 12)),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }));
  }
}
