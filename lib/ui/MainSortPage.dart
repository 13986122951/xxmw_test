
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/bean/HomePageEntity.dart';
import 'package:xmw_shop/bean/ProdCateEntity.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/Constants.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/widgets/MainSortTitleBar.dart';

MainSortPageState pageState;

class MainSortPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    pageState = new MainSortPageState();
    return pageState;
  }
}

class PageCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    ProdCateEntity entity = ProdCateEntity.fromJson(json);
    if (entity != null) {
      if (entity.code == 0) {
        pageState.update(entity);
      } else {
        UiHelpDart.showToast(entity.msg);
      }
    }
  }
}

tryAgain() {
  UiHelpDart.showLoadingDialog();
  getProdCateList();
}

getProdCateList() {
  ReqQuoteApi.getInstance().getProdCateList(new PageCallBack());
}

class MainSortPageState extends State<MainSortPage> {
  List<ProdCateData> _datas = []; //一级分类集合
  List<ProdCateDatachild> articles = List(); //二级分类集合
  int index = 0; //一级分类下标

  @override
  void initState() {
    getProdCateList();
  }

  update(ProdCateEntity entity) {
    if (entity != null) {
      _datas.clear();
      _datas = entity.data;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainSortTitleBar("assets/images/home_title_search.png"),
      backgroundColor: Colors.white,
      body: getMainWidget(),
    );
  }

  Widget getMainWidget() {
    if (_datas != null && _datas.length > 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: _datas.length,
                itemBuilder: (BuildContext context, int position) {
                  return getLeftRow(position);
                },
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: ListView(
                children: <Widget>[
                  Container(
                    //height: double.infinity,jijjjij
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: getChip(index), //传入一级分类下标
                  ),
                ],
              )),
        ],
      );
    } else {
      return GestureDetector(
        onTap: tryAgain,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                CromputerUtils.try_again,
                style: TextStyle(
                    color: ResColors.color_font_3_color, fontSize: 16),
              ),
            )
          ],
        ),
      );
    }
  }

  Widget getLeftRow(int i) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 55,
        alignment: Alignment.center,
        //Container下的color属性会与decoration下的border属性冲突，所以要用decoration下的color属性
        decoration: BoxDecoration(
          color: index == i ? Colors.white : ResColors.indicator_unselect_color,
          border: Border(
            left: BorderSide(
                width: index == i ? 0 : 0,
                color: index == i ? Colors.blue : Colors.white),
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: index == i ? 5 : 0,
              color:
                  index == i ? Colors.blue : ResColors.indicator_unselect_color,
              height: 20,
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Text(
                _datas[i].cateName,
                style: TextStyle(
                  color: index == i
                      ? ResColors.color_1_color
                      : ResColors.color_font_3_color,
                  fontWeight: index == i ? FontWeight.w400 : FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ))
          ],
        ),
      ),
      onTap: () {
        setState(() {
          index = i; //记录选中的下标
        });
      },
    );
  }

  bool isShowLine = true;

  Widget getChip(int i) {
    //更新对应下标数据
    _updateArticles(i);

    if (articles.length > 0) {
      return ListView.builder(
          itemCount: articles.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (articles.length == (index + 1)) {
              isShowLine = false;
            } else {
              isShowLine = true;
            }
            return Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          articles[index].cateName,
                          style: TextStyle(fontSize: 14),
                        ),
                        height: 40,
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                ),
                getRightItemWidget(articles[index].children),
                Offstage(
                  offstage: !isShowLine,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        color: ResColors.divided_color,
                        height: 2,
                      ))
                    ],
                  ),
                )
              ],
            );
          });
    } else {
      return Row(
        children: [
          Expanded(
              child: Container(
            height: 80,
            alignment: Alignment.center,
            color: ResColors.divided_color,
            child: Text(
              "暂无分类",
              style: TextStyle(color: ResColors.color_font_3_color),
            ),
          ))
        ],
      );
    }
  }

  ///
  /// 根据一级分类下标更新二级分类集合
  ///
  List<ProdCateDatachild> _updateArticles(int i) {
    setState(() {});
    if (_datas != null && _datas.length > 0) {
      articles = _datas[i].children;
    }
    return articles;
  }

  Widget getRightItemWidget(List<ProdCateDatachildchild> children) {
    int length = children.length;
    if (length > 0) {
      return GridView.builder(
          itemCount: length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 3,
            //纵轴间距
            mainAxisSpacing: 10.0,
            //横轴间距
            crossAxisSpacing: 10.0, childAspectRatio: 4 / 6,
          ),
          itemBuilder: (BuildContext context, int indexs) {
            //Widget Function(BuildContext context, int index)
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                HomePageDataProductcate menuBeans =
                    new HomePageDataProductcate();
                menuBeans.title = children[indexs].cateName;
                menuBeans.pkId = children[indexs].cateId;
                UiHelpDart.redirectToSortPage(
                    context, menuBeans.title, menuBeans.pkId, 0);
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    new Container(
                        width: 40,
                        height: 40,
                        child: CachedNetworkImage(
                          errorWidget: (context, url, error) => new Image.asset(
                              "assets/images/radio_default_cover.png"),
                          imageUrl: children[indexs].imgPath,
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        )),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(
                        children[indexs].cateName,
                        style: TextStyle(
                            fontSize: 12, color: ResColors.color_font_3_color),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    } else {
      return Row(
        children: [
          Expanded(
              child: Container(
            height: 80,
            alignment: Alignment.center,
            color: ResColors.divided_color,
            child: Text(
              "暂无分类",
              style: TextStyle(color: ResColors.color_font_3_color),
            ),
          ))
        ],
      );
    }
  }

  Widget getTitleWidget() {
    return Container(
      height: Constants.TITLE_HEIGHT,
      child: Row(
        children: <Widget>[
          Text("芯梦网"),
          Expanded(
            child: Container(
              height: 35,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              //设置 child 居中
              alignment: Alignment(0, 0),
              //边框设置
              decoration: new BoxDecoration(
                //背景
                color: Colors.grey,
                //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                //设置四周边框
                border: new Border.all(width: 1, color: Colors.grey),
              ),
              child: Text("搜索元器件"),
            ),
          ),
          Text("消息"),
        ],
      ),
    );
  }
}