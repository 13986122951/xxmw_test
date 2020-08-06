
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/ui/BomAddPage.dart';
import 'package:xmw_shop/ui/BomDetailPage.dart';
import 'package:xmw_shop/ui/CompanyPage.dart';
import 'package:xmw_shop/ui/DetailPage.dart';
import 'package:xmw_shop/ui/EnquiryPage.dart';
import 'package:xmw_shop/ui/InvitationAddPage.dart';
import 'package:xmw_shop/ui/InvitationDetailPage.dart';
import 'package:xmw_shop/ui/InvitationPage.dart';
import 'package:xmw_shop/ui/LoginPage.dart';
import 'package:xmw_shop/ui/MainPage.dart';
import 'package:xmw_shop/ui/MyAttentionPage.dart';
import 'package:xmw_shop/ui/MyCentrePage.dart';
import 'package:xmw_shop/ui/MyCollectPage.dart';
import 'package:xmw_shop/ui/MyEnquiryDetailPage.dart';
import 'package:xmw_shop/ui/MyEnquiryPage.dart';
import 'package:xmw_shop/ui/MyGoldPage.dart';
import 'package:xmw_shop/ui/MyHistoryPage.dart';
import 'package:xmw_shop/ui/MyMessagePage.dart';
import 'package:xmw_shop/ui/SampleGetPage.dart';
import 'package:xmw_shop/ui/SearchPage.dart';
import 'package:xmw_shop/ui/SortPage.dart';
import 'package:xmw_shop/ui/UseSayPage.dart';
import 'package:xmw_shop/widgets/LoadingDialog.dart';

import '../MyApplication.dart';
import 'Tool.dart';

class UiHelpDart {
  static BuildContext context;

  static Init(BuildContext mcontext) {
    context = mcontext;
  }

  static void showToast(String msg) {
    if (msg != null && msg.length > 0) {
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1);
    }
  }

  ///返回上一页
  static void redirectToBackPage(BuildContext context) {
    Navigator.pop(context);
  }

  ///退出登录
  static void loginOut() {
    MyApplication.isUserLogin = false;
    eventBus.fire(LoginEvent());
    Tool.delloginInfo();
  }

  static void showLoadingDialog() {
    hideKeyboard();
    BotToast.showCustomLoading(
        clickClose: true,
        allowClick: true,
        toastBuilder: (cancelFunc) {
          return LoadingDialog();
        });
  }

  static void hideLoadingDialog() {
    BotToast.closeAllLoading();
  }

  static void hideKeyboard() {
    if (context != null) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  static void showAlertDialog(BuildContext context, var confirm, String msg) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('提示'),
            content: Text(msg),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text('确认'),
                onPressed: confirm,
              ),
            ],
          );
        });
  }

  ///打开主页
  static void redirectToMainPage(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new MainPage()));
  }

  ///打开登录页
  static void redirectToLoginPage(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new LoginPage()));
  }

  ///打开分类页
  static void redirectToSortPage(
      BuildContext context, String title, String cateId, int type) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new SortPage(title, cateId, type)));
  }

  ///打开详情页
  static void redirectToDetailPage(BuildContext context, String id) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new DetailPage(id)));
  }

  ///打开公司详情页
  static void redirectToCompanyPage(BuildContext context, String id) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new CompanyPage(id)));
  }

  ///打开索取样片
  static void redirectToSampleGetPage(BuildContext context, String id) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new SampleGetPage(id)));
  }

  ///打开文章列表
  static void redirectToInvitationPage(BuildContext context, String id) {
    if (MyApplication.isUserLogin) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new InvitationPage(id)));
    } else {
      redirectToLoginPage(context);
    }
  }

  ///打开文字详情
  static void redirectToInvitationDetailPage(BuildContext context, String id) {
    if (MyApplication.isUserLogin) {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new InvitationDetailPage(id)));
    } else {
      redirectToLoginPage(context);
    }
  }

  ///打开文章发布
  static void redirectToInvitationAddPage(BuildContext context, String id) {
    if (MyApplication.isUserLogin) {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new InvitationAddPage(id)));
    } else {
      redirectToLoginPage(context);
    }
  }

  ///打开新增BOM清单
  static void redirectToBomAddPage(BuildContext context, String id) {
    if (MyApplication.isUserLogin) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new BomAddPage(id)));
    } else {
      redirectToLoginPage(context);
    }
  }

  ///打开BOM列表
  static void redirectToBomDetailPage(BuildContext context, String id) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new BomDetailPage(id)));
  }

  ///打开BOM列表 询价单
  static void redirectToEnquiryPage(BuildContext context, String id) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new EnquiryPage(id)));
  }

  ///打开我的询价单详情
  static void redirectToMyEnquiryDetailPage(BuildContext context, String id) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new MyEnquiryDetailPage(id)));
  }

  ///打开我的芯币
  static void redirectToMyGoldPage(BuildContext context) {
    if (MyApplication.isUserLogin) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new MyGoldPage()));
    } else {
      redirectToLoginPage(context);
    }
  }

  ///打开我的收藏
  static void redirectToMyCollectPage(BuildContext context) {
    if (MyApplication.isUserLogin) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new MyCollectPage()));
    } else {
      redirectToLoginPage(context);
    }
  }

  ///打开个人中心
  static void redirectToMyCentrePage(BuildContext context) {
    if (MyApplication.isUserLogin) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new MyCentrePage()));
    } else {
      redirectToLoginPage(context);
    }
  }

  ///打开我的浏览记录
  static void redirectToMyHistoryPage(BuildContext context) {
    if (MyApplication.isUserLogin) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new MyHistoryPage()));
    } else {
      redirectToLoginPage(context);
    }
  }

  ///打开我的关注
  static void redirectToMyAttentionPage(BuildContext context) {
    if (MyApplication.isUserLogin) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new MyAttentionPage()));
    } else {
      redirectToLoginPage(context);
    }
  }

  ///打开我的 消息
  static void redirectToMyMessagePage(BuildContext context) {
    if (MyApplication.isUserLogin) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new MyMessagePage()));
    } else {
      redirectToLoginPage(context);
    }
  }

  ///打开搜索
  static void redirectToSearchPage(BuildContext context, int type) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new SearchPage(type)));
  }

  ///我的询价单
  static void redirectTMyEnquiryPage(BuildContext context) {
    if (MyApplication.isUserLogin) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new MyEnquiryPage()));
    } else {
      redirectToLoginPage(context);
    }
  }

  static void delBomOrderById(ResponseCallBack callBack, String bomId) {
    if (MyApplication.isUserLogin) {
      ReqQuoteApi.getInstance().delBomOrderById(callBack, bomId);
    }
  }

  ///使用心得
  static void redirectToUseSayPage(BuildContext context, String id) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new UseSayPage(id)));
  }

//
//  static void redirectToOptionalWidget(BuildContext context) {
//    Navigator.push(context,
//        new MaterialPageRoute(builder: (context) => new OptionalModel()));
//  }
//
//  ///mq 1订阅 0取消
//  static void suscribe(int type, String topic) {
//    TopicBean bean = new TopicBean(type, topic);
//    GoldEventBus().event.fire(bean);
//  }
}
