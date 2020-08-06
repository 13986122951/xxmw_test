
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmw_shop/utils/ResColors.dart';

class InvitationDetailTitleBar extends StatelessWidget
    implements PreferredSizeWidget {
  String title;
  var share;

  InvitationDetailTitleBar(this.title, this.share);

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
            onTap: share,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: 25,
              height: 25,
              child: Image.asset("assets/images/ic_quote_share.png"),
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45);
}
