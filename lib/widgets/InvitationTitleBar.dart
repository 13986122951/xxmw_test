import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

class InvitationTitleBar extends StatelessWidget
    implements PreferredSizeWidget {
  String title = "";
  bool isBack = true;
  String topicId;

  InvitationTitleBar(this.topicId);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: new AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              UiHelpDart.redirectToSearchPage(context, 1);
            },
            child: Container(
              width: 25,
              height: 25,
              child: Image.asset("assets/images/icon_query.png"),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (!StringUtils.isEmpty(topicId)) {
                UiHelpDart.redirectToInvitationAddPage(context, topicId);
              }
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
              width: 25,
              height: 25,
              child: Image.asset("assets/images/icon_plus.png"),
            ),
          )
        ],
        title: new Text(title,
            style: TextStyle(color: Colors.black, fontSize: 15)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45);
}
