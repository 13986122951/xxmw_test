class PostDetailEntity {
  String msg;
  int code;
  PostDetailData data;

  PostDetailEntity({this.msg, this.code, this.data});

  PostDetailEntity.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data =
        json['data'] != null ? new PostDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class PostDetailData {
  int commentNum;
  int publishTime;
  String images;
  String photo;
  int praiseNum;
  String text;
  String title;
  int curUserPraise;
  String remarks;
  int ifFocus; //是否关注  0  没有v关注  1关注


  PostDetailData(
      {this.commentNum,
      this.publishTime,
      this.images,
      this.photo,
      this.praiseNum,
      this.text,
      this.title,
      this.curUserPraise,
      this.ifFocus,
      this.remarks});

  PostDetailData.fromJson(Map<String, dynamic> json) {
    commentNum = json['commentNum'];
    publishTime = json['publishTime'];
    images = json['images'];
    photo = json['photo'];
    praiseNum = json['praiseNum'];
    text = json['text'];
    title = json['title'];
    curUserPraise = json['curUserPraise'];
    ifFocus = json['ifFocus'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentNum'] = this.commentNum;
    data['publishTime'] = this.publishTime;
    data['images'] = this.images;
    data['photo'] = this.photo;
    data['praiseNum'] = this.praiseNum;
    data['text'] = this.text;
    data['title'] = this.title;
    data['curUserPraise'] = this.curUserPraise;
    data['ifFocus'] = this.ifFocus;
    data['remarks'] = this.remarks;
    return data;
  }
}
