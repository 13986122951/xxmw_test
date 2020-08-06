
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xmw_shop/bean/BomCreateEntity.dart';
import 'package:xmw_shop/bean/SampleSheetReq.dart';

import 'CommentCallBack.dart';
import 'HttpController.dart';
import 'InfoCallBack.dart';
import 'PraiseCallBack.dart';
import 'ResponseCallBack.dart';
import 'URLs.dart';
import 'XmwRequestParams.dart';

class ReqQuoteApi {
  static ReqQuoteApi instance;

  static ReqQuoteApi getInstance() {
    if (instance == null) {
      instance = new ReqQuoteApi();
    }
    return instance;
  }

  ///登录
  loginOrRegister(ResponseCallBack callBack, String mobileNum, String captcha) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.loginOrRegister;
    map["mobileNum"] = mobileNum;
    map["captcha"] = captcha;
    HttpController.postlocal(url, map, callBack);
  }

  ///发生验证码
  sendCaptcha(ResponseCallBack callBack, String mobileNum) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["mobileNum"] = mobileNum;
    String url = URLs.sendCaptcha;
    HttpController.getlocal(url, map, callBack);
  }

  ///查询用户基本信息
  getMemberInfo(ResponseCallBack callBack) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.getMemberInfo;
    HttpController.getlocal(url, map, callBack);
  }

  ///社区首页
  getCommunicates(ResponseCallBack callBack) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.getCommunicates;
    HttpController.getlocal(url, map, callBack);
  }

  ///话题详情
  getTopicBase(ResponseCallBack callBack, String topicId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["bannerId"] = topicId;
    String url = URLs.getTopicBase;
    HttpController.getlocal(url, map, callBack);
  }

  ///话题发帖
  publishPost(
      ResponseCallBack callBack,
      String topicId,
      String title,
      String text,
      String file1,
      String fileName1,
      String file2,
      String fileName2,
      String file3,
      String fileName3) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["topicId"] = topicId;
    map["title"] = title;
    map["text"] = text;
    map["file1"] = file1;
    map["fileName1"] = fileName1;
    map["file2"] = file2;
    map["fileName2"] = fileName2;
    map["file3"] = file3;
    map["fileName3"] = fileName3;
    String url = URLs.publishPost;
    HttpController.postlocal(url, map, callBack);
  }

  ///话题 帖子查询 postType  0-全部，1-精华
  getTopicPostsPage(ResponseCallBack callBack, String topicId, int recordNum,
      int pageSize, int postType) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["topicId"] = topicId;
    map["recordNum"] = recordNum.toString();
    map["pageSize"] = pageSize.toString();
    map["postType"] = postType.toString();
    String url = URLs.getTopicPostsPage;
    HttpController.getlocal(url, map, callBack);
  }

  ///话题 帖子详情
  getPostsDetail(ResponseCallBack callBack, String topicId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["topicId"] = topicId;
    String url = URLs.getPostsDetail;
    HttpController.getlocal(url, map, callBack);
  }

  ///文章发布评论 评论评论
  publishComment(ResponseCallBack callBack, String postsId, String commentText,
      String parentId, String toMemberId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["postsId"] = postsId;
    map["commentText"] = commentText;
    map["parentId"] = parentId;
    map["toMemberId"] = toMemberId;
    String url = URLs.publishComment;
    HttpController.postlocal(url, map, callBack);
  }

  ///文章发布评论 评论评论
  publishComment1(CommentCallBack callBack, String postsId, String commentText,
      String parentId, String toMemberId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["postsId"] = postsId;
    map["commentText"] = commentText;
    map["parentId"] = parentId;
    map["toMemberId"] = toMemberId;
    String url = URLs.publishComment;
    HttpController.postComment(url, map, callBack);
  }

  ///文章下的评论 1-全部，2-楼主
  getPostsReply(ResponseCallBack callBack, String commentId, int startNum,
      int pageSize, String visitType) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["postId"] = commentId;
    map["startNum"] = startNum.toString();
    map["pageSize"] = pageSize.toString();
    map["visitType"] = visitType.toString();
    String url = URLs.getPostsReply;
    HttpController.getlocal(url, map, callBack);
  }

  ///话题 帖子点赞  1-话题关注，2-帖子点赞，3-话题取消关注，4-取消帖子点赞，5-帖子关注，6-取消帖子关注
  praisePost(ResponseCallBack callBack, String topicId, int doType) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["topicId"] = topicId;
    map["doType"] = doType.toString();
    String url = URLs.praisePost;
    HttpController.postlocal(url, map, callBack);
  }

  ///首页
  getIndexInfo(ResponseCallBack callBack) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.getIndexInfo;
    HttpController.getlocal(url, map, callBack);
  }

  ///分类
  getProdCateList(ResponseCallBack callBack) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.getProdCateList;
    HttpController.getlocal(url, map, callBack);
  }

  ///产品详情
  getProdDetailById(ResponseCallBack callBack, String prodId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["prodId"] = prodId;
    String url = URLs.getProdDetailById;
    HttpController.getlocal(url, map, callBack);
  }

  ///产品 加入收藏
  addToMyFavorite(ResponseCallBack callBack, String prodId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["prodId"] = prodId;
    String url = URLs.addToMyFavorite;
    HttpController.postlocal(url, map, callBack);
  }

  ///产品 取消收藏
  cancelProdFavor(ResponseCallBack callBack, String prodId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["prodId"] = prodId;
    String url = URLs.cancelProdFavor;
    HttpController.postlocal(url, map, callBack);
  }

  ///分类下的产品 0-分类下所有，cateId不能为空
  //     *         1-新品
  //     *         2-热门
  getProdsByCateId(ResponseCallBack callBack, String cateId, String getType,
      int recordNum, int pageSize) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["cateId"] = cateId;
    map["getType"] = getType;
    map["startNum"] = recordNum.toString();
    map["pageSize"] = pageSize.toString();
    String url = URLs.getProdsByCateId;
    HttpController.getlocal(url, map, callBack);
  }

  ///新增BOM清单
  createBomOrder(ResponseCallBack callBack, BomCreateEntity entity) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["bomName"] = entity.bomName;
    map["devUnit"] = entity.devUnit;
    map["system"] = entity.system;
    map["partSystem"] = entity.partSystem;
    map["singleMachine"] = entity.singleMachine;
    map["machineDevStep"] = entity.machineDevStep;
    map["remarks"] = entity.remarks;
    map["bomOrderId"] = entity.bomOrderId;
    String url = URLs.createBomOrder;
    HttpController.postlocal(url, map, callBack);
  }

  ///查询BOM清单
  getBomOrders(ResponseCallBack callBack) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.getBomOrders;
    HttpController.getlocal(url, map, callBack);
  }

  ///设置默认
  setBomOrderDefault(ResponseCallBack callBack, String bomOrderId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["bomOrderId"] = bomOrderId;
    String url = URLs.setBomOrderDefault;
    HttpController.postlocal(url, map, callBack);
  }

  ///产品加入（创建）BOM清单
  addProdToBom(ResponseCallBack callBack, String prodId, String inputNum) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["prodId"] = prodId;
    map["inputNum"] = inputNum;
    String url = URLs.addProdToBom;
    HttpController.postlocal(url, map, callBack);
  }

  ///查询一个BOM清单下产品信息
  getBomProds(ResponseCallBack callBack, String bomOrderId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["bomOrderId"] = bomOrderId;
    String url = URLs.getBomProds;
    HttpController.getlocal(url, map, callBack);
  }

  ///删除BOM清单
  delBomOrderById(ResponseCallBack callBack, String bomOrderId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["bomOrderId"] = bomOrderId;
    String url = URLs.delBomOrderById;
    HttpController.postlocal(url, map, callBack);
  }

  ///查询一个BOM清单下产品信息
  getBomInfo(ResponseCallBack callBack, String bomOrderId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["bomOrderId"] = bomOrderId;
    String url = URLs.getBomInfo;
    HttpController.getlocal(url, map, callBack);
  }

  ///根据BOM清单中产品查询询价单数据
  getInquiryList(ResponseCallBack callBack, String bomOrderId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["bomOrderId"] = bomOrderId;
    String url = URLs.getInquiryList;
    HttpController.getlocal(url, map, callBack);
  }

  ///我的收藏
  myFavorite(ResponseCallBack callBack, int recordNum, int pageSize) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.myFavorite;
    map["startNum"] = recordNum.toString();
    map["pageSize"] = pageSize.toString();
    HttpController.getlocal(url, map, callBack);
  }

  ///我的-取消收藏
  cancelFavorite(ResponseCallBack callBack, String favorIds) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.cancelFavorite;
    map["favorIds"] = favorIds;
    HttpController.postlocal(url, map, callBack);
  }

  ///我的-我的关注1-帖子，2-话题
  myAttention(ResponseCallBack callBack, int attentionType, int startNum,
      int pageSize) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.myAttention;
    map["attentionType"] = attentionType.toString();
    map["startNum"] = startNum.toString();
    map["pageSize"] = pageSize.toString();
    HttpController.getlocal(url, map, callBack);
  }

  ///生成询价单
  createInquiryList(ResponseCallBack callBack, String bomOrderId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.createInquiryList;
    map["bomOrderId"] = bomOrderId;
    HttpController.postlocal(url, map, callBack);
  }

  ///我的询价单
  myAllInquiries(ResponseCallBack callBack) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.myAllInquiries;
    HttpController.getlocal(url, map, callBack);
  }

  ///我的询价单详情
  myInquiryDetail(ResponseCallBack callBack, String inquiryId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.myInquiryDetail;
    map["inquiryId"] = inquiryId;
    HttpController.getlocal(url, map, callBack);
  }

  ///我的消息 msgType:1-公共通知，2-指定通知
  myMessages(
      ResponseCallBack callBack, int msgType, int recordNum, int pageSize) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.myMessages;
    map["msgType"] = msgType.toString();
    map["startNum"] = recordNum.toString();
    map["pageSize"] = pageSize.toString();
    HttpController.getlocal(url, map, callBack);
  }

  ///厂家信息
  getCreateCompInfo(ResponseCallBack callBack, String compId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.getCreateCompInfo;
    map["compId"] = compId;
    HttpController.getlocal(url, map, callBack);
  }

  ///我的足迹
  myViewProdHis(ResponseCallBack callBack, int recordNum, int pageSize) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.myViewProdHis;
    map["startNum"] = recordNum.toString();
    map["pageSize"] = pageSize.toString();
    HttpController.getlocal(url, map, callBack);
  }

  ///我的足迹 删除足迹
  clearFootView(ResponseCallBack callBack, String viewIds) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.clearFootView;
    map["viewIds"] = viewIds;
    HttpController.postlocal(url, map, callBack);
  }

  ///产品-索取样片
  sampleSheet(ResponseCallBack callBack, SampleSheetReq req) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.sampleSheet;
    map["userName"] = req.userName;
    map["prodId"] = req.prodId;
    map["prodName"] = req.prodName;
    map["unitName"] = req.unitName;
    map["useScene"] = req.useScene;
    map["needNum"] = req.needNum.toString();
    map["receiveAddr"] = req.receiveAddr;
    map["linkPhone"] = req.linkPhone;
    HttpController.postlocal(url, map, callBack);
  }

  ///我的信息修改
  improveInfo(ResponseCallBack callBack, String key, String value) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.improveInfo;
    map[key] = value;
    HttpController.postlocal(url, map, callBack);
  }

  ///我的信息修改  头像
  improveInfoHead(ResponseCallBack callBack, String photo, String fileName) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["photo"] = photo;
    map["fileName"] = fileName;
    String url = URLs.improveInfo;
    HttpController.postlocal(url, map, callBack);
  }

  ///搜索帖子
  searchPostByTitle(ResponseCallBack callBack, String searchText, int startNum,
      int pageSize) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.searchPostByTitle;
    map["searchText"] = searchText;
    map["startNum"] = startNum.toString();
    map["pageSize"] = pageSize.toString();
    HttpController.getlocal(url, map, callBack);
  }

  ///搜索产品
  searchProd(
      ResponseCallBack callBack, String prodName, int startNum, int pageSize) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.searchProd;
    map["prodName"] = prodName;
    map["startNum"] = startNum.toString();
    map["pageSize"] = pageSize.toString();
    HttpController.getlocal(url, map, callBack);
  }

  ///帖子评论+回复分页（获取一条评论下所有回复）
  getCommentsReply(ResponseCallBack callBack, String postId, String commentId,
      int startNum, int pageSize) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.getCommentsReply;
    map["postId"] = postId;
    map["commentId"] = commentId;
    map["startNum"] = startNum.toString();
    map["pageSize"] = pageSize.toString();
    map["visitType"] = "1";
    HttpController.getlocal(url, map, callBack);
  }

  ///根据评论ID获取本条评论及回复信息
  getOneComment(InfoCallBack callBack, String commentId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.getOneComment;
    map["commentId"] = commentId;
    HttpController.getlocalInfo(url, map, callBack);
  }

  ///点赞评论 doType ：1点赞，0取消点赞
  praiseComment(PraiseCallBack callBack, String commentId, String doType) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.praiseComment;
    map["commentId"] = commentId;
    map["doType"] = doType;
    HttpController.postPraiselocal(url, map, callBack);
  }

  ///移除BOM单中产品
  removeBomProd(ResponseCallBack callBack, String bomId, String prodIds) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.removeBomProd;
    map["bomId"] = bomId;
    map["prodIds"] = prodIds;
    HttpController.postlocal(url, map, callBack);
  }

  ///使用心得
  customUseSay(
      ResponseCallBack callBack, String prodId, int startNum, int pageSize) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.customUseSay;
    map["prodId"] = prodId;
    map["startNum"] = startNum.toString();
    map["pageSize"] = pageSize.toString();
    HttpController.getlocal(url, map, callBack);
  }

  ///使用心得 发布
  submitCustomSay(
      ResponseCallBack callBack, String prodId, String commentText) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.submitCustomSay;
    map["prodId"] = prodId;
    map["commentText"] = commentText;
    map["startNum"] = "0";
    HttpController.postlocal(url, map, callBack);
  }

  ///使用心得 1点赞，0取消点赞
  praiseCustomSay(ResponseCallBack callBack, String commentId, int doType) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.praiseCustomSay;
    map["commentId"] = commentId;
    map["doType"] = doType.toString();
    map["startNum"] = "0";
    HttpController.postlocal(url, map, callBack);
  }

  ///用户芯币产生/消费交易记录//产生渠道：1-登录，2-浏览，3-分享，4-个人信息完善，5-导出BOM单，6-下载资料  //产生方式：1-获取，2-消费
  memberXinChange(ResponseCallBack callBack, String channel,
      String createMethod, String prodId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.memberXinChange;
    map["channel"] = channel;
    map["createMethod"] = createMethod;
    map["prodId"] = prodId;
    HttpController.postlocal(url, map, callBack);
  }

  ///个人中心-默认加载广告
  getCenterAdv(ResponseCallBack callBack) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    String url = URLs.getCenterAdv;
    HttpController.getlocal(url, map, callBack);
  }

  ///导出BOM清单表格下载
  exportBomOrder(ResponseCallBack callBack,String bomOrderId) {
    Map<String, String> map = XmwRequestParams.RequestParams();
    map["bomOrderId"] = bomOrderId;
    String url = URLs.exportBomOrder;
    HttpController.getlocal(url, map, callBack);
  }

}