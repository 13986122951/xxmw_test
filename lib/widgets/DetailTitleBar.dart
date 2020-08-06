import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmw_shop/utils/ResColors.dart';

class DetailTitleBar extends StatelessWidget implements PreferredSizeWidget {
  String title = "";
  bool isBack = true;
  bool isUserBook = false;
  var downOnClick;
  var shareOnClick;

  DetailTitleBar(
      this.title, this.isUserBook, this.downOnClick, this.shareOnClick);

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
        bottom: PreferredSize(
            child: Container(
              color: ResColors.divided_color,
              height: 1,
            ),
            preferredSize: null),
        actions: <Widget>[
          GestureDetector(
            onTap: downOnClick,
            child: Offstage(
              offstage: !isUserBook,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                width: 20,
                height: 20,
                child: Image.asset("assets/images/product_down.png"),
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: shareOnClick,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: 20,
              height: 20,
              child: Image.asset("assets/images/product_share.png"),
            ),
          )
        ],
        title: new Text(title,
            style: TextStyle(color: Colors.black, fontSize: 15)),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45);
}
