import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/utils/ResColors.dart';

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
  TabController controller;

  MyTabBar(TabController controller) {
    this.controller = controller;
  }

  @override
  Size get preferredSize => Size.fromHeight(45);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 40,
              child: TabBar(
                  isScrollable: true,
                  controller: controller,
                  labelColor: ResColors.color_1_color,
                  unselectedLabelColor: ResColors.color_font_1_color,
                  indicatorColor: ResColors.color_1_color,
                  indicatorWeight: 2,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  tabs: [
                    Tab(text: "全部"),
                    Tab(text: "只看楼主"),
                  ]),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
              color: ResColors.divided_color,
              height: 1,
            ))
          ],
        )
      ],
    );
  }
}
