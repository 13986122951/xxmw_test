import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/bean/HomePageEntity.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

class MainSortItem extends StatelessWidget {
  HomePageDataProductcate menuBeans;

  MainSortItem(HomePageDataProductcate menuBeans) {
    this.menuBeans = menuBeans;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UiHelpDart.redirectToSortPage(
            context, menuBeans.title, menuBeans.pkId, 0);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: CachedNetworkImage(
                errorWidget: (context, url, error) =>
                    new Image.asset("assets/images/radio_default_cover.png"),
                imageUrl: menuBeans.imgPath,
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              )),
          Text(
            menuBeans.title,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: ResColors.color_font_3_color),
          )
        ],
      ),
    );
  }
}
