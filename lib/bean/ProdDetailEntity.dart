class ProdDetailEntity {
  String msg;
  int code;
  ProdDetailData data;

  ProdDetailEntity({this.msg, this.code, this.data});

  ProdDetailEntity.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data =
        json['data'] != null ? new ProdDetailData.fromJson(json['data']) : null;
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

class ProdDetailData {
  String prodImg;
  String doMain;
  String xFactory;
  String downHref; //产品手册下载地址
  String costPrice;
  String authOrg;
  String mainFun;
  String devStand;
  String qualityGrade;
  String radix;
  String prodCode;
  String smallCateName;
  String xinHaoGuiGe;
  int ifFavour; //1收藏
  String staticElectric;
  String prodName;
  String tempRange;
  List<Map> mainParam;
  String fillMethod;
  String bigCateName;
  String elemNorm;
  int remainNum; //库存量
  String factoryName;
  int docUploadDate; //产品手册上传日期
  String docSize; //产品手册大小

  ProdDetailData(
      {this.prodImg,
      this.doMain,
      this.xFactory,
      this.downHref,
      this.costPrice,
      this.authOrg,
      this.mainFun,
      this.devStand,
      this.qualityGrade,
      this.radix,
      this.prodCode,
      this.smallCateName,
      this.xinHaoGuiGe,
      this.ifFavour,
      this.staticElectric,
      this.prodName,
      this.tempRange,
      this.mainParam,
      this.fillMethod,
      this.remainNum,
      this.bigCateName,
      this.factoryName,
      this.docUploadDate,
      this.docSize,
      this.elemNorm});

  ProdDetailData.fromJson(Map<String, dynamic> json) {
    prodImg = json['prodImg'];
    doMain = json['doMain'];
    xFactory = json['factory'];
    downHref = json['downHref'];
    costPrice = json['costPrice'];
    authOrg = json['authOrg'];
    mainFun = json['mainFun'];
    devStand = json['devStand'];
    qualityGrade = json['qualityGrade'];
    radix = json['radix'];
    prodCode = json['prodCode'];
    smallCateName = json['smallCateName'];
    xinHaoGuiGe = json['xinHaoGuiGe'];
    ifFavour = json['ifFavour'];
    staticElectric = json['staticElectric'];
    prodName = json['prodName'];
    remainNum = json['remainNum'];
    tempRange = json['tempRange'];
    factoryName = json['factoryName'];
    docUploadDate = json['docUploadDate'];
    docSize = json['docSize'];
    if (json['mainParam'] != null) {
      mainParam = new List<Map>();
      (json['mainParam'] as List).forEach((v) {
        mainParam.add(v);
      });
    }
    fillMethod = json['fillMethod'];
    bigCateName = json['bigCateName'];
    elemNorm = json['elemNorm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prodImg'] = this.prodImg;
    data['doMain'] = this.doMain;
    data['factory'] = this.xFactory;
    data['downHref'] = this.downHref;
    data['costPrice'] = this.costPrice;
    data['authOrg'] = this.authOrg;
    data['mainFun'] = this.mainFun;
    data['devStand'] = this.devStand;
    data['qualityGrade'] = this.qualityGrade;
    data['radix'] = this.radix;
    data['prodCode'] = this.prodCode;
    data['smallCateName'] = this.smallCateName;
    data['xinHaoGuiGe'] = this.xinHaoGuiGe;
    data['ifFavour'] = this.ifFavour;
    data['staticElectric'] = this.staticElectric;
    data['prodName'] = this.prodName;
    data['tempRange'] = this.tempRange;
    data['remainNum'] = this.remainNum;
    if (this.mainParam != null) {
      data['mainParam'] = this.mainParam.toList();
    }
    data['fillMethod'] = this.fillMethod;
    data['bigCateName'] = this.bigCateName;
    data['elemNorm'] = this.elemNorm;
    data['factoryName'] = this.factoryName;
    data['docUploadDate'] = this.docUploadDate;
    data['docSize'] = this.docSize;
    return data;
  }
}
