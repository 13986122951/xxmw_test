class HomePageEntity {
  String msg;
  int code;
  HomePageData data;

  HomePageEntity({this.msg, this.code, this.data});

  HomePageEntity.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data =
        json['data'] != null ? new HomePageData.fromJson(json['data']) : null;
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

class HomePageData {
  List<HomePageDataFlownotice> flowNotice;
  List<HomePageDataAllpartner> allPartner;
  List<HomePageDataProductcate> productCate;
  List<HomePageDataFowbanner> fowBanner;
  List<HomePageDataNewprod> newProd;
  List<HomePageDataNewprod> hotProd;

  HomePageData(
      {this.flowNotice,
      this.allPartner,
      this.productCate,
      this.fowBanner,
      this.newProd,
      this.hotProd});

  HomePageData.fromJson(Map<String, dynamic> json) {
    if (json['flowNotice'] != null) {
      flowNotice = new List<HomePageDataFlownotice>();
      (json['flowNotice'] as List).forEach((v) {
        flowNotice.add(new HomePageDataFlownotice.fromJson(v));
      });
    }
    if (json['allPartner'] != null) {
      allPartner = new List<HomePageDataAllpartner>();
      (json['allPartner'] as List).forEach((v) {
        allPartner.add(new HomePageDataAllpartner.fromJson(v));
      });
    }
    if (json['productCate'] != null) {
      productCate = new List<HomePageDataProductcate>();
      (json['productCate'] as List).forEach((v) {
        productCate.add(new HomePageDataProductcate.fromJson(v));
      });
    }
    if (json['fowBanner'] != null) {
      fowBanner = new List<HomePageDataFowbanner>();
      (json['fowBanner'] as List).forEach((v) {
        fowBanner.add(new HomePageDataFowbanner.fromJson(v));
      });
    }
    if (json['newProd'] != null) {
      newProd = new List<HomePageDataNewprod>();
      (json['newProd'] as List).forEach((v) {
        newProd.add(new HomePageDataNewprod.fromJson(v));
      });
    }
    if (json['hotProd'] != null) {
      hotProd = new List<HomePageDataNewprod>();
      (json['hotProd'] as List).forEach((v) {
        hotProd.add(new HomePageDataNewprod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.flowNotice != null) {
      data['flowNotice'] = this.flowNotice.map((v) => v.toJson()).toList();
    }
    if (this.allPartner != null) {
      data['allPartner'] = this.allPartner.map((v) => v.toJson()).toList();
    }
    if (this.productCate != null) {
      data['productCate'] = this.productCate.map((v) => v.toJson()).toList();
    }
    if (this.fowBanner != null) {
      data['fowBanner'] = this.fowBanner.map((v) => v.toJson()).toList();
    }
    if (this.newProd != null) {
      data['newProd'] = this.newProd.map((v) => v.toJson()).toList();
    }
    if (this.hotProd != null) {
      data['hotProd'] = this.hotProd.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomePageDataFlownotice {
  dynamic txt;
  String pkId;
  dynamic danWei;
  dynamic imgPath;
  dynamic xinHao;
  dynamic sort;
  String title;
  dynamic dengJi;
  String content;

  HomePageDataFlownotice(
      {this.txt,
      this.pkId,
      this.danWei,
      this.imgPath,
      this.xinHao,
      this.sort,
      this.title,
      this.dengJi,
      this.content});

  HomePageDataFlownotice.fromJson(Map<String, dynamic> json) {
    txt = json['txt'];
    pkId = json['pkId'];
    danWei = json['danWei'];
    imgPath = json['imgPath'];
    xinHao = json['xinHao'];
    sort = json['sort'];
    title = json['title'];
    dengJi = json['dengJi'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txt'] = this.txt;
    data['pkId'] = this.pkId;
    data['danWei'] = this.danWei;
    data['imgPath'] = this.imgPath;
    data['xinHao'] = this.xinHao;
    data['sort'] = this.sort;
    data['title'] = this.title;
    data['dengJi'] = this.dengJi;
    data['content'] = this.content;
    return data;
  }
}

class HomePageDataAllpartner {
  dynamic txt;
  String pkId;
  dynamic danWei;
  String imgPath;
  dynamic xinHao;
  dynamic sort;
  String title;
  dynamic dengJi;
  dynamic content;

  HomePageDataAllpartner(
      {this.txt,
      this.pkId,
      this.danWei,
      this.imgPath,
      this.xinHao,
      this.sort,
      this.title,
      this.dengJi,
      this.content});

  HomePageDataAllpartner.fromJson(Map<String, dynamic> json) {
    txt = json['txt'];
    pkId = json['pkId'];
    danWei = json['danWei'];
    imgPath = json['imgPath'];
    xinHao = json['xinHao'];
    sort = json['sort'];
    title = json['title'];
    dengJi = json['dengJi'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txt'] = this.txt;
    data['pkId'] = this.pkId;
    data['danWei'] = this.danWei;
    data['imgPath'] = this.imgPath;
    data['xinHao'] = this.xinHao;
    data['sort'] = this.sort;
    data['title'] = this.title;
    data['dengJi'] = this.dengJi;
    data['content'] = this.content;
    return data;
  }
}

class HomePageDataProductcate {
  dynamic txt;
  String pkId;
  dynamic danWei;
  String imgPath;
  dynamic xinHao;
  dynamic sort;
  String title;
  dynamic dengJi;
  dynamic content;

  HomePageDataProductcate(
      {this.txt,
      this.pkId,
      this.danWei,
      this.imgPath,
      this.xinHao,
      this.sort,
      this.title,
      this.dengJi,
      this.content});

  HomePageDataProductcate.fromJson(Map<String, dynamic> json) {
    txt = json['txt'];
    pkId = json['pkId'];
    danWei = json['danWei'];
    imgPath = json['imgPath'];
    xinHao = json['xinHao'];
    sort = json['sort'];
    title = json['title'];
    dengJi = json['dengJi'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txt'] = this.txt;
    data['pkId'] = this.pkId;
    data['danWei'] = this.danWei;
    data['imgPath'] = this.imgPath;
    data['xinHao'] = this.xinHao;
    data['sort'] = this.sort;
    data['title'] = this.title;
    data['dengJi'] = this.dengJi;
    data['content'] = this.content;
    return data;
  }
}

class HomePageDataFowbanner {
  dynamic txt;
  String pkId;
  dynamic danWei;
  String imgPath;
  dynamic xinHao;
  int sort;
  String title;
  dynamic dengJi;
  dynamic content;

  HomePageDataFowbanner(
      {this.txt,
      this.pkId,
      this.danWei,
      this.imgPath,
      this.xinHao,
      this.sort,
      this.title,
      this.dengJi,
      this.content});

  HomePageDataFowbanner.fromJson(Map<String, dynamic> json) {
    txt = json['txt'];
    pkId = json['pkId'];
    danWei = json['danWei'];
    imgPath = json['imgPath'];
    xinHao = json['xinHao'];
    sort = json['sort'];
    title = json['title'];
    dengJi = json['dengJi'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txt'] = this.txt;
    data['pkId'] = this.pkId;
    data['danWei'] = this.danWei;
    data['imgPath'] = this.imgPath;
    data['xinHao'] = this.xinHao;
    data['sort'] = this.sort;
    data['title'] = this.title;
    data['dengJi'] = this.dengJi;
    data['content'] = this.content;
    return data;
  }
}

class HomePageDataNewprod {
  dynamic txt;
  String pkId;
  String danWei;
  String imgPath;
  String xinHao;
  dynamic sort;
  String title;
  dynamic dengJi;
  dynamic content;

  HomePageDataNewprod(
      {this.txt,
      this.pkId,
      this.danWei,
      this.imgPath,
      this.xinHao,
      this.sort,
      this.title,
      this.dengJi,
      this.content});

  HomePageDataNewprod.fromJson(Map<String, dynamic> json) {
    txt = json['txt'];
    pkId = json['pkId'];
    danWei = json['danWei'];
    imgPath = json['imgPath'];
    xinHao = json['xinHao'];
    sort = json['sort'];
    title = json['title'];
    dengJi = json['dengJi'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txt'] = this.txt;
    data['pkId'] = this.pkId;
    data['danWei'] = this.danWei;
    data['imgPath'] = this.imgPath;
    data['xinHao'] = this.xinHao;
    data['sort'] = this.sort;
    data['title'] = this.title;
    data['dengJi'] = this.dengJi;
    data['content'] = this.content;
    return data;
  }
}
