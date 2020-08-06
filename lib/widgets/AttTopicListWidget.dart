
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/AttTopicListEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';

//我的关注 话题
int attentionType = 1;
int startNum = 0;
int pageSize = 30;
TopicListState state;
bool isRefresh = true;
bool isMore = false;

class AttTopicListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    state = new TopicListState();
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
    AttTopicListEntity entity = AttTopicListEntity.fromJson(json);
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

class TopicListState extends State<AttTopicListWidget>
    with AutomaticKeepAliveClientMixin {
  List<AttTopicListData> data = [];

  update(List<AttTopicListData> list) {
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

  @override
  void initState() {
    myAttention();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
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
            itemCount: data.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              AttTopicListData item = data[index];
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
                        child: Text(item.title),
                      ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Text(
                          item.headDesc,
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
