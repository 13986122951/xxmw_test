import 'dart:async';


import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'package:flutter_easyrefresh/material_header.dart';

import 'package:flutter_easyrefresh/material_footer.dart';

/// 质感设计样式

class MaterialPage extends StatefulWidget {
  @override
  MaterialPageState createState() {
    return MaterialPageState();
  }
}

class MaterialPageState extends State<MaterialPage> {
  // 总数

  int _count = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material'),
        backgroundColor: Colors.black,
      ),
      body: EasyRefresh.custom(
        header: MaterialHeader(backgroundColor: Colors.blue,),
        footer: MaterialFooter(backgroundColor: Colors.blue,),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                _count = 20;
              });
            }
          });
        },
        onLoad: () async {
          await Future.delayed(Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                _count += 20;
              });
            }
          });
        },
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Text(index.toString());
              },
              childCount: _count,
            ),
          ),
        ],
      ),
    );
  }
}
