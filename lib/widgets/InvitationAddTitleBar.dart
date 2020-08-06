import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmw_shop/utils/ResColors.dart';

class InvitationAddTitleBar extends StatelessWidget
    implements PreferredSizeWidget {
  String title = "编辑文章";
  bool isBack = true;
  var onClick;

  InvitationAddTitleBar(var onClick) {
    this.onClick = onClick;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: new AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            child: Container(
              color: ResColors.divided_color,
              height: 1,
            ),
            preferredSize: null),
        leading: IconButton(
            icon: Image.asset('assets/images/icon_back.png'),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onClick,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Text(
                "发布",
                style: TextStyle(color: ResColors.color_1_color, fontSize: 16),
              ),
            ),
          )
        ],
        title: new Text(title,
            style: TextStyle(color: Colors.black, fontSize: 15)),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45);
}
