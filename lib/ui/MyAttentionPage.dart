import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/widgets/AttInvitationListWidget.dart';
import 'package:xmw_shop/widgets/AttTopicListWidget.dart';
import 'package:xmw_shop/widgets/BaseTitleBar.dart';

//我的关注
class MyAttentionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAttentionState();
  }
}

class MyAttentionState extends State<MyAttentionPage>
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
        appBar: BaseTitleBar("我的关注", true),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: 150,
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
                          text: "话题",
                        ),
                        Tab(
                          text: "文章",
                        )
                      ]),
                )
              ],
            ),
            Expanded(
                child: TabBarView(controller: controller, children: <Widget>[
              new AttTopicListWidget(),
              new AttInvitationListWidget()
            ]))
          ],
        ));
  }
}
