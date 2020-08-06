import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/CommentItemEntity.dart';
import 'package:xmw_shop/bean/CommentItemInfoEntity.dart';
import 'package:xmw_shop/bean/CommentListEntity.dart';
import 'package:xmw_shop/common/InputCallBack.dart';
import 'package:xmw_shop/net/CommentCallBack.dart';
import 'package:xmw_shop/net/InfoCallBack.dart';
import 'package:xmw_shop/net/PraiseCallBack.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

import 'BottomInputDialog.dart';
import 'PopRoute.dart';

//帖子评论item
class CommentItemWidget extends StatefulWidget {
  CommentListEntityData listData;
  List<CommantListEntityDataChild> childList;
  String postId;
  bool isInit = false;

  CommentItemWidget(this.listData, this.postId) {
    childList = listData.child;
  }

  @override
  State<StatefulWidget> createState() {
    return CommentItemState();
  }
}

class praiseCallBack implements ResponseCallBack {
  String commentId;

  praiseCallBack(String id) {
    commentId = id;
  }

  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {}
}

class CommentItemState extends State<CommentItemWidget>
    implements
        InputCallBack,
        ResponseCallBack,
        InfoCallBack,
        PraiseCallBack,
        CommentCallBack {
  @override
  void initState() {}

  @override
  void onInputContent(int type, String content) {
    if (type == 1) {
      String commentId = widget.listData.commentId;
      ReqQuoteApi.getInstance()
          .publishComment1(this, widget.postId, content, commentId, "");
    }
  }

  ///刷新单条数据
  getOneComment(String commentId) {
    ReqQuoteApi.getInstance().getOneComment(this, commentId);
  }

  ///更多评论
  moreComment() {
    String parentId = widget.listData.commentId;
    UiHelpDart.showLoadingDialog();
    getCommentsReply(widget.postId, parentId);
  }

  int startNum = 2;

  ///更多评论
  getCommentsReply(String commentId, String ppinglinID) {
    ReqQuoteApi.getInstance()
        .getCommentsReply(this, commentId, ppinglinID, startNum, 3);
  }

  ///1点赞，0取消点赞
  praiseComment(String commentId, String doType) {
    ReqQuoteApi.getInstance().praiseComment(this, commentId, doType);
  }

  onPraise() {
    UiHelpDart.showLoadingDialog();
    if (ifPraise == 0) {
      praiseComment(commentId, "1");
    } else {
      praiseComment(commentId, "0");
    }
  }

  int ifPraise;
  String commentId = "";

  @override
  Widget build(BuildContext context) {
    String replyText = StringUtils.getTextEmpty(widget.listData.replyText);
    String photo = StringUtils.getTextEmpty(widget.listData.photo);
    int commentNum = widget.listData.commentNum;
    int praiseNum = widget.listData.praiseNum;
    String firstNickName =
        StringUtils.getTextEmpty(widget.listData.firstNickName);
    int publishTimes = widget.listData.publishTimes;
    commentId = widget.listData.commentId;
    ifPraise = widget.listData.ifPraise;
    String collectImg = "assets/images/zan_img.png";
    if (ifPraise == 0) {
      collectImg = "assets/images/zan_img.png";
    } else {
      collectImg = "assets/images/zan_s_img.png";
    }
    bool isHasComment = false;
    bool childIsMore = false;
    if (commentNum > 0) {
      isHasComment = true;
    } else {
      isHasComment = false;
    }

    if (commentNum > widget.childList.length) {
      childIsMore = true;
    } else {
      childIsMore = false;
    }
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                child: new ClipOval(
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) =>
                        new Image.asset("assets/images/head_default_pic.png"),
                    imageUrl: photo,
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          firstNickName,
                          style: TextStyle(
                              color: ResColors.color_font_1_color,
                              fontSize: 16),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                        child: Text(
                          replyText,
                          style: TextStyle(
                              color: ResColors.color_font_1_color,
                              fontSize: 14),
                        ),
                      ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: Text(
                            StringUtils.getTimeLine(context, publishTimes),
                            style: TextStyle(
                                color: ResColors.color_font_3_color,
                                fontSize: 12)),
                      )),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.push(context,
                              PopRoute(child: BottomInputDialog(this, 1)));
                        },
                        child: Row(
                          children: [
                            Container(
                                height: 15,
                                width: 15,
                                child: Image.asset(
                                    "assets/images/invitation_msg.png")),
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                              child: Text(commentNum.toString(),
                                  style: TextStyle(
                                      color: ResColors.color_font_3_color,
                                      fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: onPraise,
                        child: Row(
                          children: [
                            Container(
                                height: 15,
                                width: 15,
                                child: Image.asset(collectImg)),
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                              child: Text(praiseNum.toString(),
                                  style: TextStyle(
                                      color: ResColors.color_font_3_color,
                                      fontSize: 12)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Offstage(
                    offstage: !isHasComment,
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              color: ResColors.indicator_unselect_color,
                              height: 1,
                            ))
                          ],
                        ),
                        ListView.builder(
                            itemCount: widget.childList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              CommantListEntityDataChild child =
                                  widget.childList[index];
                              return Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: RichText(
                                  text: TextSpan(
                                    text: child.secondNickName + "：",
                                    style: TextStyle(
                                        color: ResColors.color_1_color,
                                        fontSize: 12.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: child.replyText,
                                          style: TextStyle(
                                              color: ResColors
                                                  .color_font_1_color)),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Offstage(
                              offstage: !childIsMore,
                              child: GestureDetector(
                                onTap: moreComment,
                                child: Container(
                                  child: Text(
                                    "查看更多回复",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: ResColors.color_font_3_color),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                color: ResColors.indicator_unselect_color,
                height: 1,
              ))
            ],
          ),
        ],
      ),
    );
  }

  @override
  void onFailure(String var3) {}

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    CommentItemEntity baseBean = CommentItemEntity.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        if (baseBean.data != null && baseBean.data.length > 0) {
          startNum += 1;
          for (int i = 0; i < baseBean.data.length; i++) {
            CommentItemData itemData = baseBean.data[i];
            CommantListEntityDataChild child = new CommantListEntityDataChild();
            child.replyText = itemData.replyText;
            child.secondNickName = itemData.secondNickName;
            widget.childList.add(child);
          }
          setState(() {});
        }
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }

  @override
  void onInfoFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onInfoSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    CommentItemInfoEntity baseBean = CommentItemInfoEntity.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        widget.listData = baseBean.data;
        widget.childList.clear();
        widget.childList.addAll(widget.listData.child);
        setState(() {});
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }

  @override
  void onPraiseFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onPraiseSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    BaseBean baseBean = BaseBean.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        getOneComment(commentId);
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }

  @override
  void onCommentFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onCommentSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    BaseBean baseBean = BaseBean.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        getOneComment(commentId);
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
}
