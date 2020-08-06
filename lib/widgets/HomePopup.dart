import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/utils/ResColors.dart';

class HomePopup extends StatelessWidget {
  final double top; //距离上面位置
  Widget widget;

  HomePopup(this.top,this.widget);

  @override
  Widget build(BuildContext context) {
    double textWidth = 80;
    double width = MediaQuery
        .of(context)
        .size
        .width - 90;

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              color: Colors.transparent,
            ),
            Positioned(
              child: Container(
                //边框设置
                decoration: new BoxDecoration(
                  //背景
                  color: ResColors.home_titlebar_color,
                  //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  //设置四周边框
                  border: new Border.all(
                      width: 0, color: ResColors.home_titlebar_color),
                ),
                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                width: textWidth,
                child:widget,
              ),
              left: width,
              top: top - 8,
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
