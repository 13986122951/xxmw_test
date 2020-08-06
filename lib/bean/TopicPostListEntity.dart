class TopicPostListEntity {
  String msg;
  int code;
  List<TopicPostListData> data;

  TopicPostListEntity({this.msg, this.code, this.data});

  TopicPostListEntity.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data = new List<TopicPostListData>();
      (json['data'] as List).forEach((v) {
        data.add(new TopicPostListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopicPostListData {
  int commentNum;
  String contentHead;
  int ifHot;
  int praiseNum;
  String postTitle;
  String postId;
  int publishTimes;
  int curUserPraise;
  int ifTop;
  String photo;

  TopicPostListData(
      {this.commentNum,
      this.contentHead,
      this.ifHot,
      this.praiseNum,
      this.postTitle,
      this.postId,
      this.publishTimes,
      this.curUserPraise,
      this.ifTop,
      this.photo});

  TopicPostListData.fromJson(Map<String, dynamic> json) {
    commentNum = json['commentNum'];
    contentHead = json['contentHead'];
    ifHot = json['ifHot'];
    praiseNum = json['praiseNum'];
    postTitle = json['postTitle'];
    postId = json['postId'];
    publishTimes = json['publishTimes'];
    curUserPraise = json['curUserPraise'];
    ifTop = json['ifTop'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentNum'] = this.commentNum;
    data['contentHead'] = this.contentHead;
    data['ifHot'] = this.ifHot;
    data['praiseNum'] = this.praiseNum;
    data['postTitle'] = this.postTitle;
    data['postId'] = this.postId;
    data['publishTimes'] = this.publishTimes;
    data['curUserPraise'] = this.curUserPraise;
    data['ifTop'] = this.ifTop;
    data['photo'] = this.photo;
    return data;
  }
}
