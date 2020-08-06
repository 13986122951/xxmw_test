import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:xmw_shop/bean/BaseBean.dart';
import 'package:xmw_shop/common/PictureCallBack.dart';
import 'package:xmw_shop/common/event_bus.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/CromputerUtils.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/InvitationAddTitleBar.dart';
import 'package:xmw_shop/widgets/SelectImgSheet.dart';

import 'InvitationPage.dart';

//发布帖子
String topicId;
InvitationAddState invitationAddState;

class InvitationAddPage extends StatefulWidget {
  InvitationAddPage(String id) {
    topicId = id;
  }

  @override
  State<StatefulWidget> createState() {
    invitationAddState = new InvitationAddState();
    return invitationAddState;
  }
}

var imgPath1, imgPath2, imgPath3;
File file1, file2, file3;

class InfoCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    UiHelpDart.hideLoadingDialog();
    UiHelpDart.showToast(CromputerUtils.net_error);
  }

  @override
  void onSuccess(String var3) {
    UiHelpDart.hideLoadingDialog();
    Map<String, dynamic> json = jsonDecode(var3);
    BaseBean baseBean = BaseBean.fromJson(json);
    if (baseBean != null) {
      if (baseBean.code == 0) {
        UiHelpDart.showToast("发布成功");
        invitationAddState.updata();
      } else {
        UiHelpDart.showToast(baseBean.msg);
      }
    }
  }
}

class InvitationAddState extends State<InvitationAddPage>
    implements PictureCallBack {
  String fileStr1;
  String fileName1;
  String fileStr2;
  String fileName2;
  String fileStr3;
  String fileName3;

  OnClick() async {
    if (StringUtils.isEmpty(titleStr)) {
      UiHelpDart.showToast("文章标题不能为空");
      return;
    }
    if (titleStr.length > 12) {
      UiHelpDart.showToast("文章标题超过12个字");
      return;
    }
    if (StringUtils.isEmpty(contentStr)) {
      UiHelpDart.showToast("文章内容不能为空");
      return;
    }

    UiHelpDart.showLoadingDialog();
    ReqQuoteApi.getInstance().publishPost(
        new InfoCallBack(),
        pkid,
        titleStr,
        contentStr,
        fileStr1,
        fileName1,
        fileStr2,
        fileName2,
        fileStr3,
        fileName3);
  }

  updata() {
    Navigator.pop(context);
    eventBus.fire(InvitationAddEvent());
  }

  @override
  void dispose() {
    super.dispose();
    imgPath1 = null;
    imgPath2 = null;
    imgPath3 = null;
    file1 = null;
    file2 = null;
    file3 = null;
  }

  @override
  void callBack(File file, int index) {
    if (file != null) {
      loadImage(file, index);
    }
  }

  Future _openModalBottomSheet(int index) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SelectImgSheet(this, index);
        });
  }

  loadImage(File file, int index) async {
    if (index == 1) {
      file1 = file;
      imgPath1 = file.path;
      if (file1 != null) {
        List<int> result3 = await FlutterImageCompress.compressWithFile(
          file1.absolute.path,
          quality: 80,
        );
        if (result3.length > (1024 * 1024 * 5)) {
          UiHelpDart.showToast("图片过大");
          return;
        }
        fileStr1 = await convert.base64Encode(result3);
        print(fileStr1);
        String path = file1.path;
        fileName1 = path.substring(path.lastIndexOf("/") + 1, path.length);
      }
    } else if (index == 2) {
      file2 = file;
      imgPath2 = file.path;
      if (file2 != null) {
        List<int> result2 = await FlutterImageCompress.compressWithFile(
          file2.absolute.path,
          quality: 80,
        );
        if (result2.length > (1024 * 1024 * 5)) {
          UiHelpDart.showToast("图片过大");
          return;
        }
        fileStr2 = await convert.base64Encode(result2);
        print(fileStr2);
        String path = file2.path;
        fileName2 = path.substring(path.lastIndexOf("/") + 1, path.length);
      }
    } else if (index == 3) {
      file3 = file;
      imgPath3 = file.path;
      if (file3 != null) {
        List<int> result1 = await FlutterImageCompress.compressWithFile(
          file3.absolute.path,
          quality: 80,
        );
        if (result1.length > (1024 * 1024 * 5)) {
          UiHelpDart.showToast("图片过大");
          return;
        }

        fileStr3 = await convert.base64Encode(result1);
        print(fileStr3);
        String path = file3.path;
        fileName3 = path.substring(path.lastIndexOf("/") + 1, path.length);
      }
    }

    setState(() {});
  }

  selectPrice1() {
    _openModalBottomSheet(1);
  }

  selectPrice2() {
    _openModalBottomSheet(2);
  }

  selectPrice3() {
    _openModalBottomSheet(3);
  }

  double height, contentHeight;
  String titleStr, contentStr;

  @override
  Widget build(BuildContext context) {
    height = (MediaQuery.of(context).size.width - 40) / 3;
    contentHeight = (MediaQuery.of(context).size.height) / 3;
    return Scaffold(
        appBar: InvitationAddTitleBar(OnClick),
        backgroundColor: Colors.white,
        body: EasyRefresh(
            child: Column(
          children: <Widget>[
            getTitleWidget(),
            Container(
              height: 1,
              color: ResColors.color_bg_color,
            ),
            getContentWidget(),
            Container(
              height: 1,
              color: ResColors.color_bg_color,
            ),
            Row(
              children: <Widget>[
                Expanded(child: getLeftImageWidget()),
                Expanded(child: getCentreImageWidget()),
                Expanded(child: getRightImageWidget()),
              ],
            )
          ],
        )));
  }

  Widget getLeftImageWidget() {
    if (imgPath1 != null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: () {
          imgPath1 = null;
          if (imgPath2 != null) {
            imgPath1 = imgPath2;
            file1 = file2;
            imgPath2 = null;
          }
          if (imgPath3 != null) {
            imgPath2 = imgPath3;
            file2 = file3;
            imgPath3 = null;
            file3 = null;
          }

          setState(() {});
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
          height: height,
          width: height,
          color: ResColors.color_bg_color,
          child: Image.file(
            file1,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
        height: height,
        width: height,
        color: ResColors.color_bg_color,
        child: getAddImageWidget(selectPrice1),
      );
    }
  }

  Widget getCentreImageWidget() {
    if (imgPath2 != null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: () {
          imgPath2 = null;
          if (imgPath3 != null) {
            imgPath2 = imgPath3;
            file2 = file3;
            imgPath3 = null;
            file3 = null;
          }
          setState(() {});
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
          height: height,
          width: height,
          color: ResColors.color_bg_color,
          child: Image.file(
            file2,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      if (imgPath1 == null) {
        return Container(
          margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
          height: height,
          width: height,
          color: Colors.white,
        );
      } else {
        return Container(
          margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
          height: height,
          width: height,
          color: ResColors.color_bg_color,
          child: getAddImageWidget(selectPrice2),
        );
      }
    }
  }

  Widget getRightImageWidget() {
    if (imgPath3 != null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: () {
          imgPath3 = null;
          file3 = null;
          setState(() {});
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
          height: height,
          width: height,
          color: ResColors.color_bg_color,
          child: Image.file(
            file3,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      if (imgPath2 == null) {
        return Container(
          margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
          height: height,
          width: height,
          color: Colors.white,
        );
      } else {
        return Container(
          margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
          height: height,
          width: height,
          color: ResColors.color_bg_color,
          child: getAddImageWidget(selectPrice3),
        );
      }
    }
  }

  Widget getAddImageWidget(selectPrice) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: selectPrice,
      child: Container(
        height: height,
        width: height,
        color: ResColors.color_bg_color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "+",
              style: TextStyle(color: ResColors.color_font_3_color),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                "添加照片",
                style: TextStyle(color: ResColors.color_font_3_color),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getTitleWidget() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: TextField(
            maxLength: 12,
            minLines: 1,
            onChanged: (value) {
              titleStr = value;
            },
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: "请输入标题最长12个字",
              border: InputBorder.none,
            ),
          ),
        ))
      ],
    );
  }

  Widget getContentWidget() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          height: contentHeight,
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: TextField(
            maxLines: 20,
            onChanged: (value) {
              contentStr = value;
            },
            keyboardType: TextInputType.multiline,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: "请输入文章内容",
              border: InputBorder.none,
            ),
          ),
        ))
      ],
    );
  }
}
