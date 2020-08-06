import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluwx_no_pay/fluwx_no_pay.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/Constants.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/SharedPreferencesUtil.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

import '../MyApplication.dart';
import 'BBSPage.dart';
import 'BOMPage.dart';
import 'HomePage.dart';
import 'MainSortPage.dart';
import 'MyPage.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class CallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {}

  @override
  void onSuccess(String var3) {}
}

class MainPageState extends State<MainPage> {
  StreamSubscription mainChangeSubscription;
  int tabIndex = 0;
  double width = 24.0;
  double height = 24.0;
  var pageList = [
    new HomePage(),
    new MainSortPage(),
    new BBSPage(),
    new BOMPage(),
    new MyPage(),
  ];

  _initFluwx() async {
    await registerWxApi(
        appId: "wxbbdcdbd568b7759d",
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://im.jijuekeji.com:5000/app/");
    var result = await isWeChatInstalled;
    print("is installed $result");
  }

  @override
  void initState() {
    super.initState();
    _initFluwx();
    startTimer();
    //订阅eventbus
    mainChangeSubscription = eventBus.on<MainChange2Event>().listen((event) {
      tabIndex = event.index;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
    //取消订阅
    mainChangeSubscription.cancel();
  }

  Timer _timer;

  void startTimer() {
    const period = const Duration(seconds: 5);
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = null;
    _timer = Timer.periodic(period, (timer) {
      //获取本地时间
      Future<int> result = SharedPreferencesUtil.getInt("today_time");
      result.then((value) {
        if (value == null) {
          value = 0;
        }
        int localTimes = value + 5;
        SharedPreferencesUtil.setInt("today_time", localTimes);
        if (localTimes >= 30) {
          if (MyApplication.isUserLogin) {
            ReqQuoteApi.getInstance()
                .memberXinChange(new CallBack(), "2", "1", "");
          }
        }
      });
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: SafeArea(
            child: Offstage(),
            top: true,
          ),
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.00)),
      body: IndexedStack(
        index: this.tabIndex,
        children: this.pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: new Image.asset('assets/images/tab_service.png',
                  width: width, height: height),
              activeIcon: new Image.asset('assets/images/tab_service_s.png',
                  width: width, height: height),
              title: Text("主页")),
          BottomNavigationBarItem(
              icon: new Image.asset('assets/images/tab_quote.png',
                  width: width, height: height),
              activeIcon: new Image.asset('assets/images/tab_quote_s.png',
                  width: width, height: height),
              title: Text("分类")),
          BottomNavigationBarItem(
              icon: new Image.asset('assets/images/tab_trade.png',
                  width: width, height: height),
              activeIcon: new Image.asset('assets/images/tab_trade_s.png',
                  width: width, height: height),
              title: Text("社区")),
          BottomNavigationBarItem(
              icon: new Image.asset('assets/images/tab_find.png',
                  width: width, height: height),
              activeIcon: new Image.asset('assets/images/tab_find_s.png',
                  width: width, height: height),
              title: Text("BOM管家")),
          BottomNavigationBarItem(
              icon: new Image.asset('assets/images/tab_my.png',
                  width: width, height: height),
              activeIcon: new Image.asset('assets/images/tab_my_s.png',
                  width: width, height: height),
              title: Text("我的")),
        ],
        fixedColor: ResColors.tab_select_color,
        type: BottomNavigationBarType.fixed,
        currentIndex: tabIndex,
        onTap: (index) {
          if (index == 4) {
            eventBus.fire(LoginEvent());
          } else if (index == 3) {
            eventBus.fire(MainChange4Event(index));
          } else if (index == 2) {
            eventBus.fire(MainChange3Event(3));
          }
          setState(() {
            tabIndex = index;
          });
        },
      ),
    );
    ;
  }
}
