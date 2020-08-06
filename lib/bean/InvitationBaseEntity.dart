class InvitationBaseEntity {
  String msg;
  int code;
  InvitationBaseData data;

  ///话题基本信息
  InvitationBaseEntity({this.msg, this.code, this.data});

  InvitationBaseEntity.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null
        ? new InvitationBaseData.fromJson(json['data'])
        : null;
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

class InvitationBaseData {
  int ableState;
  int isDelete;
  int ifFocus; //是否关注  0  没有v关注  1关注
  String id;
  String title;
  String remarks;

  InvitationBaseData(
      {this.ableState,
      this.isDelete,
      this.id,
      this.title,
      this.remarks,
      this.ifFocus});

  InvitationBaseData.fromJson(Map<String, dynamic> json) {
    ableState = json['ableState'];
    isDelete = json['isDelete'];
    id = json['id'];
    title = json['title'];
    remarks = json['remarks'];
    ifFocus = json['ifFocus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ableState'] = this.ableState;
    data['isDelete'] = this.isDelete;
    data['id'] = this.id;
    data['title'] = this.title;
    data['remarks'] = this.remarks;
    data['ifFocus'] = this.ifFocus;
    return data;
  }
}
