import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/BBSBeanEntity.dart';
import 'package:xmw_shop/bean/HomePageEntity.dart';
import 'package:xmw_shop/bean/TopicPostListEntity.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/widgets/BannerWidget.dart';
import 'package:xmw_shop/widgets/HotBBSItemWidget.dart';
import 'package:xmw_shop/widgets/MainBBSTitleBar.dart';

import 'BaseDart.dart';

BBSState pageState = new BBSState();
int recordNum = 1;
int pageSize = 30;
int postType = 1;
bool isMore = false;
bool isRefresh = true;
List<TopicPostListData> list = [];

class BBSPage extends BaseDart {
  @override
  State<StatefulWidget> initbuild() {
    getAppSupriseData();
    return pageState;
  }
}

List<BBSBeanDataComnavlist> knowlist = [];
List<BBSBeanDataComnavlist> exchangeList = [];
BBSBeanEntity entity;

getAppSupriseData() {
  ReqQuoteApi.getInstance().getCommunicates(new PageCallBack());
  ReqQuoteApi.getInstance()
      .getTopicPostsPage(new InfoCallBack(), "", recordNum, pageSize, postType);
}

Future<Null> _refresh() async {
  recordNum = 1;
  isRefresh = true;
  getAppSupriseData();
}

Future<Null> _onload() async {
  isRefresh = false;
  getAppSupriseData();
}

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
    entity = BBSBeanEntity.fromJson(json);
    if (entity != null) {
      if (entity.code == 0) {
        pageState.upData(entity);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class InfoCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    Map<String, dynamic> json = jsonDecode(var3);
    TopicPostListEntity baseBean = TopicPostListEntity.fromJson(json);
    if (baseBean != null && baseBean.code == 0) {
      if (isRefresh) {
        list.clear();
      }
      list.addAll(baseBean.data);
      if (baseBean.data.length == pageSize) {
        isMore = true;
        recordNum += 1;
      } else {
        isMore = false;
      }
      pageState.updateList();
    }
  }
}

EasyRefreshController _controller = EasyRefreshController();

class BBSState extends State<BBSPage> {
  List<HomePageDataFowbanner> bannerList = [];
  BBSBeanEntity entity;

  upData(BBSBeanEntity entity) {
    this.entity = entity;
    bannerList.clear();
    knowlist.clear();
    exchangeList.clear();
    if (entity.data != null) {
      if (entity.data.comNavList != null) {
        for (int i = 0; i < entity.data.comNavList.length; i++) {
          BBSBeanDataComnavlist item = entity.data.comNavList[i];
          HomePageDataFowbanner banner = new HomePageDataFowbanner();
          banner.imgPath = item.imgPath;
          banner.pkId = item.pkId;
          banner.title = item.funcName;
          bannerList.add(banner);
        }
      }
      if (entity.data.knowList != null) {
        knowlist.addAll(entity.data.knowList);
      }
      if (entity.data.exchangeList != null) {
        exchangeList.addAll(entity.data.exchangeList);
      }
    }

    setState(() {});
  }

  updateList() {
    setState(() {});
  }

  StreamSubscription loginSubscription;

  @override
  void initState() {
    super.initState();
    loginSubscription = eventBus.on<MainChange3Event>().listen((event) {
      recordNum = 1;
      isRefresh = true;
      getAppSupriseData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    loginSubscription.cancel();
  }

  bool isShowPoint = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width * 143 / 360;
    if (bannerList != null && bannerList.length > 1) {
      isShowPoint = true;
    } else {
      isShowPoint = false;
    }
    return Scaffold(
      appBar: MainBBSTitleBar(),
      backgroundColor: Colors.white,
      body: EasyRefresh(
        header: MaterialHeader(
          backgroundColor: Colors.blue,
        ),
        footer: MaterialFooter(
          backgroundColor: Colors.blue,
        ),
        onRefresh: _refresh,
        onLoad: isMore ? _onload : null,
        enableControlFinishRefresh: true,
        controller: _controller,
        child: Column(
          children: <Widget>[
            new BannerWidget(height, bannerList, isShowPoint),
            getDivWidget(),
            getTagWidget("知识社区"),
            getSortWidget(knowlist),
            getDivWidget(),
            getTagWidget("交流社区"),
            getSortWidget(exchangeList),
            getDivWidget(),
            getTagWidget("热门推荐"),
            getHotBBSWidget(),
          ],
        ),
      ),
    );
  }

  Widget getDivWidget() {
    return Container(
      height: 1,
      color: ResColors.divided_color,
      child: Row(),
    );
  }

  Widget getTagWidget(String tag) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
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
              style:
                  TextStyle(color: ResColors.color_font_1_color, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }

  Widget getSortWidget(List<BBSBeanDataComnavlist> menuBeans) {
    return GridView.builder(
        itemCount: menuBeans.length,
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
          return getMenuWidgets(menuBeans[index]);
        });
  }

  Widget getMenuWidgets(BBSBeanDataComnavlist menuBeans) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        UiHelpDart.redirectToInvitationPage(context, menuBeans.pkId);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: CachedNetworkImage(
              errorWidget: (context, url, error) =>
                  new Image.asset("assets/images/radio_default_cover.png"),
              imageUrl: menuBeans.imgPath,
              fit: BoxFit.cover,
              height: 40,
              width: 40,
            ),
          ),
          Container(
            child: Text(
              menuBeans.funcName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 12, color: ResColors.color_font_3_color),
            ),
          )
        ],
      ),
    );
  }

  Widget getHotBBSWidget() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return HotBBSItemWidget(list[index]);
        });
  }
}
