
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluwx_no_pay/fluwx_no_pay.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/PostDetailEntity.dart';
import 'package:xmw_shop/common/InputCallBack.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/BottomInputDialog.dart';
import 'package:xmw_shop/widgets/InvitationCommentMainWidget.dart';
import 'package:xmw_shop/widgets/InvitationCommentWidget.dart';
import 'package:xmw_shop/widgets/InvitationDetailTitleBar.dart';
import 'package:xmw_shop/widgets/MyTabBar.dart';
import 'package:xmw_shop/widgets/PopRoute.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';

//帖子详情
String topicId;
InvitationDetailState detailState;
InvitationCommentWidget invitationCommentWidge;
InvitationCommentMainWidget mainWidget;

class InvitationDetailPage extends StatefulWidget {
  InvitationDetailPage(String id) {
    topicId = id;
    invitationCommentWidge = new InvitationCommentWidget(topicId);
    mainWidget = new InvitationCommentMainWidget(topicId);
  }

  @override
  State<StatefulWidget> createState() {
    detailState = new InvitationDetailState();
    return detailState;
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
    PostDetailEntity baseBean = PostDetailEntity.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        detailState.update(baseBean);
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
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
        getPostsDetail();
        invitationCommentWidge.refresh();
        mainWidget.refresh();
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
}

class attentionCallBack implements ResponseCallBack {
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
        getPostsDetail();
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
}

getPostsDetail() {
  ReqQuoteApi.getInstance().getPostsDetail(new InfoCallBack(), topicId);
}

class ShareBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {}

  @override
  void onSuccess(String var3) {}
}

class InvitationDetailState extends State<InvitationDetailPage>
    with SingleTickerProviderStateMixin
    implements InputCallBack {
  ScrollController _scrollViewController;
  TabController _tabController;

  @override
  void initState() {
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 2);
    UiHelpDart.showLoadingDialog();
    getPostsDetail();
  }

  String contentStr = "";
  String contentTitle = "";
  String photo = "";
  int publishTime = 0;
  String commentNum = "0";
  String praiseNum = "0";
  String praiseStr = "关注";
  int curUserPraise = 0; //0没有点赞 1点赞
  int ifFocus = 0; //0没有关注  1关注
  String collectImg = "assets/images/invitation_collect.png";
  String img1 = "", img2 = "", img3 = "";
  bool isImage = false;

  update(PostDetailEntity baseBea) {
    if (baseBea.data != null) {
      contentStr = StringUtils.getTextEmpty(baseBea.data.text);
      contentTitle = StringUtils.getTextEmpty(baseBea.data.title);
      sharetext = "我在" + contentTitle + "发表了新的文章快来围观";
      photo = StringUtils.getTextEmpty(baseBea.data.photo);
      publishTime = baseBea.data.publishTime;
      commentNum = StringUtils.getTextEmpty(baseBea.data.commentNum.toString());
      praiseNum = StringUtils.getTextEmpty(baseBea.data.praiseNum.toString());
      curUserPraise = baseBea.data.curUserPraise;
      List<String> images = baseBea.data.images.split(",");
      if (images != null && images.length > 0) {
        if (images.length == 1) {
          img1 = images[0];
          img2 = "";
          img3 = "";
        } else if (images.length == 2) {
          img1 = images[0];
          img2 = images[1];
          img3 = "";
        } else if (images.length == 3) {
          img1 = images[0];
          img2 = images[1];
          img3 = images[2];
        }
      }
      if (StringUtils.isEmpty(img1) &&
          StringUtils.isEmpty(img2) &&
          StringUtils.isEmpty(img3)) {
        isImage = false;
      } else {
        isImage = true;
      }
      ifFocus = baseBea.data.ifFocus;
      if (ifFocus == 0) {
        praiseStr = "关注";
      } else {
        praiseStr = "取消关注";
      }
      if (curUserPraise == 0) {
        collectImg = "assets/images/invitation_collect.png";
      } else {
        collectImg = "assets/images/invitation_collect_s.png";
      }
    }
    setState(() {});
  }

  @override
  void onInputContent(int type, String content) {
    if (type == 0) {
      //发表文章评论
      ReqQuoteApi.getInstance()
          .publishComment(new CommentCallBack(), topicId, content, "", "");
    }
  }

  publishComment() {
    Navigator.push(context, PopRoute(child: BottomInputDialog(this, 0)));
  }

  void attentPost() {
    int doType = 5;
    if (ifFocus == 0) {
      doType = 5;
    } else {
      doType = 6;
    }
    UiHelpDart.showLoadingDialog();
    ReqQuoteApi.getInstance()
        .praisePost(new attentionCallBack(), topicId, doType);
  }

  onCollPost() {
    int doType = 2;
    if (curUserPraise == 0) {
      doType = 2;
    } else {
      doType = 4;
    }
    UiHelpDart.showLoadingDialog();
    ReqQuoteApi.getInstance()
        .praisePost(new attentionCallBack(), topicId, doType);
  }

  String sharetext = "芯梦网:";
  WeChatScene scened = WeChatScene.SESSION;

  share() {
    shareToWeChat(WeChatShareWebPageModel("http://www.ic2035.com",
            scene: scened, title: sharetext))
        .then((data) {
      //增加金币
      ReqQuoteApi.getInstance()
          .memberXinChange(new ShareBack(), "3", "1", topicId);
    });
  }

  @override
  void dispose() {
    eventBus.fire(InvitationAddEvent());
    eventBus.fire(MainChange3Event(3));
  }

  @override
  Widget build(BuildContext context) {
    double height = 0;
    double temp = 0;
    if (isImage) {
      height = (MediaQuery.of(context).size.width - 40) / 3;
      temp = 0;
    } else {
      height = 0;
      temp = (MediaQuery.of(context).size.width - 40) / 3;
    }

    double textHeight = getHeight(contentStr, context);
    double expandedHeight = textHeight + 295 - temp;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: InvitationDetailTitleBar("", share),
      body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: Offstage(
                  child: IconButton(
                      icon: Image.asset('assets/images/icon_back.png'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                pinned: true,
                floating: true,
                expandedHeight: expandedHeight,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        getHeadWidget(),
                        getArticleWidget(height, textHeight),
                      ],
                    ),
                  ),
                ),
                bottom: MyTabBar(_tabController),
              )
            ];
          },
          body: TabBarView(
              controller: _tabController,
              children: [invitationCommentWidge, mainWidget])),
    );
  }

  Widget getHeadWidget() {
    return Container(
      height: 80,
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: new ClipOval(
              child: CachedNetworkImage(
                errorWidget: (context, url, error) =>
                    new Image.asset("assets/images/head_default_pic.png"),
                imageUrl: photo,
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              contentTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: ResColors.color_font_1_color,
                  fontSize: 16),
            ),
          )),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ActionChip(
              padding: EdgeInsets.all(0),
              label: Container(
                alignment: Alignment.center,
                width: 60,
                height: 30,
                child: Text(
                  praiseStr,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              //点击事件
              onPressed: () {
                attentPost();
              },
              elevation: 0,
              backgroundColor: ResColors.bg_quote_round_game_color,
            ),
          )
        ],
      ),
    );
  }

  Widget getArticleWidget(double height, double textHeight) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: textHeight,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              contentStr,
              style:
                  TextStyle(color: ResColors.color_font_1_color, fontSize: 14),
            ),
          ),
          Offstage(
            offstage: !isImage,
            child: Row(
              children: <Widget>[
                getImageLeftWidget(height),
                getImageWidget(height),
                getImageRightWidget(height)
              ],
            ),
          ),
          Container(
            height: 40,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text(StringUtils.getTimeLine(context, publishTime),
                      style: TextStyle(
                          color: ResColors.color_font_3_color, fontSize: 12)),
                )),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: publishComment,
                  child: Row(
                    children: [
                      Container(
                          height: 15,
                          width: 15,
                          child:
                              Image.asset("assets/images/invitation_msg.png")),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                        child: Text(commentNum,
                            style: TextStyle(
                                color: ResColors.color_font_3_color,
                                fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onCollPost,
                  child: Row(
                    children: [
                      Container(
                          height: 15,
                          width: 15,
                          child: Image.asset(collectImg)),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                        child: Text(praiseNum,
                            style: TextStyle(
                                color: ResColors.color_font_3_color,
                                fontSize: 12)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                color: ResColors.divided_color,
                height: 3,
              ))
            ],
          )
        ],
      ),
    );
  }

  Widget getImageLeftWidget(double height) {
    bool isOff = StringUtils.isEmpty(img1) ? true : false;
    return Expanded(
        child: Container(
      color: isOff ? Colors.white : ResColors.divided_color,
      margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
      height: height,
      child: Offstage(
        offstage: isOff,
        child: CachedNetworkImage(
          imageUrl: img1,
          fit: BoxFit.cover,
        ),
      ),
    ));
  }

  Widget getImageWidget(double height) {
    bool isOff = StringUtils.isEmpty(img2) ? true : false;
    return Expanded(
        child: Container(
      color: isOff ? Colors.white : ResColors.divided_color,
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: height,
      child: Offstage(
        offstage: isOff,
        child: CachedNetworkImage(
          imageUrl: img2,
          fit: BoxFit.cover,
        ),
      ),
    ));
  }

  Widget getImageRightWidget(double height) {
    bool isOff = StringUtils.isEmpty(img3) ? true : false;
    return Expanded(
        child: Container(
      color: isOff ? Colors.white : ResColors.divided_color,
      margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
      height: height,
      child: Offstage(
        offstage: isOff,
        child: CachedNetworkImage(
          imageUrl: img3,
          fit: BoxFit.cover,
        ),
      ),
    ));
  }
}

double getHeight(String text, BuildContext context) {
  var rp = RenderParagraph(
    new TextSpan(
        style: TextStyle(color: ResColors.color_font_1_color, fontSize: 14),
        text: text,
        children: null,
        recognizer: null),
    // important as the user can have increased text on his device
    textScaleFactor: MediaQuery.of(context).textScaleFactor,
    textDirection: TextDirection.ltr,
  );
  var horizontalPaddingSum = 20; // optional
  var width = MediaQuery.of(context).size.width - horizontalPaddingSum;
  var ret = rp.computeMinIntrinsicHeight(width) + 40; //加40高度 上下间距 并避免不全
  return ret;
}
