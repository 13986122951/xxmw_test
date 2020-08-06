import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmw_shop/common/HomeTitleCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

import 'HomePopup.dart';
import 'PopRoute.dart';

HomeTitleBarState titleBarState;

class HomeTitleBar extends StatefulWidget implements PreferredSizeWidget {
  GlobalKey anchorKey;

  HomeTitleBar(this.anchorKey) {}

  @override
  Size get preferredSize => Size.fromHeight(45);

  @override
  State<StatefulWidget> createState() {
    titleBarState = new HomeTitleBarState();
    return titleBarState;
  }
}

class TitleCallBack extends HomeTitleCallBack {
  @override
  void callbcak(int content) {
    if (content == 0) {
      searchStr = "元器件";
      type = 0;
    } else {
      searchStr = "文档";
      type = 1;
    }
    titleBarState.update();
  }
}

String searchStr = "元器件";
int type = 0;

class HomeTitleBarState extends State<HomeTitleBar> {
  void redirectToSearchPage() {
    UiHelpDart.redirectToSearchPage(context, type);
  }

  update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: new AppBar(
        elevation: 0,
        bottom: PreferredSize(
            child: Container(
              color: ResColors.divided_color,
              height: 1,
            ),
            preferredSize: null),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/home_logo.png"),
              width: 50,
              margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
            ),
            Expanded(
              child: GestureDetector(
                onTap: redirectToSearchPage,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 35,
                  //设置 child 居中
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  //边框设置
                  decoration: new BoxDecoration(
                    //背景
                    color: ResColors.indicator_unselect_color,
                    //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    //设置四周边框
                    border: new Border.all(
                        width: 0, color: ResColors.indicator_unselect_color),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:
                            Image.asset("assets/images/home_title_search.png"),
                      ),
                      Text(
                        "搜索" + searchStr,
                        style: TextStyle(
                            fontSize: 14, color: ResColors.color_font_3_color),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 70,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  RenderBox renderBox =
                      widget.anchorKey.currentContext.findRenderObject();
                  var offset = renderBox.localToGlobal(Offset.zero);
                  Navigator.push(
                      context,
                      PopRoute(
                          child: HomePopup(
                              offset.dy, getPopWidget(new TitleCallBack()))));
                },
                child: Text(
                  searchStr,
                  style: TextStyle(
                      color: ResColors.color_font_3_color, fontSize: 16),
                ),
              ),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget getPopWidget(HomeTitleCallBack callBack) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (callBack != null) {
              callBack.callbcak(0);
              Navigator.of(context).pop();
            }
          },
          child: Container(
            alignment: Alignment(0, 0),
            height: 35,
            child: Text(
              "元器件",
              style:
                  TextStyle(color: ResColors.color_font_1_color, fontSize: 14),
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (callBack != null) {
              callBack.callbcak(1);
              Navigator.of(context).pop();
            }
          },
          child: Container(
            alignment: Alignment(0, 0),
            height: 35,
            child: Text("文档",
                style: TextStyle(
                    color: ResColors.color_font_1_color, fontSize: 14)),
          ),
        )
      ],
    );
  }
}
