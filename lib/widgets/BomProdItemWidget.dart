import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/bean/BomProdListEntity.dart';
import 'package:xmw_shop/bean/ProdsCateEntity.dart';
import 'package:xmw_shop/common/InputCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

class BomProdItemWidget extends StatefulWidget {
  bool isEnd = false;
  BomProdListDataProdlist dataNewprod;
  bool check = false;
  InputCallBack callBack;
  bool offstage = true;

  BomProdItemWidget(
      this.isEnd, this.dataNewprod, this.offstage, this.callBack) {}

  @override
  State<StatefulWidget> createState() {
    return SortProdItemState();
  }
}

class SortProdItemState extends State<BomProdItemWidget> {
  String dengJi = "";
  String xinHao = "";
  String imgPath = "";
  String danWei = "";
  String title = "";
  String pid = "";

  @override
  void initState() {
    if (widget.dataNewprod != null) {
      dengJi = widget.dataNewprod.grade;
      xinHao = widget.dataNewprod.xinHao;
      danWei = widget.dataNewprod.createCom;
      title = widget.dataNewprod.prodName;
      imgPath = widget.dataNewprod.imgPath;
      pid = widget.dataNewprod.prodId;
    }
  }

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
                Offstage(
                  offstage: widget.offstage,
                  child: new Checkbox(
                    value: widget.check,
                    activeColor: Colors.blue,
                    onChanged: (bool val) {
                      widget.check = !widget.check;
                      if (widget.check) {
                        widget.callBack
                            .onInputContent(1, widget.dataNewprod.prodId);
                      } else {
                        widget.callBack
                            .onInputContent(0, widget.dataNewprod.prodId);
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
