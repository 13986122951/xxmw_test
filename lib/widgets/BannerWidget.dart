import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:xmw_shop/bean/HomePageEntity.dart';
import 'package:xmw_shop/ui/BaseDart.dart';
import 'package:xmw_shop/utils/ResColors.dart';

//Item的点击事件
typedef void OnBannerItemClick(int position, HomePageDataFowbanner entity);
//自定义ViewPager的每个页面显示
typedef Widget CustomBuild(int position, HomePageDataFowbanner entity);

const MAX_COUNT = 0x7fffffff;

class BannerWidget extends BaseDart {
  final double height;
  final List<HomePageDataFowbanner> datas;
  int duration = 5000;
  double pointRadius = 3.0;
  Color selectedColor = Colors.blue;
  Color unSelectedColor = Colors.grey;
  Color textBackgroundColor = const Color(0x99000000);
  bool isHorizontal = true;
  OnBannerItemClick bannerPress;
  CustomBuild build;
  bool isPoint = false;

  BannerWidget(
      double this.height, List<HomePageDataFowbanner> this.datas, this.isPoint,
      {Key key,
      int this.duration = 5000,
      double this.pointRadius = 3.0,
      Color this.selectedColor = Colors.blue,
      Color this.unSelectedColor = Colors.grey,
      Color this.textBackgroundColor = const Color(0x99000000),
      bool this.isHorizontal = true,
      OnBannerItemClick this.bannerPress,
      CustomBuild this.build});

  @override
  State<StatefulWidget> initbuild() {
    return new BannerPage();
  }
}

class BannerPage extends State<BannerWidget> {
  Timer timer;
  int selectedIndex = 0;
  PageController controller;

  @override
  void initState() {
    double current = widget.datas.length > 0
        ? (MAX_COUNT / 2) - ((MAX_COUNT / 2) % widget.datas.length)
        : 0.0;
    controller = PageController(initialPage: current.toInt());

    if (widget.isPoint) {
      start();
    }
  }

  @override
  void dispose() {
    if (widget.isPoint) {
      stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: widget.height,
      color: ResColors.color_bg_color,
      child: Stack(
        children: <Widget>[
          getViewPager(),
          Offstage(
            offstage: !widget.isPoint,
            child: new Align(
              alignment: Alignment.bottomCenter,
              child: IntrinsicHeight(
                child: Container(
                  padding: EdgeInsets.all(6.0),
                  child: getBannerTextInfoWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  start() {
    stop();
    timer = Timer.periodic(Duration(milliseconds: widget.duration), (timer) {
      if (widget.datas.length > 0 &&
          controller != null &&
          controller.page != null) {
        controller.animateToPage(controller.page.toInt() + 1,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    });
  }

  stop() {
    timer?.cancel();
    timer = null;
  }

  Widget getBannerTextInfoWidget() {
    if (widget.isHorizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
//          new Expanded(
//            flex: 1,
//            child: getSelectedIndexTextWidget(),
//          ),
          Container(
            child: Row(
              children: circle(),
            ),
          ),
        ],
      );
    } else {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
//          getSelectedIndexTextWidget(),
          IntrinsicWidth(
            child: Row(
              children: circle(),
            ),
          ),
        ],
      );
    }
  }

  List<Widget> circle() {
    List<Widget> circle = [];
    for (var i = 0; i < widget.datas.length; i++) {
      circle.add(Container(
        margin: EdgeInsets.all(3.0),
        width: widget.pointRadius * 3,
        height: widget.pointRadius,
        decoration: new BoxDecoration(
          color: selectedIndex == i
              ? widget.selectedColor
              : widget.unSelectedColor,
        ),
      ));
    }
    return circle;
  }

  Widget getViewPager() {
    return PageView.builder(
      itemCount: widget.datas.length > 0 ? MAX_COUNT : 0,
      controller: controller,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              if (widget.bannerPress != null)
                widget.bannerPress(selectedIndex, widget.datas[selectedIndex]);
            },
            child: widget.build == null
                ? FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.datas[index % widget.datas.length].imgPath,
                    fit: BoxFit.fill)
                : widget.build(
                    index, widget.datas[index % widget.datas.length]));
      },
    );
  }

  Widget getSelectedIndexTextWidget() {
    return widget.datas.length > 0 && selectedIndex < widget.datas.length
        ? Text(widget.datas[selectedIndex].title)
        : Text('');
  }

  onPageChanged(index) {
    selectedIndex = index % widget.datas.length;
    setState(() {});
  }
}
