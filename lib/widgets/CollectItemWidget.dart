import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/bean/MyCollectItemEntity.dart';
import 'package:xmw_shop/common/InputCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

class CollectItemWidget extends StatefulWidget {
  bool isEnd = false;
  bool offstage = true;
  MyCollectItemData dataNewprod;
  String dengJi = "";
  String xinHao = "";
  String imgPath = "";
  String danWei = "";
  String title = "";
  String pid = "";
  bool check = false;
  InputCallBack callBack;

  CollectItemWidget(
      this.isEnd, MyCollectItemData dataNewprod, this.offstage, this.callBack) {
    if (dataNewprod != null) {
      dengJi = dataNewprod.dengJi;
      xinHao = dataNewprod.xinHao;
      danWei = dataNewprod.danWei;
      title = dataNewprod.title;
      imgPath = dataNewprod.imgPath;
      pid = dataNewprod.prodId;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return CollectState();
  }
}

class CollectState extends State<CollectItemWidget> {
  @override
  Widget build(BuildContext context) {
    if (StringUtils.isEmpty(widget.dengJi)) {
      widget.dengJi = "";
    }
    if (StringUtils.isEmpty(widget.xinHao)) {
      widget.xinHao = "";
    }
    if (StringUtils.isEmpty(widget.danWei)) {
      widget.danWei = "";
    }
    if (StringUtils.isEmpty(widget.title)) {
      widget.title = "";
    }

    return GestureDetector(
      onTap: () {
        UiHelpDart.redirectToDetailPage(context, widget.pid);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
            height: 82,
            child: Row(
              children: <Widget>[
                Offstage(
                  offstage: widget.offstage,
                  child: new Checkbox(
                    value: widget.check,
                    activeColor: Colors.blue,
                    onChanged: (bool val) {
                      widget.check = !widget.check;
                      if (widget.check) {
                        widget.callBack.onInputContent(1, widget.pid);
                      } else {
                        widget.callBack.onInputContent(0, widget.pid);
                      }
                      setState(() {});
                    },
                  ),
                ),
                Container(
                  height: 82,
                  width: 110,
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) => new Image.asset(
                        "assets/images/radio_default_cover.png"),
                    imageUrl: widget.imgPath,
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
                                child: Text(widget.title,
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
                                child: Text(widget.xinHao,
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
                                child: Text(widget.dengJi,
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
                                child: Text(widget.danWei,
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
    );
  }

  Widget getDivWidget() {
    if (!widget.isEnd) {
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
