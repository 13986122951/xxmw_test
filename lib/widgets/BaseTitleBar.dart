import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmw_shop/utils/ResColors.dart';

class BaseTitleBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool isBack;

  BaseTitleBar(
    this.title,
    this.isBack,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: new AppBar(
        elevation: 0,
        leading: Offstage(
          offstage: !isBack,
          child: IconButton(
              icon: Image.asset('assets/images/icon_back.png'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        title: new Text(title,
            style: TextStyle(color: Colors.black, fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            child: Container(
              color: ResColors.divided_color,
              height: 1,
            ),
            preferredSize: null),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45);
}
