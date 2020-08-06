
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/CompanyInfoEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/BaseTitleBar.dart';

CompanyState companyState;

class CompanyPage extends StatefulWidget {
  String compId;

  CompanyPage(this.compId) {}

  @override
  State<StatefulWidget> createState() {
    companyState = new CompanyState();
    return companyState;
  }
}

Future<Null> _refresh() async {
  companyState.getCreateCompInfo();
}

EasyRefreshController _controller = EasyRefreshController();

class PageCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    Map<String, dynamic> json = jsonDecode(var3);
    CompanyInfoEntity entity = CompanyInfoEntity.fromJson(json);
    if (entity != null) {
      if (entity.code == 0) {
        companyState.updateCompanyInfoData(entity.data);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class CompanyState extends State<CompanyPage> {
  CompanyInfoData infoData;

  String logo = "";
  String compName = "";
  String addr = "";
  String remarks = "";
  List<CompanyInfoDataProd> prods = [];

  updateCompanyInfoData(CompanyInfoData data) {
    infoData = data;
    logo = StringUtils.getTextEmpty(data.logo);
    compName = StringUtils.getTextEmpty(data.compName);
    addr = StringUtils.getTextEmpty(data.addr);
    remarks = StringUtils.getTextEmpty(data.remarks);
    prods.clear();
    prods.addAll(data.prods);
    setState(() {});
  }

  @override
  void initState() {
    getCreateCompInfo();
  }

  getCreateCompInfo() {
    ReqQuoteApi.getInstance()
        .getCreateCompInfo(new PageCallBack(), widget.compId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseTitleBar("公司", true),
      backgroundColor: Colors.white,
      body: EasyRefresh(
        header: MaterialHeader(
          backgroundColor: Colors.blue,
        ),
        onRefresh: _refresh,
        enableControlFinishRefresh: true,
        controller: _controller,
        child: Column(
          children: <Widget>[
            getTopWidget(logo, compName, addr),
            getDivWidget(),
            getTagWidget("公司简介"),
            getInfoWidget(remarks),
            getDivWidget(),
            getTagWidget("核心产品"),
            getProductWidget(prods)
          ],
        ),
      ),
    );
  }

  Widget getTopWidget(String logo, String name, String addr) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          child: Container(
            height: 60,
            width: 60,
            child: new ClipOval(
                child: Container(
              child: CachedNetworkImage(
                errorWidget: (context, url, error) =>
                    new Image.asset("assets/images/head_default_pic.png"),
                imageUrl: logo,
                fit: BoxFit.cover,
                height: 60,
                width: 60,
              ),
            )),
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    name,
                    style: TextStyle(
                        color: ResColors.color_font_1_color, fontSize: 16),
                  ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "地址：",
                    style: TextStyle(
                        color: ResColors.color_font_3_color, fontSize: 12),
                  ),
                  Expanded(
                      child: Text(
                    addr,
                    style: TextStyle(
                        color: ResColors.color_font_3_color, fontSize: 12),
                  )),
                ],
              ),
            )
          ],
        )),
//        Container(
//          width: 120,
//          child: ActionChip(
//            //标签文字
//            label: Text(
//              "收藏厂家",
//              style: TextStyle(fontSize: 14, color: Colors.blue),
//            ),
//            //点击事件
//            onPressed: () {},
//            elevation: 0,
//            backgroundColor: ResColors.color_bg_color,
//          ),
//        )
      ],
    );
  }

  Widget getDivWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
      height: 1,
      color: ResColors.divided_color,
      child: Row(),
    );
  }

  Widget getTagWidget(String tag) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 3,
            height: 20,
            color: ResColors.bg_quote_round_simtrade_color,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              tag,
              style: TextStyle(
                  color: ResColors.color_font_1_color,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget getInfoWidget(String info) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Text(info),
    );
  }

  Widget getProductWidget(List<CompanyInfoDataProd> prods) {
    return GridView.builder(
        itemCount: prods.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
          crossAxisCount: 4,
          //纵轴间距
          mainAxisSpacing: 0.0,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (BuildContext context, int index) {
          CompanyInfoDataProd infoDataProd = prods[index];
          String name = StringUtils.getTextEmpty(infoDataProd.prodName);
          String url = StringUtils.getTextEmpty(infoDataProd.prodImg);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              UiHelpDart.redirectToDetailPage(context, infoDataProd.prodId);
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  new Container(
                      height: 60,
                      width: 60,
                      color: ResColors.divided_color,
                      child: CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                        height: 60,
                        width: 60,
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
