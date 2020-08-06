import 'package:flutter/material.dart';
import 'package:xmw_shop/common/InputCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';

class BottomInputDialog extends StatefulWidget {
  int maxLength = 10;
  String butText = "保存";
  String hintText = "请输入内容";
  InputCallBack inputCallBack;
  int type = 0;

  BottomInputDialog(this.inputCallBack, this.type,
      {Key key,
      this.maxLength = 10,
      this.butText = "保存",
      this.hintText = "请输入内容"}) {}

  @override
  State<StatefulWidget> createState() {
    return BottomInputState();
  }
}

class BottomInputState extends State<BottomInputDialog> {
  TextEditingController controller = new TextEditingController();
  String currentStr;

  @override
  void initState() {
    controller.addListener(() {
      currentStr = controller.text;
    });
  }

  void saveContent() {
    if (StringUtils.isEmpty(currentStr)) {
      UiHelpDart.showToast("不能为空");
    } else {
      if (widget.inputCallBack != null) {
        widget.inputCallBack.onInputContent(widget.type, currentStr);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new Column(
        children: <Widget>[
          Expanded(
              child: new GestureDetector(
            child: new Container(
              color: Colors.black54,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )),
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                    child: new Container(
                        height: 60,
                        color: Colors.white,
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: controller,
                          autofocus: true,
                          maxLines: 100,
                          maxLength: widget.maxLength,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                              hintText: widget.hintText),
                          style: TextStyle(
                              fontSize: 14,
                              color: ResColors.color_font_3_color),
                        ))),
                GestureDetector(
                  onTap: saveContent,
                  child: Container(
                    width: 70,
                    height: 40,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular((5.0))),
                    child: Text(widget.butText,
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
