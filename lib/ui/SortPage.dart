import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/ProdsCateEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/BaseRightImgTitleBar.dart';
import 'package:xmw_shop/widgets/SortProdItemWidget.dart';
import 'package:xmw_shop/utils/ResColors.dart';

SortState pageState;
int recordNum = 1;
int pageSize = 30;
bool isRefresh = true;
bool isMore = false;

class SortPage extends StatefulWidget {
  String title = "全部";
  String pid = "";
  int type = 0;

  SortPage(this.title, String cateId, int typee) {
    pid = cateId;
    type = typee;
    pageState = new SortState();
  }

  @override
  State<StatefulWidget> createState() {
    return pageState;
  }
}

Future<Null> _refresh() async {
  isRefresh = true;
  recordNum = 1;
  pageState.getProdsByCateId();
}

Future<Null> _onload() async {
  isRefresh = false;
  pageState.getProdsByCateId();
}

class CallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    ProdsCateEntity entity = ProdsCateEntity.fromJson(json);
    if (entity != null) {
      if (entity.code == 0 && entity.data != null) {
        recordNum += 1;
        pageState.upData(entity.data.prodMap);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

EasyRefreshController _controller = EasyRefreshController();

class SortState extends State<SortPage> {
  List<ProdsCateDataProdmap> prodMap = [];

  upData(List<ProdsCateDataProdmap> data) {
    if (isRefresh) {
      prodMap.clear();
    }
    if (data != null && data.length == pageSize) {
      isMore = true;
    } else {
      isMore = false;
    }
    prodMap.addAll(data);
    setState(() {});
  }

  onClick() {
    UiHelpDart.redirectToSearchPage(context, 0);
  }

  @override
  void initState() {
    isRefresh = true;
    recordNum = 1;
    UiHelpDart.showLoadingDialog();
    getProdsByCateId();
  }

  getProdsByCateId() {
    ReqQuoteApi.getInstance().getProdsByCateId(new CallBack(), widget.pid,
        widget.type.toString(), recordNum, pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseRightImgTitleBar(
          widget.title, onClick, "assets/images/home_title_search.png"),
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
            getHotBBSWidget(),
          ],
        ),
      ),
    );
  }

  Widget getHotBBSWidget() {

    if(prodMap!=null&&prodMap.length>0){
      return ListView.builder(
          itemCount: prodMap.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return SortProdItemWidget(
                (index + 1) == prodMap.length, prodMap[index]);
          });
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
}
