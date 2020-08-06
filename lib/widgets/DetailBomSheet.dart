import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/ProdDetailEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';

DetailBomSheetState sheetState;

class DetailBomSheet extends StatefulWidget {
  ProdDetailData detailData;
  String pid;

  DetailBomSheet(this.detailData, this.pid) {}

  @override
  State<StatefulWidget> createState() {
    sheetState = new DetailBomSheetState();
    return sheetState;
  }
}

class addCallBack implements ResponseCallBack {
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
      if (entity != null && entity.code == 0) {
        UiHelpDart.showToast("添加成功");
        sheetState.updata();
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class DetailBomSheetState extends State<DetailBomSheet> {
  int bomNum = 1;
  String prodName = "";
  String xinHaoGuiGe = "";
  int remainNum = 0; //库存量
  String prodCode = "";

  void addProdToBom() {
    UiHelpDart.showLoadingDialog();
    ReqQuoteApi.getInstance()
        .addProdToBom(new addCallBack(), widget.pid, bomNum.toString());
  }

  updata() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    if (widget.detailData != null) {
      prodName = StringUtils.getTextEmpty(widget.detailData.prodName);
      xinHaoGuiGe = StringUtils.getTextEmpty(widget.detailData.xinHaoGuiGe);
      remainNum = widget.detailData.remainNum;
      prodCode = StringUtils.getTextEmpty(widget.detailData.prodCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                height: 100,
                child: Column(
                  children: <Widget>[
                    getBomItem("型    号：", xinHaoGuiGe),
                    getBomItem("名    称：", prodName),
                    getBomItem("库    存：", remainNum.toString()),
                    getBomItem("编    码：", prodCode),
                  ],
                ),
              )),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 20,
                  height: 20,
                  child: Image.asset("assets/images/shanchu.png"),
                ),
                onTap: () {
                  Navigator.pop(context, '取消');
                },
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                height: 30,
                margin: EdgeInsets.all(10),
                child: Text("数量"),
              )),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  bomNum--;
                  if (bomNum < 1) {
                    bomNum = 1;
                  }
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  color: ResColors.color_font_3_color,
                  width: 30,
                  height: 30,
                  child: Text("-"),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(1, 0, 1, 0),
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  minWidth: 50,
                ),
                height: 30,
                color: ResColors.color_font_3_color,
                child: Text(bomNum.toString()),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  bomNum++;
                  print(bomNum);
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  alignment: Alignment.center,
                  color: ResColors.color_font_3_color,
                  width: 30,
                  height: 30,
                  child: Text("+"),
                ),
              )
            ],
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new RaisedButton(
                    onPressed: addProdToBom,
                    //通过控制 Text 的边距来控制控件的高度
                    child: new Padding(
                      padding: new EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 15.0),
                      child: new Text(
                        "加入BOM清单",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    elevation: 0,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getBomItem(String title, String content) {
    return Container(
      height: 25,
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              title,
              style: TextStyle(color: ResColors.color_font_3_color),
            ),
          ),
          Expanded(
              child: Container(
            child: Text(
              content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ))
        ],
      ),
    );
  }
}
