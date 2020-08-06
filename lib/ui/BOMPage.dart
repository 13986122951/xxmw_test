
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
import 'package:xmw_shop/bean/BomDownBean.dart';
import 'package:xmw_shop/bean/BomListEntity.dart';
import 'package:xmw_shop/bean/UserInfoEntity.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/MainBomTitleBar.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import '../MyApplication.dart';
import 'BaseDart.dart';

BOMState pageState = new BOMState();
bool isLogin = false;

class BOMPage extends BaseDart {
  @override
  State<StatefulWidget> initbuild() {
    return pageState;
  }
}

getBomOrders() {
  if (MyApplication.isUserLogin) {
    ReqQuoteApi.getInstance().getBomOrders(new CallBack());
  }
}

setBomOrderDefault(String bomOrderId) {
  if (MyApplication.isUserLogin) {
    UiHelpDart.showLoadingDialog();
    ReqQuoteApi.getInstance().setBomOrderDefault(new setCallBack(), bomOrderId);
  }
}

Future<Null> _refresh() async {
  getBomOrders();
}

EasyRefreshController _controller = EasyRefreshController();

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
    BomListEntity entity = BomListEntity.fromJson(json);
    if (entity != null) {
      if (entity.code == 0) {
        pageState.upData(entity.data);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class setCallBack implements ResponseCallBack {
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
      if (entity.code == 0) {
        getBomOrders();
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class delCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    Map<String, dynamic> json = jsonDecode(var3);
    BaseBean entity = BaseBean.fromJson(json);
    if (entity != null) {
      if (entity.code == 0) {
        getBomOrders();
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

class InfoCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast("下载失败");
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    BomDownBean baseBean = BomDownBean.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        Clipboard.setData(ClipboardData(text: baseBean.data));
        UiHelpDart.showToast("下载地址已复制到剪切板，请在浏览器打开下载");
      } else {
        UiHelpDart.showToast(baseBean.msg);
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

int setIndex = 0;

class BOMState extends State<BOMPage> {
  StreamSubscription mainChangeSubscription;
  StreamSubscription loginSubscription;
  List<BomListData> list = [];

  upData(List<BomListData> data) {
    list.clear();
    list = data;
    setState(() {});
  }

  updateState() {
    setState(() {});
  }

  exportBomOrder(String bomid) {
    ReqQuoteApi.getInstance().exportBomOrder(new InfoCallBack(), bomid);
  }

  @override
  void initState() {
    isLogin = MyApplication.isUserLogin;
    //订阅eventbus
    mainChangeSubscription = eventBus.on<MainChange4Event>().listen((event) {
      isLogin = MyApplication.isUserLogin;
      pageState.updateState();
      getBomOrders();
    });
    loginSubscription = eventBus.on<LoginEvent>().listen((event) {
      isLogin = MyApplication.isUserLogin;
      pageState.updateState();
      getBomOrders();
    });
  }

  String bomId;

  downLoad(String bomid) {
    if (!StringUtils.isEmpty(bomid)) {
      bomId = bomid;
      UiHelpDart.showAlertDialog(context, confirm, "是否消耗2金币下载BOM清单？");
    }
  }

  confirm() {
    if (!StringUtils.isEmpty(bomId)) {
      UiHelpDart.redirectToBackPage(context);
      exportBomOrder(bomId);
    }
  }

  @override
  void dispose() {
    //取消订阅
    mainChangeSubscription.cancel();
    loginSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBomTitleBar(),
      backgroundColor: Colors.white,
      body: getMainWidget(),
    );
  }

  getMainWidget() {
    if (isLogin) {
      return getNoData(list);
    } else {
      return Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: GestureDetector(
                onTap: () {
                  UiHelpDart.redirectToLoginPage(context);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
                  child: Text(
                    "请先登录",
                    style: TextStyle(
                        color: ResColors.color_font_3_color, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }



  Widget getNoData(List<BomListData> list){

    if(list!=null&&list.length>0){
      return EasyRefresh(
        header: MaterialHeader(
          backgroundColor: Colors.blue,
        ),
        enableControlFinishRefresh: true,
        controller: _controller,
        onRefresh: _refresh,
        child: Column(
          children: <Widget>[getHotBBSWidget(list)],
        ),
      );
    }else{
     return Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: GestureDetector(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
                  child: Text(
                    "暂无数据",
                    style: TextStyle(
                        color: ResColors.color_font_3_color, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

  }

  Widget getHotBBSWidget(List<BomListData> list) {
    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return getHotBBSItemWidget(list[index]);
        });
  }

  bool isSet = false;

  Widget getHotBBSItemWidget(BomListData data) {
    if (data.ifDefault == 1) {
      isSet = true;
    } else {
      isSet = false;
    }
    return GestureDetector(
      onTap: () {
        UiHelpDart.redirectToBomDetailPage(context, data.bomId);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 30,
                    width: 30,
                    child: Offstage(
                      offstage: !isSet,
                      child: Image.asset("assets/images/bom_default_img.png"),
                    ),
                  ),
                )),
                Container(
                  alignment: Alignment.center,
                  child: PopupMenuButton(
                    elevation: 0,
                    offset: Offset(40, 40),
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      width: 20,
                      height: 30,
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child:
                          Image.asset("assets/images/ic_quote_detail_more.png"),
                    ),
                    onSelected: (int action) {
                      switch (action) {
                        case 0:
                          UiHelpDart.delBomOrderById(
                              new delCallBack(), data.bomId);
                          break;
                        case 1:
                          UiHelpDart.redirectToBomAddPage(context, data.bomId);
                          break;
                        case 2:
                          String sharetext = "我的BOM清单:" + data.bomName;
                          WeChatScene scened = WeChatScene.SESSION;

                          shareToWeChat(WeChatShareWebPageModel(
                                  "http://www.ic2035.com",
                                  scene: scened,
                                  title: sharetext))
                              .then((datad) {
                            //增加金币
                            ReqQuoteApi.getInstance().memberXinChange(
                                new ShareBack(), "3", "1", data.bomId);
                          });
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuItem<int>>[
                        PopupMenuItem<int>(
                          height: 35,
                          child: Container(
                              alignment: Alignment.center,
                              child: Text("删除",
                                  style: TextStyle(
                                      color: ResColors.color_font_1_color,
                                      fontSize: 14))),
                          value: 0,
                        ),
                        PopupMenuItem<int>(
                          height: 35,
                          child: Container(
                              alignment: Alignment.center,
                              child: Text("编辑",
                                  style: TextStyle(
                                      color: ResColors.color_font_1_color,
                                      fontSize: 14))),
                          value: 1,
                        ),
                        PopupMenuItem<int>(
                          height: 35,
                          child: Container(
                              alignment: Alignment.center,
                              child: Text("分享",
                                  style: TextStyle(
                                      color: ResColors.color_font_1_color,
                                      fontSize: 14))),
                          value: 2,
                        ),
                      ];
                    },
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 82,
                  width: 110,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) => new Image.asset(
                        "assets/images/radio_default_cover.png"),
                    imageUrl: data.prodImg,
                    fit: BoxFit.cover,
                    height: 82,
                    width: 110,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 82,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Text("名    称：" + data.bomName,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                ResColors.color_font_1_color)),
                                  )
                                ],
                              )),
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text("总数量：" + data.sumNum.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ResColors.color_font_1_color)),
                              )
                            ],
                          )),
                          Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "备    注：" + data.remarks,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ResColors.color_font_1_color),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Text(
                                      "时    间：" +
                                          StringUtils.getTimeLine(
                                              context, data.addTime),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ResColors.color_font_1_color),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 2,
                  color: ResColors.color_bg_color,
                )),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    setBomOrderDefault(data.bomId);
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                    alignment: Alignment.center,
                    height: 26,
                    width: 80,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: new Border.all(
                          width: 1, color: ResColors.color_bg_color),
                    ),
                    child: Text(
                      "设为默认",
                      style: TextStyle(
                          color: ResColors.color_font_3_color, fontSize: 14),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    downLoad(data.bomId);
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                    alignment: Alignment.center,
                    height: 26,
                    width: 80,
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: new Border.all(width: 1, color: Colors.blue),
                    ),
                    child: Text(
                      "点击下载",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                )
              ],
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
