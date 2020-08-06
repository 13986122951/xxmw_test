class ProdsCateEntity {
	String msg;
	int code;
	ProdsCateData data;

	ProdsCateEntity({this.msg, this.code, this.data});

	ProdsCateEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		data = json['data'] != null ? new ProdsCateData.fromJson(json['data']) : null;
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

class ProdsCateData {
	List<ProdsCateDataProdmap> prodMap;
	String cateName;

	ProdsCateData({this.prodMap, this.cateName});

	ProdsCateData.fromJson(Map<String, dynamic> json) {
		if (json['prodMap'] != null) {
			prodMap = new List<ProdsCateDataProdmap>();(json['prodMap'] as List).forEach((v) { prodMap.add(new ProdsCateDataProdmap.fromJson(v)); });
		}
		cateName = json['cateName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.prodMap != null) {
      data['prodMap'] =  this.prodMap.map((v) => v.toJson()).toList();
    }
		data['cateName'] = this.cateName;
		return data;
	}
}

class ProdsCateDataProdmap {
	String prodImg;
	int ifFavour;
	String grade;
	String downHref;
	String prodName;
	String xinHao;
	String prodId;
	int haveDoc;
	String createComp;

	ProdsCateDataProdmap({this.prodImg, this.ifFavour, this.grade, this.downHref, this.prodName, this.xinHao, this.prodId, this.haveDoc, this.createComp});

	ProdsCateDataProdmap.fromJson(Map<String, dynamic> json) {
		prodImg = json['prodImg'];
		ifFavour = json['ifFavour'];
		grade = json['grade'];
		downHref = json['downHref'];
		prodName = json['prodName'];
		xinHao = json['xinHao'];
		prodId = json['prodId'];
		haveDoc = json['haveDoc'];
		createComp = json['createComp'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['prodImg'] = this.prodImg;
		data['ifFavour'] = this.ifFavour;
		data['grade'] = this.grade;
		data['downHref'] = this.downHref;
		data['prodName'] = this.prodName;
		data['xinHao'] = this.xinHao;
		data['prodId'] = this.prodId;
		data['haveDoc'] = this.haveDoc;
		data['createComp'] = this.createComp;
		return data;
	}
}
