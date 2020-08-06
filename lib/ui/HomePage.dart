
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/HomePageEntity.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/Constants.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/widgets/BannerWidget.dart';
import 'package:xmw_shop/widgets/HomeRemItemWidget.dart';
import 'package:xmw_shop/widgets/HomeTitleBar.dart';
import 'package:xmw_shop/widgets/MainSortItem.dart';

HomePageState pageState = new HomePageState();
bool isHomeInit = true;

///首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return pageState;
  }
}

getAppSupriseData() {
  ReqQuoteApi.getInstance().getIndexInfo(new HomeCallBack());
}

Future<Null> _refresh() async {
  getAppSupriseData();
}

class HomeCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    Map<String, dynamic> json = jsonDecode(var3);
    HomePageEntity entity = HomePageEntity.fromJson(json);
    if (entity != null) {
      if (entity.code == 0) {
        pageState.upData(entity);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

String searchStr = "元器件";
EasyRefreshController _controller = EasyRefreshController();

class HomePageState extends State<HomePage> {
  List<HomePageDataFowbanner> bannerList = [];
  List<HomePageDataProductcate> productCate = [];
  List<HomePageDataNewprod> newProd = [];
  List<HomePageDataNewprod> hotProd = [];
  List<HomePageDataAllpartner> allPartner = [];
  HomePageDataFlownotice flownotice;
  bool isShowPoint = false;

  upData(HomePageEntity entity) {
    bannerList.clear();
    bannerList.addAll(entity.data.fowBanner);
    productCate.clear();
    productCate.addAll(entity.data.productCate);
    newProd.clear();
    newProd.addAll(entity.data.newProd);
    hotProd.clear();
    hotProd.addAll(entity.data.hotProd);
    allPartner.clear();
    allPartner.addAll(entity.data.allPartner);
    List<HomePageDataFlownotice> flowNotice = entity.data.flowNotice;
    if (flowNotice != null && flowNotice.length > 0) {
      flownotice = flowNotice[0];
    }
    if (bannerList != null && bannerList.length > 1) {
      isShowPoint = true;
    } else {
      isShowPoint = false;
    }
    setState(() {});
  }

  upDate() {
    setState(() {});
  }

  @override
  void initState() {
    getAppSupriseData();
  }

  mainSort() {
    eventBus.fire(MainChange2Event(1));
  }

  recommendMore() {
    UiHelpDart.redirectToSortPage(context, "新品推荐", "", 2);
  }

  hotMore() {
    UiHelpDart.redirectToSortPage(context, "热门产品", "", 1);
  }

  GlobalKey anchorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width * 143 / 360;
    return Scaffold(
      appBar: HomeTitleBar(anchorKey),
      backgroundColor: Colors.white,
      body: Container(
        key: anchorKey,
        child: EasyRefresh(
          header: MaterialHeader(
            backgroundColor: Colors.blue,
          ),
          footer: MaterialFooter(
            backgroundColor: Colors.blue,
          ),
          onRefresh: _refresh,
          enableControlFinishRefresh: true,
          controller: _controller,
          child: Column(
            children: <Widget>[
              new BannerWidget(height, bannerList, isShowPoint),
              getNoticeWidget(),
              getDivWidget(),
              getTagWidget("产品分类", mainSort, true),
              getSortWidget(),
              getDivWidget(),
              getTagWidget("新品推荐", recommendMore, true),
              getRecommendWidget(),
              getDivWidget(),
              getTagWidget("热门产品", hotMore, true),
              getHotWidget(),
              getDivWidget(),
              getTagWidget("合作伙伴", mainSort, false),
              getCompanyWidget(),
              getServiceWidget(),
            ],
          ),
        ),
      ),
    );
  }

  String notice = "";

  Widget getNoticeWidget() {
    if (flownotice != null && !StringUtils.isEmpty(flownotice.title)) {
      notice = flownotice.title;
    }

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 20,
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Image.asset("assets/images/home_notice_img.png"),
          ),
          Text(
            "公告：",
            style: TextStyle(color: ResColors.color_font_1_color, fontSize: 12),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40.0,
              child: Text(
                notice,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: ResColors.color_font_1_color, fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getTagWidget(String title, onClck, bool visible) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
      child: new Row(
        children: <Widget>[
          Container(
            width: 3,
            height: 20,
            color: ResColors.bg_quote_round_simtrade_color,
          ),
          new Container(
            child: new Text(
              title,
              style:
                  TextStyle(color: ResColors.color_font_1_color, fontSize: 18),
            ),
            height: 40,
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          ),
          Flexible(
              child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Offstage(
                offstage: !visible,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onClck,
                  child: Row(
                    children: <Widget>[
                      new Container(
                        child: new Text(
                          "更多",
                          style: TextStyle(
                              color: ResColors.color_1_color, fontSize: 14),
                        ),
                        height: 40,
                        alignment: Alignment.center,
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        height: 15,
                        width: 15,
                        child: Image.asset("assets/images/home_more_img.png"),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }

  Widget getSortWidget() {
    return GridView.builder(
        itemCount: productCate.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
          crossAxisCount: 4,
          //纵轴间距
          mainAxisSpacing: 0.0,
          //横轴间距
          crossAxisSpacing: 0.0, childAspectRatio: 7 / 6,
        ),
        itemBuilder: (BuildContext context, int index) {
          //Widget Function(BuildContext context, int index)
          return MainSortItem(productCate[index]);
        });
  }

  Widget getRecommendWidget() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: newProd.length,
      itemBuilder: (BuildContext context, int index) {
        return HomeRemItemWidget(
            true, (index + 1) == newProd.length, newProd[index]);
      },
    );
  }

  Widget getHotWidget() {
    return Container(
      height: 110,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: ListView.builder(
        itemCount: hotProd.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              UiHelpDart.redirectToDetailPage(context, hotProd[index].pkId);
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(3, 0, 3, 5),
                    child: CachedNetworkImage(
                      errorWidget: (context, url, error) => new Image.asset(
                          "assets/images/radio_default_cover.png"),
                      imageUrl: hotProd[index].imgPath,
                      fit: BoxFit.cover,
                      height: 60,
                      width: 84,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 84,
                    child: Text(
                      hotProd[index].title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: ResColors.color_font_1_color, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getCompanyWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: GridView.builder(
          itemCount: allPartner.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 4,
            //纵轴间距
            mainAxisSpacing: 0.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            //Widget Function(BuildContext context, int index)
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                UiHelpDart.redirectToCompanyPage(
                    context, allPartner[index].pkId);
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      child: new ClipOval(
                          child: Container(
                        child: CachedNetworkImage(
                          errorWidget: (context, url, error) => new Image.asset(
                              "assets/images/head_default_pic.png"),
                          imageUrl: allPartner[index].imgPath,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                      alignment: Alignment.center,
                      child: Text(allPartner[index].title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: ResColors.color_font_1_color,
                              fontSize: 12)),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget getServiceWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 60,
            margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
            child: new ClipRRect(
              child: new Container(
                color: ResColors.home_service_bg_color,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      width: 36,
                      height: 36,
                      child: Image.asset("assets/images/home_service_tel.png"),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "客服热线",
                            style: TextStyle(
                                color: ResColors.color_font_1_color,
                                fontSize: 12),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        ),
                        Container(
                          child: Text(Constants.SERVICE_PHONE),
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        )
                      ],
                    )
                  ],
                ),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            height: 60,
            margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
            child: new ClipRRect(
              child: new Container(
                color: ResColors.home_service_bg_color,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      width: 36,
                      height: 36,
                      child: Image.asset("assets/images/home_service_wx.png"),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text("公众号",
                              style: TextStyle(
                                  color: ResColors.color_font_1_color,
                                  fontSize: 12)),
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        ),
                        Container(
                          child: Text("401-410-400"),
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        )
                      ],
                    )
                  ],
                ),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          flex: 1,
        )
      ],
    );
  }

  Widget getDivWidget() {
    return Container(
      height: 1,
      color: ResColors.divided_color,
      child: Row(),
    );
  }
}