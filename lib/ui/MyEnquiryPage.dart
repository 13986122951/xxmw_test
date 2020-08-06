import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/MyEnquiryEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/BaseTitleBar.dart';

MyEnquiryState pageState;

//我的询价单
class MyEnquiryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    pageState = new MyEnquiryState();
    return pageState;
  }
}

Future<Null> _refresh() async {
  myAllInquiries();
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
    MyEnquiryEntity entity = MyEnquiryEntity.fromJson(json);
    if (entity != null) {
      if (entity != null && entity.code == 0 && entity.data != null) {
        pageState.upData(entity.data);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

myAllInquiries() {
  ReqQuoteApi.getInstance().myAllInquiries(new CallBack());
}

EasyRefreshController _controller = EasyRefreshController();

class MyEnquiryState extends State<MyEnquiryPage> {
  List<MyEnquiryData> list = [];

  upData(List<MyEnquiryData> data) {
    list.clear();
    list.addAll(data);
    setState(() {});
  }

  @override
  void initState() {
    UiHelpDart.showLoadingDialog();
    myAllInquiries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseTitleBar("我的询价单", true),
      backgroundColor: Colors.white,
      body: Container(
        color: ResColors.divided_color,
        child: EasyRefresh(
          header: MaterialHeader(
            backgroundColor: Colors.blue,
          ),
          footer: MaterialFooter(
            backgroundColor: Colors.blue,
          ),
          enableControlFinishRefresh: true,
          controller: _controller,
          onRefresh: _refresh,
          child: getHotBBSWidget(list),
        ),
      ),
    );
  }

  Widget getHotBBSWidget(List<MyEnquiryData> data) {
    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return EnquiryItem(list[index], (index + 1) == list.length);
        });
  }
}

class EnquiryItem extends StatelessWidget {
  String title = "";
  int total = 0;
  String imgPath = "";
  String bomRemarks = "";
  int createTime = 0;
  bool isEnd = false;
  String pkId;

  EnquiryItem(MyEnquiryData data, this.isEnd) {
    title = StringUtils.getTextEmpty(data.bomName);
    imgPath = StringUtils.getTextEmpty(data.img);
    bomRemarks = StringUtils.getTextEmpty(data.bomRemarks);
    total = data.total;
    createTime = data.createTime;
    pkId = data.pkId;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!StringUtils.isEmpty(pkId)) {
          UiHelpDart.redirectToMyEnquiryDetailPage(context, pkId);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
              height: 82,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 82,
                    width: 110,
                    child: CachedNetworkImage(
                      errorWidget: (context, url, error) => new Image.asset(
                          "assets/images/radio_default_cover.png"),
                      imageUrl: imgPath,
                      fit: BoxFit.cover,
                      height: 82,
                      width: 110,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "名    称：",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ResColors.color_font_1_color),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  child: Text(title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ResColors.color_font_1_color)),
                                ))
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text("总数量：",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ResColors.color_font_1_color)),
                                ),
                                Expanded(
                                    child: Container(
                                  child: Text(total.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ResColors.color_font_1_color)),
                                ))
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text("备    注：",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ResColors.color_font_1_color)),
                                ),
                                Expanded(
                                    child: Container(
                                  child: Text(bomRemarks,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ResColors.color_font_1_color)),
                                ))
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text("时    间：",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ResColors.color_font_1_color)),
                                ),
                                Expanded(
                                    child: Container(
                                  child: Text(
                                      StringUtils.getTimeLine(
                                          context, createTime),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ResColors.color_font_1_color)),
                                ))
                              ],
                            ))
                      ],
                    ),
                  ))
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  height: 1,
                  color: ResColors.divided_color,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
