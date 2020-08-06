import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/bean/HomePageEntity.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

class HomeRemItemWidget extends StatelessWidget {
  bool isHome = true;
  bool isEnd = true;
  HomePageDataNewprod dataNewprod;
  String dengJi = "";
  String xinHao = "";
  String imgPath = "";
  String danWei = "";
  String title = "";
  String pid = "";

  HomeRemItemWidget(this.isHome, this.isEnd, this.dataNewprod) {
    if (dataNewprod != null) {
      dengJi = StringUtils.getTextEmpty(dataNewprod.dengJi);
      xinHao = StringUtils.getTextEmpty(dataNewprod.xinHao);
      danWei = StringUtils.getTextEmpty(dataNewprod.danWei);
      title = StringUtils.getTextEmpty(dataNewprod.title);
      imgPath = StringUtils.getTextEmpty(dataNewprod.imgPath);
      pid = StringUtils.getTextEmpty(dataNewprod.pkId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          UiHelpDart.redirectToDetailPage(context, pid);
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
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
                                    "产品名称：",
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
                                  child: Text("产品型号：",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ResColors.color_font_1_color)),
                                ),
                                Expanded(
                                    child: Container(
                                  child: Text(xinHao,
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
                                  child: Text("生产等级：",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ResColors.color_font_1_color)),
                                ),
                                Expanded(
                                    child: Container(
                                  child: Text(dengJi,
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
                                  child: Text("生产单位：",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ResColors.color_font_1_color)),
                                ),
                                Expanded(
                                    child: Container(
                                  child: Text(danWei,
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
            getDivWidget()
          ],
        ),
      ),
    );
  }

  Widget getDivWidget() {
    if (!isEnd) {
      if (isHome) {
        return Row(
          children: <Widget>[
            Expanded(
                child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: 1,
              color: ResColors.divided_color,
            ))
          ],
        );
      } else {
        return Row(
          children: <Widget>[
            Expanded(
                child: Container(
              height: 1,
              color: ResColors.divided_color,
            ))
          ],
        );
      }
    } else {
      return Container();
    }
  }
}
