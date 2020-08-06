class BomListEntity {
  String msg;
  int code;
  List<BomListData> data;

  BomListEntity({this.msg, this.code, this.data});

  BomListEntity.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data = new List<BomListData>();
      (json['data'] as List).forEach((v) {
        data.add(new BomListData.fromJson(v));
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

class BomListData {
  String prodImg;
  String bomId;
  int addTime;
  int bingInNum;
  String bomName;
  int countryNum;
  int sumNum;
  String remarks;
  int ifDefault;

  BomListData(
      {this.prodImg,
      this.bomId,
      this.addTime,
      this.bingInNum,
      this.bomName,
      this.countryNum,
      this.sumNum,
      this.remarks,
      this.ifDefault});

  BomListData.fromJson(Map<String, dynamic> json) {
    prodImg = json['prodImg'];
    bomId = json['bomId'];
    addTime = json['addTime'];
    bingInNum = json['bingInNum'];
    bomName = json['bomName'];
    countryNum = json['countryNum'];
    sumNum = json['sumNum'];
    remarks = json['remarks'];
    ifDefault = json['ifDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prodImg'] = this.prodImg;
    data['bomId'] = this.bomId;
    data['addTime'] = this.addTime;
    data['bingInNum'] = this.bingInNum;
    data['bomName'] = this.bomName;
    data['countryNum'] = this.countryNum;
    data['sumNum'] = this.sumNum;
    data['remarks'] = this.remarks;
    data['ifDefault'] = this.ifDefault;
    return data;
  }
}
