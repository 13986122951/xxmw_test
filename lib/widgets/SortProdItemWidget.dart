import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/bean/ProdsCateEntity.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

bool isEnd = false;
String dengJi = "";
String xinHao = "";
String imgPath = "";
String danWei = "";
String title = "";
String pid = "";

class SortProdItemWidget extends StatefulWidget {
  SortProdItemWidget(bool isEnds, ProdsCateDataProdmap dataNewprod) {
    isEnd = isEnds;
    if (dataNewprod != null) {
      dengJi = dataNewprod.grade;
      xinHao = dataNewprod.xinHao;
      danWei = dataNewprod.createComp;
      title = dataNewprod.prodName;
      imgPath = dataNewprod.prodImg;
      pid = dataNewprod.prodId;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return SortProdItemState();
  }
}

class SortProdItemState extends State<SortProdItemWidget> {
  void collect() {}

  void addBom() {}

  void down() {}

  @override
  Widget build(BuildContext context) {
    if (StringUtils.isEmpty(dengJi)) {
      dengJi = "";
    }
    if (StringUtils.isEmpty(xinHao)) {
      xinHao = "";
    }
    if (StringUtils.isEmpty(danWei)) {
      danWei = "";
    }
    if (StringUtils.isEmpty(title)) {
      title = "";
    }

    return GestureDetector(
      onTap: () {
        UiHelpDart.redirectToDetailPage(context, pid);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
            height: 82,
            child: Row(
              children: <Widget>[
                Container(
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
                )),
                Offstage(
                  offstage: true,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: collect,
                        child: Container(
                          alignment: Alignment.topCenter,
                          width: 30,
                          height: 27,
                          child: Container(
                            height: 18,
                            child:
                                Image.asset("assets/images/detail_collect.png"),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: addBom,
                        child: Container(
                          alignment: Alignment.center,
                          width: 30,
                          height: 27,
                          child: Container(
                            height: 18,
                            child: Image.asset(
                                "assets/images/prodect_list_add.png"),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: down,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          width: 30,
                          height: 27,
                          child: Container(
                            height: 18,
                            child: Image.asset(
                                "assets/images/prodect_list_down.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          getDivWidget()
        ],
      ),
    );
  }

  Widget getDivWidget() {
    if (!isEnd) {
      return Row(
        children: <Widget>[
          Expanded(
              child: Container(
            height: 1,
            color: ResColors.divided_color,
          ))
        ],
      );
    } else {
      return Container();
    }
  }
}
