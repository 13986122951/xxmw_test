import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/CommentListEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

import 'CommentItemWidget.dart';

//帖子评论 楼主
InvitationCommentState commentState;
bool isRefresh = true;
String commentId;
int startNum = 0;
int pageSize = 30;
bool isNore = false;
bool isInit = false;

class InvitationCommentMainWidget extends StatefulWidget {
  InvitationCommentMainWidget(String id) {
    commentId = id;
  }

  @override
  State<StatefulWidget> createState() {
    commentState = new InvitationCommentState();
    return commentState;
  }

  refresh() {
    if (!isInit) {
      return;
    }
    startNum = 0;
    isRefresh = true;
    refPostsReply();
  }
}

class InfoCallBack implements ResponseCallBack {
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
    CommentListEntity baseBean = CommentListEntity.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        startNum += 1;
        commentState.update(baseBean.data);
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
}

Future<Null> _onload() async {
  isRefresh = true;
  refPostsReply();
}

class CommentCallBack implements ResponseCallBack {
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
        refPostsReply();
      } else {
        isRefresh = true;
        startNum = 0;
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
}

refPostsReply() {
  if (!isInit) {
    return;
  }
  ReqQuoteApi.getInstance()
      .getPostsReply(new InfoCallBack(), commentId, startNum, pageSize, "2");
}

EasyRefreshController _controller = EasyRefreshController();

class InvitationCommentState extends State<InvitationCommentMainWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    isInit = true;
    isRefresh = true;
    startNum = 0;
    refPostsReply();
  }

  List<CommentListEntityData> list = [];

  update(List<CommentListEntityData> data) {
    if (isRefresh) {
      list.clear();
    }
    if (data.length < pageSize) {
      isNore = false;
    } else {
      isNore = true;
    }
    list.addAll(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
        footer: MaterialFooter(
          backgroundColor: Colors.blue,
        ),
        onLoad: isNore ? _onload : null,
        enableControlFinishRefresh: true,
        controller: _controller,
        child: ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              CommentListEntityData listData = list[index];
              return CommentItemWidget(listData, commentId);
            }));
  }

  @override
  bool get wantKeepAlive => true;
}
