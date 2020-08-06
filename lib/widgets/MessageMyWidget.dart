import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/BBSBeanEntity.dart';
import 'package:xmw_shop/bean/MessageEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

//我的消息  系统消息
int recordNum = 1;
int pageSize = 30;
int msgType = 2;
MessageSysState sysState;
bool isRefresh = true;
bool isMore = false;

class MessageMyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    sysState = new MessageSysState();
    return sysState;
  }
}

EasyRefreshController _controller = EasyRefreshController();

class PageCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    Map<String, dynamic> json = jsonDecode(var3);
    MessageEntity entity = MessageEntity.fromJson(json);
    if (entity != null) {
      if (entity.code == 0) {
        recordNum += 1;
        sysState.updateMessage(entity.data);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

myMessages() {
  ReqQuoteApi.getInstance()
      .myMessages(new PageCallBack(), msgType, recordNum, pageSize);
}

class MessageSysState extends State<MessageMyWidget>
    with AutomaticKeepAliveClientMixin {
  List<MessageData> datas = [];

  Future<Null> _onload() async {
    isRefresh = false;
    myMessages();
  }

  Future<Null> _refresh() async {
    isRefresh = true;
    recordNum = 1;
    myMessages();
  }

  updateMessage(List<MessageData> data) {
    if (isRefresh) {
      datas.clear();
    }
    if (data != null && data.length == pageSize) {
      isMore = true;
    } else {
      isMore = false;
    }
    datas.addAll(data);
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    isRefresh = true;
    recordNum = 1;
    myMessages();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        topBouncing: false,
        taskIndependence: true,
        onRefresh: _refresh,
        header: MaterialHeader(
          backgroundColor: Colors.blue,
        ),
        footer: MaterialFooter(
          backgroundColor: Colors.blue,
        ),
        onLoad: isMore ? _onload : null,
        enableControlFinishRefresh: true,
        controller: _controller,
        child: ListView.builder(
            itemCount: datas.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              MessageData messageData = datas[index];
              String title = StringUtils.getTextEmpty(messageData.title);
              String content = StringUtils.getTextEmpty(messageData.content);
              int createTime = messageData.createTime;
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
                      )),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:
                            Text(StringUtils.getTimeLine(context, createTime)),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Text(
                          content,
                          style: TextStyle(color: ResColors.color_font_3_color),
                        ),
                      ))
                    ],
                  )
                ],
              );
            }));
  }
}
