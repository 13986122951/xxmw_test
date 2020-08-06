import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:xmw_shop/bean/TopicPostListEntity.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';

import 'HotBBSItemWidget.dart';

//热门帖子
String topicId;
int recordNum = 1;
int pageSize = 30;
int postType = 1;
bool isMore = false;
bool isRefresh = true;
InvitationListState invitationListState;

class InvitationListWidget extends StatefulWidget {
  InvitationListWidget(String id) {
    topicId = id;
  }

  @override
  State<StatefulWidget> createState() {
    invitationListState = new InvitationListState();
    return invitationListState;
  }
}

class InfoCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {}

  @override
  void onSuccess(String var3) {
    Map<String, dynamic> json = jsonDecode(var3);
    TopicPostListEntity baseBean = TopicPostListEntity.fromJson(json);
    if (baseBean != null && baseBean.code == 0) {
      invitationListState.update(baseBean.data);
    }
  }
}

getTopicPostsPage() {
  ReqQuoteApi.getInstance().getTopicPostsPage(
      new InfoCallBack(), topicId, recordNum, pageSize, postType);
}

class InvitationListState extends State<InvitationListWidget>
    with AutomaticKeepAliveClientMixin {
  StreamSubscription subscription;

  Future<Null> _onload() async {
    isRefresh = false;
    getTopicPostsPage();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    subscription = eventBus.on<InvitationAddEvent>().listen((event) {
      isRefresh = true;
      recordNum = 1;
      getTopicPostsPage();
    });
    isRefresh = true;
    recordNum = 1;
    getTopicPostsPage();
  }

  @override
  void dispose() {
    subscription.cancel();
  }

  List<TopicPostListData> list = [];

  update(List<TopicPostListData> data) {
    if (isRefresh) {
      list.clear();
    }
    list.addAll(data);
    if (data.length < pageSize) {
      isMore = false;
      recordNum += 1;
    } else {
      isMore = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
        topBouncing: false,
        taskIndependence: true,
        footer: MaterialFooter(
          backgroundColor: Colors.blue,
        ),
        onLoad: isMore ? _onload : null,
        child: ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return HotBBSItemWidget(list[index]);
            }));
  }
}
