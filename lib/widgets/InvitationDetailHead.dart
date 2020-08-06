import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';

class InvitationDetailHead extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InvitationDetailHeadState();
  }
}

final GlobalKey globalKey = GlobalKey();

void _getWH() {
  final containerWidth = globalKey.currentContext.size.width;
  final containerHeight = globalKey.currentContext.size.height;
  print('Container widht is $containerWidth, height is $containerHeight');
}

class InvitationDetailHeadState extends State<InvitationDetailHead> {
  @override
  void initState() {
    WidgetsBinding widgetsBinding = WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((callback) {
      _getWH();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.width - 40) / 3;
    return Container(
      key: globalKey,
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          getHeadWidget(),
          getArticleWidget(height),
        ],
      ),
    );
  }

  Widget getHeadWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: new ClipOval(
              child: CachedNetworkImage(
                errorWidget: (context, url, error) =>
                    new Image.asset("assets/images/radio_default_cover.png"),
                imageUrl:
                    "http://t7.baidu.com/it/u=3616242789,1098670747&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg?sec=1586536499&t=ee09e52b30b6ebb2f42f29f5505fdf00",
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              "持续警惕 意大利“封城”措施再度延长",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: ResColors.color_font_1_color,
                  fontSize: 16),
            ),
          )),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ActionChip(
              label: Container(
                alignment: Alignment.center,
                width: 60,
                child: Text(
                  "+关注",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              //点击事件
              onPressed: () {},
              elevation: 0,
              backgroundColor: ResColors.bg_quote_round_game_color,
            ),
          )
        ],
      ),
    );
  }

  Widget getArticleWidget(double height) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              "意大利总理孔特当地时间10日宣布，原定4月13日结束的全国“封城”措施将延长到5月3日。意大利总理孔特当地时间10日宣布，原定4月13日结束的全国“封城”措施将延长到5月3日。",
              style:
                  TextStyle(color: ResColors.color_font_1_color, fontSize: 14),
            ),
          ),
          Row(
            children: <Widget>[
              getImageLeftWidget(height),
              getImageWidget(height),
              getImageRightWidget(height)
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: Text(StringUtils.getTimeLine(context, 1586505945000),
                    style: TextStyle(
                        color: ResColors.color_font_3_color, fontSize: 12)),
              )),
              Container(
                  height: 15,
                  width: 15,
                  child: Image.asset("assets/images/icon_favorited.png")),
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                child: Text("100",
                    style: TextStyle(
                        color: ResColors.color_font_3_color, fontSize: 12)),
              ),
              Container(
                  height: 15,
                  width: 15,
                  child: Image.asset("assets/images/icon_favorited.png")),
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                child: Text("1000",
                    style: TextStyle(
                        color: ResColors.color_font_3_color, fontSize: 12)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget getImageLeftWidget(double height) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
      height: height,
      child: CachedNetworkImage(
        errorWidget: (context, url, error) =>
            new Image.asset("assets/images/radio_default_cover.png"),
        imageUrl:
            "http://t7.baidu.com/it/u=3616242789,1098670747&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg?sec=1586536499&t=ee09e52b30b6ebb2f42f29f5505fdf00",
        fit: BoxFit.cover,
        height: 40,
        width: 40,
      ),
    ));
  }

  Widget getImageWidget(double height) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      height: height,
      child: CachedNetworkImage(
        errorWidget: (context, url, error) =>
            new Image.asset("assets/images/radio_default_cover.png"),
        imageUrl:
            "http://t7.baidu.com/it/u=3616242789,1098670747&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg?sec=1586536499&t=ee09e52b30b6ebb2f42f29f5505fdf00",
        fit: BoxFit.cover,
        height: 40,
        width: 40,
      ),
    ));
  }

  Widget getImageRightWidget(double height) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
      height: height,
      child: CachedNetworkImage(
        errorWidget: (context, url, error) =>
            new Image.asset("assets/images/radio_default_cover.png"),
        imageUrl:
            "http://t7.baidu.com/it/u=3616242789,1098670747&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg?sec=1586536499&t=ee09e52b30b6ebb2f42f29f5505fdf00",
        fit: BoxFit.cover,
        height: 40,
        width: 40,
      ),
    ));
  }
}
