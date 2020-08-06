import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/bean/TopicPostListEntity.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

class HotBBSItemWidget extends StatelessWidget {
  TopicPostListData listData;
  String photo = "";
  String postTitle = "";
  String contentHead = "";
  int commentNum = 0;
  int praiseNum = 0;

  HotBBSItemWidget(this.listData) {
    photo = StringUtils.getTextEmpty(listData.photo);
    postTitle = StringUtils.getTextEmpty(listData.postTitle);
    contentHead = StringUtils.getTextEmpty(listData.contentHead);
    commentNum = listData.commentNum;
    praiseNum = listData.praiseNum;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          UiHelpDart.redirectToInvitationDetailPage(context, listData.postId);
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 35,
                    width: 35,
                    child: new ClipOval(
                      child: CachedNetworkImage(
                        errorWidget: (context, url, error) => new Image.asset(
                            "assets/images/head_default_pic.png"),
                        imageUrl: photo,
                        fit: BoxFit.cover,
                        height: 35,
                        width: 35,
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
                              postTitle,
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
                              contentHead,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
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
                                StringUtils.getTimeLine(
                                    context, listData.publishTimes),
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
                            child: Text(commentNum.toString(),
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
                    ],
                  ))
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: ResColors.divided_color,
                  height: 1,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
