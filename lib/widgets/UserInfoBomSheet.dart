import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoBomSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserInfoBomState();
  }
}

class UserInfoBomState extends State<UserInfoBomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: TextField(),
          )
        ],
      ),
    );
  }
}
