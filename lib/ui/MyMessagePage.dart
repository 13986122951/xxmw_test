import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/widgets/BaseTitleBar.dart';
import 'package:xmw_shop/widgets/MessageMyWidget.dart';
import 'package:xmw_shop/widgets/MessageSysWidget.dart';

//我的 消息
class MyMessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyMessageState();
  }
}

class MyMessageState extends State<MyMessagePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseTitleBar("我的消息", true),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: 200,
                  height: 36,
                  child: TabBar(
                      controller: controller,
                      labelColor: ResColors.color_1_color,
                      unselectedLabelColor: ResColors.color_font_1_color,
                      indicatorColor: ResColors.color_1_color,
                      indicatorWeight: 2,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                      unselectedLabelStyle:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      tabs: <Widget>[
                        Tab(
                          text: "系统消息",
                        ),
                        Tab(
                          text: "关于我",
                        )
                      ]),
                )
              ],
            ),
            Expanded(
                child: TabBarView(
                    controller: controller,
                    children: <Widget>[MessageSysWidget(), MessageMyWidget()]))
          ],
        ));
  }
}
