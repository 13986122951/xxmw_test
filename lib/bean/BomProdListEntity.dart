class BomProdListEntity {
	String msg;
	int code;
	BomProdListData data;

	BomProdListEntity({this.msg, this.code, this.data});

	BomProdListEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		data = json['data'] != null ? new BomProdListData.fromJson(json['data']) : null;
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

class BomProdListData {
	String bomName;
	List<BomProdListDataProdlist> prodList;

	BomProdListData({this.bomName, this.prodList});

	BomProdListData.fromJson(Map<String, dynamic> json) {
		bomName = json['bomName'];
		if (json['prodList'] != null) {
			prodList = new List<BomProdListDataProdlist>();(json['prodList'] as List).forEach((v) { prodList.add(new BomProdListDataProdlist.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['bomName'] = this.bomName;
		if (this.prodList != null) {
      data['prodList'] =  this.prodList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class BomProdListDataProdlist {
	int ifFavour;
	String imgPath;
	String grade;
	String prodName;
	String xinHao;
	String prodId;
	String createCom;
	int ifHaveDoc;

	BomProdListDataProdlist({this.ifFavour, this.imgPath, this.grade, this.prodName, this.xinHao, this.prodId, this.createCom, this.ifHaveDoc});

	BomProdListDataProdlist.fromJson(Map<String, dynamic> json) {
		ifFavour = json['ifFavour'];
		imgPath = json['imgPath'];
		grade = json['grade'];
		prodName = json['prodName'];
		xinHao = json['xinHao'];
		prodId = json['prodId'];
		createCom = json['createCom'];
		ifHaveDoc = json['ifHaveDoc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ifFavour'] = this.ifFavour;
		data['imgPath'] = this.imgPath;
		data['grade'] = this.grade;
		data['prodName'] = this.prodName;
		data['xinHao'] = this.xinHao;
		data['prodId'] = this.prodId;
		data['createCom'] = this.createCom;
		data['ifHaveDoc'] = this.ifHaveDoc;
		return data;
	}
}
