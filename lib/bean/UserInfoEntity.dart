class UserInfoEntity {
  String msg;
  int code;
  UserInfoData data;

  UserInfoEntity({this.msg, this.code, this.data});

  UserInfoEntity.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data =
        json['data'] != null ? new UserInfoData.fromJson(json['data']) : null;
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

class UserInfoData {
  String acctMobile;
  String nickName;
  int xinPoint;
  String photo;
  int memberType;
  String memberId;
  String token;
  String remarks;

  UserInfoData(
      {this.acctMobile,
      this.nickName,
      this.xinPoint,
      this.photo,
      this.memberType,
      this.memberId,
      this.token,
      this.remarks});

  UserInfoData.fromJson(Map<String, dynamic> json) {
    acctMobile = json['acctMobile'];
    nickName = json['nickName'];
    xinPoint = json['xinPoint'];
    photo = json['photo'];
    memberType = json['memberType'];
    memberId = json['memberId'];
    token = json['token'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acctMobile'] = this.acctMobile;
    data['nickName'] = this.nickName;
    data['xinPoint'] = this.xinPoint;
    data['photo'] = this.photo;
    data['memberType'] = this.memberType;
    data['memberId'] = this.memberId;
    data['token'] = this.token;
    data['remarks'] = this.remarks;
    return data;
  }
}
