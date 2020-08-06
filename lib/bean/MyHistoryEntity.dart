class MyHistoryEntity {
  String msg;
  int code;
  List<MyHistoryData> data;

  MyHistoryEntity({this.msg, this.code, this.data});

  MyHistoryEntity.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data = new List<MyHistoryData>();
      (json['data'] as List).forEach((v) {
        data.add(new MyHistoryData.fromJson(v));
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

class MyHistoryData {
  String perGrade;
  String imgPath;
  String prodName;
  String xinHao;
  String prodId;
  String createComp;
  String pkId;

  MyHistoryData(
      {this.perGrade,
      this.imgPath,
      this.prodName,
      this.xinHao,
      this.prodId,
      this.pkId,
      this.createComp});

  MyHistoryData.fromJson(Map<String, dynamic> json) {
    perGrade = json['perGrade'];
    imgPath = json['imgPath'];
    prodName = json['prodName'];
    xinHao = json['xinHao'];
    prodId = json['prodId'];
    createComp = json['createComp'];
    pkId = json['pkId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['perGrade'] = this.perGrade;
    data['imgPath'] = this.imgPath;
    data['prodName'] = this.prodName;
    data['xinHao'] = this.xinHao;
    data['prodId'] = this.prodId;
    data['createComp'] = this.createComp;
    data['pkId'] = this.pkId;
    return data;
  }
}
