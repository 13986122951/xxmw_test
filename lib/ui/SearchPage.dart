import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:xmw_shop/bean/HomePageEntity.dart';
import 'package:xmw_shop/bean/SearchProdEntity.dart';
import 'package:xmw_shop/bean/SerahPostEntity.dart';
import 'package:xmw_shop/bean/TopicPostListEntity.dart';
import 'package:xmw_shop/common/InputCallBack.dart';
import 'package:xmw_shop/net/ReqQuoteApi.dart';
import 'package:xmw_shop/net/ResponseCallBack.dart';
import 'package:xmw_shop/utils/ResColors.dart';
import 'package:xmw_shop/utils/StringUtils.dart';
import 'package:xmw_shop/utils/UiHelpDart.dart';
import 'package:xmw_shop/widgets/HomeRemItemWidget.dart';
import 'package:xmw_shop/widgets/HotBBSItemWidget.dart';
import 'package:xmw_shop/widgets/SearchPageTitleBar.dart';

int recordNum = 1;
int pageSize = 30;
bool isMore = false;
bool isRefresh = true;
SearchState searchState;

class SearchPage extends StatefulWidget {
  int type = 0; //0搜索元器件  1搜索帖子
  String searchContent = "";

  SearchPage(this.type) {}

  @override
  State<StatefulWidget> createState() {
    searchState = new SearchState();
    return searchState;
  }
}

EasyRefreshController _controller = EasyRefreshController();

class ProdCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    Map<String, dynamic> json = jsonDecode(var3);
    SearchProdEntity baseBean = SearchProdEntity.fromJson(json);
    if (baseBean != null && baseBean.code == 0) {
      searchState.updateProd(baseBean.data);
    }
  }
}

class PostCallBack implements ResponseCallBack {
  @override
  void onFailure(String var3) {
    _controller.finishRefresh(success: true);
  }

  @override
  void onSuccess(String var3) {
    _controller.finishRefresh(success: true);
    Map<String, dynamic> json = jsonDecode(var3);
    SerahPostEntity baseBean = SerahPostEntity.fromJson(json);
    if (baseBean != null && baseBean.code == 0 && baseBean.data != null) {
      recordNum += 1;
      searchState.updatePost(baseBean.data);
    }
  }
}

searchPostByTitle(String content) {
  ReqQuoteApi.getInstance()
      .searchPostByTitle(new PostCallBack(), content, recordNum, pageSize);
}

searchProd(String content) {
  ReqQuoteApi.getInstance()
      .searchProd(new ProdCallBack(), content, recordNum, pageSize);
}

class SearchState extends State<SearchPage> implements InputCallBack {
  String hintStr = "请输入元器件名称";

  @override
  void initState() {
    if (widget.type == 0) {
      hintStr = "请输入元器件名称";
    } else {
      hintStr = "请输入文章标题";
    }
  }

  List<SerahPostData> postdata = [];

  updatePost(List<SerahPostData> data) {
    if (isRefresh) {
      postdata.clear();
    }
    if (data.length == pageSize) {
      isMore = true;
      recordNum += 1;
    } else {
      isMore = false;
    }
    postdata.addAll(data);
    if (data.length < pageSize) {
      isMore = false;
    } else {
      isMore = true;
    }
    setState(() {});
  }

  List<SearchProdData> proddata = [];

  updateProd(List<SearchProdData> data) {
    if (isRefresh) {
      proddata.clear();
    }
    if (data.length == pageSize) {
      isMore = true;
      recordNum += 1;
    } else {
      isMore = false;
    }
    proddata.addAll(data);
    setState(() {});
  }

  Future<Null> _refresh() async {
    recordNum = 1;
    isRefresh = true;
    if (widget.type == 0) {
      searchProd(widget.searchContent);
    } else {
      searchPostByTitle(widget.searchContent);
    }
  }

  Future<Null> _onload() async {
    isRefresh = false;
    if (widget.type == 0) {
      searchProd(widget.searchContent);
    } else {
      searchPostByTitle(widget.searchContent);
    }
  }

  @override
  void onInputContent(int type, String content) {
    if (StringUtils.isEmpty(content)) {
      UiHelpDart.showToast("搜索内容不能为空");
      return;
    }
    widget.searchContent = content;
    if (widget.type == 0) {
      searchProd(content);
    } else {
      searchPostByTitle(content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SearchPageTitleBar(
        this,
        hintText: hintStr,
        contentText: widget.searchContent,
      ),
      body: Container(
        color: ResColors.divided_color,
        child: EasyRefresh(
          header: MaterialHeader(
            backgroundColor: Colors.blue,
          ),
          footer: MaterialFooter(
            backgroundColor: Colors.blue,
          ),
          onRefresh: _refresh,
          onLoad: isMore ? _onload : null,
          enableControlFinishRefresh: true,
          controller: _controller,
          child: Column(
            children: <Widget>[
              Container(
                height: 1,
              ),
              getHotBBSWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getHotBBSWidget() {
    if (widget.type == 0) {
      return ListView.builder(
          itemCount: proddata.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            SearchProdData prodData = proddata[index];
            HomePageDataNewprod dataNewprod = new HomePageDataNewprod();
            dataNewprod.dengJi = prodData.prodGrade;
            dataNewprod.xinHao = prodData.xinHao;
            dataNewprod.danWei = prodData.createComp;
            dataNewprod.title = prodData.prodName;
            dataNewprod.imgPath = prodData.imgPath;
            dataNewprod.pkId = prodData.prodId;
            return HomeRemItemWidget(false, false, dataNewprod);
          });
    } else {
      return ListView.builder(
          itemCount: postdata.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            SerahPostData postData = postdata[index];
            TopicPostListData listData = new TopicPostListData();
            listData.photo = postData.authorPhoto;
            listData.postTitle = postData.postTitle;
            listData.contentHead = postData.content;
            listData.commentNum = postData.commentNum;
            listData.praiseNum = postData.praiseNum;
            listData.postId = postData.postId;
            listData.publishTimes = postData.createTime;
            return HotBBSItemWidget(listData);
          });
    }
  }
}
