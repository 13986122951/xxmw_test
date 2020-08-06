import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:fluwx_no_pay/fluwx_no_pay.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/bean/ProdDetailEntity.dart';
import 'package:xmw_shop/bean/UserSayItemEntity.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/DetailBomSheet.dart';
import 'package:xmw_shop/widgets/DetailTitleBar.dart';
import 'package:xmw_shop/widgets/UserSayItemWidget.dart';

import '../MyApplication.dart';
import 'BaseDart.dart';

DetailState pageState;

class DetailPage extends BaseDart {
  String pid;

  DetailPage(this.pid) {}

  @override
  State<StatefulWidget> initbuild() {
    pageState = new DetailState();
    return pageState;
  }
}

class HomeCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    _controller.finishRefresh(success: true);
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    _controller.finishRefresh(success: true);
    Map<String, dynamic> json = jsonDecode(var3);
    ProdDetailEntity entity = ProdDetailEntity.fromJson(json);
    if (entity != null && entity.code == 0 && entity.data != null) {
      pageState.upData(entity.data);
    }
  }
}

class CancelCallBack implements ResponseCallBack {
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
        pageState.updateFavour(0);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class DownCallBack implements ResponseCallBack {
  String downUrl;

  DownCallBack(String url) {
    downUrl = url;
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
      if (entity != null && entity.code == 0) {
        Clipboard.setData(ClipboardData(text: downUrl));
        UiHelpDart.showToast("下载地址已复制到剪切板，请在浏览器打开下载");
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
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
        pageState.updateFavour(1);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class CallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    Map<String, dynamic> json = jsonDecode(var3);
    UserSayItemEntity entity = UserSayItemEntity.fromJson(json);
    if (entity != null) {
      if (entity.code == 0 && entity.data != null) {
        pageState.upDataUserSayItemData(entity.data);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class ShareBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {}

  @override
  void onSuccess(String var3) {}
}

customUseSay(String pid) {
  ReqQuoteApi.getInstance().customUseSay(new CallBack(), pid, 1, 2);
}

getProdDetailById(String pid) {
  ReqQuoteApi.getInstance().getProdDetailById(new HomeCallBack(), pid);
}

memberXinChange(String downUrl, String pid) {
  ReqQuoteApi.getInstance()
      .memberXinChange(new DownCallBack(downUrl), "6", "2", pid);
}

EasyRefreshController _controller = EasyRefreshController();

class DetailState extends State<DetailPage> {
  String sharetext = "芯梦网:";
  WeChatScene scened = WeChatScene.SESSION;

  share(String pid) {
    shareToWeChat(WeChatShareWebPageModel("http://www.ic2035.com",
            scene: scened, title: sharetext))
        .then((data) {
      //增加金币
      ReqQuoteApi.getInstance().memberXinChange(new ShareBack(), "3", "1", pid);
    });
  }

  Future<Null> _refresh() async {
    getProdDetailById(widget.pid);
    customUseSay(widget.pid);
  }

  double liveImgHeight = 50, liveImgWidth;
  String collectImg = "assets/images/detail_collect.png";

  Future _openModalBottomSheet() async {
    final option = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DetailBomSheet(_detailData, widget.pid);
        });
  }

  void showBoom() {
    if (!MyApplication.isUserLogin) {
      UiHelpDart.redirectToLoginPage(context);
      return;
    }
    _openModalBottomSheet();
  }

  List<UserSayItemData> prodMap = [];

  upDataUserSayItemData(List<UserSayItemData> data) {
    prodMap.clear();
    prodMap.addAll(data);
    setState(() {});
  }

  downBook() {
    if (!StringUtils.isEmpty(downHref)) {
      UiHelpDart.showAlertDialog(context, confirm, "是否消耗2金币下载使用手册？");
    }
  }

  downOnClick() {
    if (!StringUtils.isEmpty(downHref)) {
      UiHelpDart.showAlertDialog(context, confirm, "是否消耗2金币下载使用手册？");
    }
  }

  shareOnClick() {
    share(widget.pid);
  }

  confirm() {
    if (!StringUtils.isEmpty(downHref)) {
      UiHelpDart.redirectToBackPage(context);
      memberXinChange(downHref, widget.pid);
    }
  }

  String prodImg = "";
  String prodName = "";
  String factoryName = "";
  String bigCateName = "";
  String smallCateName = "";
  String xinHaoGuiGe = "";
  String qualityGrade = "";
  String prodCode = "";
  String costPrice = "";
  String tempRange = "";
  String staticElectric = "";
  String radix = "";
  String authOrg = "";
  String devStand = "";
  String elemNorm = "";
  String mainFun = "";
  String doMain = "";
  String fillMethod = "";
  List<Map> info = [];
  int ifFavour = 0; //1收藏
  ProdDetailData _detailData;
  String factory = "";
  int docUploadDate = 0; //产品手册上传日期
  String docSize = ""; //产品手册大小
  String downHref = ""; //产品手册下载地址
  bool isUserBook = false;

  upData(ProdDetailData detailData) {
    _detailData = detailData;
    prodImg = StringUtils.getTextEmpty(detailData.prodImg);
    prodName = StringUtils.getTextEmpty(detailData.prodName);
    factoryName = StringUtils.getTextEmpty(detailData.factoryName);
    bigCateName = StringUtils.getTextEmpty(detailData.bigCateName);
    smallCateName = StringUtils.getTextEmpty(detailData.smallCateName);
    xinHaoGuiGe = StringUtils.getTextEmpty(detailData.xinHaoGuiGe);
    qualityGrade = StringUtils.getTextEmpty(detailData.qualityGrade);
    prodCode = StringUtils.getTextEmpty(detailData.prodCode);
    costPrice = StringUtils.getTextEmpty(detailData.costPrice);
    tempRange = StringUtils.getTextEmpty(detailData.tempRange);
    staticElectric = StringUtils.getTextEmpty(detailData.staticElectric);
    radix = StringUtils.getTextEmpty(detailData.radix);
    authOrg = StringUtils.getTextEmpty(detailData.authOrg);
    devStand = StringUtils.getTextEmpty(detailData.devStand);
    elemNorm = StringUtils.getTextEmpty(detailData.elemNorm);
    sharetext = sharetext + prodName;

    mainFun = StringUtils.getTextEmpty(detailData.mainFun);
    doMain = StringUtils.getTextEmpty(detailData.doMain);
    fillMethod = StringUtils.getTextEmpty(detailData.fillMethod);
    factory = StringUtils.getTextEmpty(detailData.xFactory);
    info = detailData.mainParam;
    ifFavour = detailData.ifFavour;
    docSize = detailData.docSize;
    docUploadDate = detailData.docUploadDate;
    downHref = StringUtils.getTextEmpty(detailData.downHref);
    if (!StringUtils.isEmpty(docSize) && !StringUtils.isEmpty(downHref)) {
      isUserBook = true;
    } else {
      isUserBook = false;
    }

    if (ifFavour == 1) {
      collectImg = "assets/images/detail_collect_s.png";
    } else {
      collectImg = "assets/images/detail_collect.png";
    }
    setState(() {});
  }

  updateFavour(int ifFavours) {
    ifFavour = ifFavours;
    if (ifFavour == 1) {
      collectImg = "assets/images/detail_collect_s.png";
    } else {
      collectImg = "assets/images/detail_collect.png";
    }
    setState(() {});
  }

  moreUserPay() {
    UiHelpDart.redirectToUseSayPage(context, widget.pid);
  }

  StreamSubscription loginSubscription;

  @override
  void initState() {
    UiHelpDart.showLoadingDialog();
    getProdDetailById(widget.pid);
    customUseSay(widget.pid);
    loginSubscription = eventBus.on<EvaluateAddEvent>().listen((event) {
      customUseSay(widget.pid);
    });
  }

  @override
  void dispose() {
    super.dispose();
    loginSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    liveImgWidth = MediaQuery.of(context).size.width - 20;
    liveImgHeight = liveImgWidth / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: DetailTitleBar(prodName, isUserBook, downOnClick, shareOnClick),
      body: Column(
        children: <Widget>[
          Expanded(
              child: EasyRefresh(
            header: MaterialHeader(
              backgroundColor: Colors.blue,
            ),
            onRefresh: _refresh,
            enableControlFinishRefresh: true,
            controller: _controller,
            child: Column(
              children: <Widget>[
                getAvdImageWidget(),
                getTagWidget("基本信息"),
                getBaseInfoWidget(),
                getDivWidget(),
                getTagWidget("主要功能"),
                getFunctionWidget(mainFun + doMain),
                getDivWidget(),
                getTagWidget("主要参数"),
                getParameterWidget(info),
                getDivWidget(),
                getUserTagWidget("用户使用心得", moreUserPay, true),
                getCommentWidget(),
                Offstage(
                  offstage: isUserBook,
                  child: Container(
                    height: 20,
                  ),
                ),
                Offstage(
                  offstage: !isUserBook,
                  child: Column(
                    children: [
                      getDivWidget(),
                      getTagWidget("产品手册"),
                      getHandbookWidget()
                    ],
                  ),
                )
              ],
            ),
          )),
          getBottomWidget(),
        ],
      ),
    );
  }

  Widget getAvdImageWidget() {
    return new Container(
        color: ResColors.color_bg_color,
        child: new ClipRRect(
          child: new GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: CachedNetworkImage(
              imageUrl: prodImg,
              fit: BoxFit.fill,
              height: liveImgHeight,
              width: liveImgWidth,
            ),
            onTap: null,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10));
  }

  onClickCompany() {
    if (StringUtils.isEmpty(factory)) {
      UiHelpDart.showToast("暂无厂家信息");
      return;
    }
    UiHelpDart.redirectToCompanyPage(context, factory);
  }

  onClickCollect() {
    if (!MyApplication.isUserLogin) {
      UiHelpDart.redirectToLoginPage(context);
      return;
    }
    if (ifFavour == 0) {
      //没有收藏 加入收藏
      UiHelpDart.showLoadingDialog();
      ReqQuoteApi.getInstance().addToMyFavorite(new addCallBack(), widget.pid);
    } else {
      //收藏 取消收藏
      UiHelpDart.showLoadingDialog();
      ReqQuoteApi.getInstance()
          .cancelProdFavor(new CancelCallBack(), widget.pid);
    }
  }

  onClickSample() {
    if (!MyApplication.isUserLogin) {
      UiHelpDart.redirectToLoginPage(context);
      return;
    }
    UiHelpDart.redirectToSampleGetPage(context, widget.pid);
  }

  Widget getBottomWidget() {
    return Container(
      color: ResColors.color_bg_color,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                getBottomItemWidget("assets/images/detail_manufacturers.png",
                    "厂家", onClickCompany),
                getBottomItemWidget(collectImg, "收藏", onClickCollect),
                getBottomItemWidget(
                    "assets/images/detail_getsample.png", "索取样片", onClickSample)
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: showBoom,
              child: Container(
                alignment: Alignment.center,
                color: ResColors.bg_quote_round_simtrade_color,
                child: Text(
                  "加入BOM清单",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  Widget getBottomItemWidget(String path, String desc, onClick) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onClick,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset(path),
                width: 22,
                height: 22,
              ),
              Container(
                child: Text(
                  desc,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ));
  }

  Widget getTagWidget(String tag) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 0, 10),
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

  Widget getUserTagWidget(String title, onClck, bool visible) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
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

  Widget getBaseInfoWidget() {
    return Column(
      children: <Widget>[
        getBaseInfoItemWidget("产品编码", prodCode),
        getBaseInfoItemWidget("产品大类", bigCateName),
        getBaseInfoItemWidget("产品小类", smallCateName),
        getBaseInfoItemWidget("产品名称", prodName),
        getBaseInfoItemWidget("型号规格", xinHaoGuiGe),
        getBaseInfoItemWidget("质量等级", qualityGrade),
        getBaseInfoItemWidget("封装形式", fillMethod),
        getBaseInfoItemWidget("工作温度范围", tempRange),
        getBaseInfoItemWidget("抗静电能力", staticElectric),
        getBaseInfoItemWidget("抗辐照能力", radix),
        getBaseInfoItemWidget("鉴定机构", authOrg),
        getBaseInfoItemWidget("对标规格", devStand),
        getBaseInfoItemWidget("元器件总规范", elemNorm),
        getBaseInfoItemWidget("参考价格", costPrice),
        getBaseInfoItemWidget("生产厂家", factoryName),
      ],
    );
  }

  Widget getBaseInfoItemWidget(String title, String info) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 100,
            child: Text(
              title,
              style: TextStyle(color: ResColors.color_font_2_color),
            ),
          ),
          Expanded(
              child: Text(
            info,
            style: TextStyle(color: ResColors.color_font_1_color),
          ))
        ],
      ),
    );
  }

  Widget getFunctionWidget(String info) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Text(info),
    );
  }

  String itemTitle = "";
  String itemText = "";

  Widget getParameterWidget(List<Map> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        Map map = list[index];
        if (map != null) {
          itemTitle =
              map.keys.toString().replaceAll("(", "").replaceAll(")", "");
          itemText =
              map.values.toString().replaceAll("(", "").replaceAll(")", "");
        }
        return getParameterItemWidget(itemTitle, itemText);
      },
    );
  }

  Widget getParameterItemWidget(String title, String info) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 100,
            child: Text(
              title,
              style: TextStyle(color: ResColors.color_font_2_color),
            ),
          ),
          Expanded(
              child: Text(
            info,
            style: TextStyle(color: ResColors.color_font_1_color),
          ))
        ],
      ),
    );
  }

  Widget getDivWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      height: 1,
      color: ResColors.divided_color,
      child: Row(),
    );
  }

  Widget getCommentWidget() {
    return ListView.builder(
      itemCount: prodMap.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return UserSayItemWidget(prodMap[index], (index + 1) == prodMap.length);
      },
    );
  }

  Widget getHandbookWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            child: Image.asset("assets/images/product_handbook.png"),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 2),
                child: Text(
                  "产品手册文件.pdf",
                  style: TextStyle(
                      color: ResColors.color_font_1_color, fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 2, 10, 0),
                child: Text(
                  StringUtils.getTimeLine(context, docUploadDate) +
                      "    " +
                      docSize,
                  style: TextStyle(
                      color: ResColors.color_font_3_color, fontSize: 14),
                ),
              )
            ],
          )),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: downBook,
            child: Container(
              alignment: Alignment.center,
              height: 30,
              width: 100,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                border:
                    new Border.all(width: 1, color: ResColors.color_1_color),
              ),
              child: Text(
                "点击下载",
                style: TextStyle(color: ResColors.color_1_color, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
