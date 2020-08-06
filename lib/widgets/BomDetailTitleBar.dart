import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmw_shop/utils/ResColors.dart';

class BomDetailTitleBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  String imgPath;
  var onClick;
  String rightTitle;
  var onClickT;

  BomDetailTitleBar(
      this.title, this.onClick, this.imgPath, this.onClickT, this.rightTitle);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: new AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Image.asset('assets/images/icon_back.png'),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: new Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        bottom: PreferredSize(
            child: Container(
              color: ResColors.divided_color,
              height: 1,
            ),
            preferredSize: null),
        actions: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onClickT,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                rightTitle,
                style: TextStyle(color: ResColors.color_1_color),
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onClick,
            child: Container(
              alignment: Alignment.centerRight,
              width: 25,
              height: 25,
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Image.asset(imgPath),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45);
}
