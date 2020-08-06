import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/UserSayItemEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

import '../MyApplication.dart';

UserSayItemState state;

class UserSayItemWidget extends StatefulWidget {
  UserSayItemData itemData;
  bool isEnd = false;

  UserSayItemWidget(this.itemData, this.isEnd) {}

  @override
  State<StatefulWidget> createState() {
    state = new UserSayItemState();
    return state;
  }
}

class UserSayItemState extends State<UserSayItemWidget>
    implements ResponseCallBack {
  int doType = 0;

  praiseCustomSay() {
    if (!MyApplication.isUserLogin) {
      UiHelpDart.redirectToLoginPage(context);
    } else {
      String commentId = widget.itemData.customId;
      int ifPraise = widget.itemData.ifPraise;
      if (ifPraise == 0) {
        doType = 1;
      } else {
        doType = 0;
      }
      UiHelpDart.showLoadingDialog();
      ReqQuoteApi.getInstance().praiseCustomSay(this, commentId, doType);
    }
  }

  int createTime;
  String nickName = "";
  int ifPraise;
  int praiseNum;
  String text;
  String image = "assets/images/zan_img.png";

  @override
  Widget build(BuildContext context) {
    nickName = StringUtils.getTextEmpty(widget.itemData.nickName);
    text = StringUtils.getTextEmpty(widget.itemData.text);
    createTime = widget.itemData.createTime;
    praiseNum = widget.itemData.praiseNum;
    ifPraise = widget.itemData.ifPraise;
    if (ifPraise == 0) {
      image = "assets/images/zan_img.png";
    } else {
      image = "assets/images/zan_s_img.png";
    }
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(
                      nickName,
                      style: TextStyle(
                          fontSize: 16, color: ResColors.color_font_1_color),
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          StringUtils.getTimeLine(context, createTime),
                          style: TextStyle(
                              color: ResColors.color_font_3_color,
                              fontSize: 14),
                        ),
                      )
                    ],
                  )
                ],
              )),
              GestureDetector(
                onTap: praiseCustomSay,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 20,
                      margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                      child: Image.asset(image),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        minWidth: 20,
                      ),
                      child: Text(
                        praiseNum.toString(),
                        style: TextStyle(
                            color: ResColors.color_font_3_color, fontSize: 14),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style:
                  TextStyle(color: ResColors.color_font_1_color, fontSize: 14),
            ),
          ),
          Offstage(
            offstage: widget.isEnd,
            child: getDivWidget(),
          )
        ],
      ),
    );
  }

  Widget getDivWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: 1,
      color: ResColors.divided_color,
      child: Row(),
    );
  }

  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    BaseBean entity = BaseBean.fromJson(json);
    if (entity != null) {
      if (entity.code == 0) {
        if (doType == 1) {
          widget.itemData.ifPraise = 1;
          widget.itemData.praiseNum = widget.itemData.praiseNum + 1;
        } else {
          widget.itemData.ifPraise = 0;
          widget.itemData.praiseNum = widget.itemData.praiseNum - 1;
          if (widget.itemData.praiseNum < 0) {
            widget.itemData.praiseNum = 0;
          }
        }
        setState(() {});
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}
