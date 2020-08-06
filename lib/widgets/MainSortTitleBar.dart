import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

String imgPath;

class MainSortTitleBar extends StatefulWidget implements PreferredSizeWidget {
  MainSortTitleBar(String imgPaths) {
    imgPath = imgPaths;
  }

  @override
  Size get preferredSize => Size.fromHeight(45);

  @override
  State<StatefulWidget> createState() {
    return MainSortTitleBarState();
  }
}

class MainSortTitleBarState extends State<MainSortTitleBar> {
  void redirectToSearchPage() {
    UiHelpDart.redirectToSearchPage(context, 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: new AppBar(
        backgroundColor: Colors.white,
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
                        "搜索内容",
                        style: TextStyle(
                            fontSize: 14, color: ResColors.color_font_3_color),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: redirectToSearchPage,
              behavior: HitTestBehavior.opaque,
              child: Container(
                alignment: Alignment.centerRight,
                width: 40,
                child: Container(
                  alignment: Alignment.centerRight,
                  width: 40,
                  child: Text(
                    "搜索",
                    style: TextStyle(
                        fontSize: 14, color: ResColors.color_font_3_color),
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
    );
  }
}
