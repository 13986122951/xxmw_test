import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xmw_shop/common/PictureCallBack.dart';

PictureCallBack callBack;
int index;

//选择图片 弹出框
class SelectImgSheet extends StatefulWidget {
  SelectImgSheet(PictureCallBack callBacks, int indexs) {
    callBack = callBacks;
    index = indexs;
  }

  @override
  State<StatefulWidget> createState() {
    return SelectImgState();
  }
}

class SelectImgState extends State<SelectImgSheet> {
/*拍照*/
  _takePhoto() async {
    Navigator.pop(context, '取消');
    var path = await ImagePicker.pickImage(source: ImageSource.camera);
    if (callBack != null) {
      callBack.callBack(path, index);
    }
  }

  /*相册*/
  _openGallery() async {
    Navigator.pop(context, '取消');
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (callBack != null) {
      callBack.callBack(image, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new RaisedButton(
                    onPressed: _takePhoto,
                    //通过控制 Text 的边距来控制控件的高度
                    child: new Padding(
                      padding: new EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 15.0),
                      child: new Text(
                        "拍照",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    elevation: 0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new RaisedButton(
                    onPressed: _openGallery,
                    //通过控制 Text 的边距来控制控件的高度
                    child: new Padding(
                      padding: new EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 15.0),
                      child: new Text(
                        "从相册选择",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    elevation: 0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new RaisedButton(
                    onPressed: () {
                      Navigator.pop(context, '取消');
                    },
                    //通过控制 Text 的边距来控制控件的高度
                    child: new Padding(
                      padding: new EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 15.0),
                      child: new Text(
                        "取消",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    elevation: 0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
