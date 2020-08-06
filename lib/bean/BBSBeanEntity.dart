class BBSBeanEntity {
  String msg;
  int code;
  BBSBeanData data;

  BBSBeanEntity({this.msg, this.code, this.data});

  BBSBeanEntity.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? new BBSBeanData.fromJson(json['data']) : null;
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

class BBSBeanData {
  List<BBSBeanDataComnavlist> comNavList;
  List<BBSBeanDataComnavlist> exchangeList;
  List<BBSBeanDataComnavlist> knowList;

  BBSBeanData({this.comNavList, this.exchangeList, this.knowList});

  BBSBeanData.fromJson(Map<String, dynamic> json) {
    if (json['comNavList'] != null) {
      comNavList = new List<BBSBeanDataComnavlist>();
      (json['comNavList'] as List).forEach((v) {
        comNavList.add(new BBSBeanDataComnavlist.fromJson(v));
      });
    }
    if (json['exchangeList'] != null) {
      exchangeList = new List<BBSBeanDataComnavlist>();
      (json['exchangeList'] as List).forEach((v) {
        exchangeList.add(new BBSBeanDataComnavlist.fromJson(v));
      });
    }
    if (json['knowList'] != null) {
      knowList = new List<BBSBeanDataComnavlist>();
      (json['knowList'] as List).forEach((v) {
        knowList.add(new BBSBeanDataComnavlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comNavList != null) {
      data['comNavList'] = this.comNavList.map((v) => v.toJson()).toList();
    }
    if (this.exchangeList != null) {
      data['exchangeList'] = this.exchangeList.map((v) => v.toJson()).toList();
    }
    if (this.knowList != null) {
      data['knowList'] = this.knowList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BBSBeanDataComnavlist {
  String funcName;
  String pkId;
  String imgPath;

  BBSBeanDataComnavlist({this.funcName, this.pkId, this.imgPath});

  BBSBeanDataComnavlist.fromJson(Map<String, dynamic> json) {
    funcName = json['funcName'];
    pkId = json['pkId'];
    imgPath = json['imgPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['funcName'] = this.funcName;
    data['pkId'] = this.pkId;
    data['imgPath'] = this.imgPath;
    return data;
  }
}
