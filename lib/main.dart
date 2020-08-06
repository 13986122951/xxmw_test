import 'package:bot_toast/bot_toast.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:xmw_shop/ui/MainPage.dart';
import 'package:xmw_shop/utils/DeviceUtil.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

import 'MyApplication.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  DeviceUtil.setBarStatus(true);
  new MyApplication();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    setLocalizedValues(localizedValues);
    UiHelpDart.Init(context);
    return BotToastInit(
      child: MaterialApp(
        title: '芯梦网',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          indicatorColor: Colors.white,
        ),
        navigatorObservers: [BotToastNavigatorObserver()],
        home: MainPage(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          CustomLocalizations.delegate,
          const FallbackCupertinoLocalisationsDelegate()
        ],
//        supportedLocales: CustomLocalizations.supportedLocales,
      ),
    );
  }
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}
