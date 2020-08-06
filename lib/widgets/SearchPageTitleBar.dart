import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xmw_shop/common/InputCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

FocusNode mFocusNode = FocusNode();

class SearchPageTitleBar extends StatelessWidget
    implements PreferredSizeWidget {
  String hintText = "";
  String contentText = "";
  InputCallBack callBack;
  TextEditingController controller = new TextEditingController();

  SearchPageTitleBar(this.callBack, {Key key, this.hintText, this.contentText});

  String currentStr;

  void save() {
    mFocusNode.unfocus();
    UiHelpDart.hideKeyboard();
    if (callBack != null) {
      callBack.onInputContent(0, currentStr);
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      currentStr = controller.text;
    });
    controller.text = contentText;
    return Container(
      child: SafeArea(
        top: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                UiHelpDart.hideKeyboard();
                Navigator.pop(context);
              },
              child: Container(
                width: 30,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Image.asset("assets/images/icon_back.png"),
              ),
            ),
            Expanded(
              child: Container(
                height: 35,
                //设置 child 居中
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                //边框设置
                decoration: new BoxDecoration(
                  //背景
                  color: ResColors.color_bg_color,
                  //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  //设置四周边框
                  border:
                      new Border.all(width: 0, color: ResColors.color_bg_color),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 20,
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Image.asset("assets/images/home_title_search.png"),
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      child: TextField(
                        focusNode: mFocusNode,
                        controller: controller,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10.0),
                          hintText: hintText,
                          border: InputBorder.none,
                        ),
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 14, color: ResColors.color_font_3_color),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: save,
              behavior: HitTestBehavior.opaque,
              child: Container(
                alignment: Alignment.center,
                width: 60,
                child: Container(
                  child: Text(
                    "搜索",
                    style: TextStyle(color: ResColors.color_font_3_color),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45);
}
