class SearchProdEntity {
	String msg;
	int code;
	List<SearchProdData> data;

	SearchProdEntity({this.msg, this.code, this.data});

	SearchProdEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<SearchProdData>();(json['data'] as List).forEach((v) { data.add(new SearchProdData.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SearchProdData {
	String imgPath;
	String prodName;
	String xinHao;
	String prodId;
	String prodGrade;
	String createComp;

	SearchProdData({this.imgPath, this.prodName, this.xinHao, this.prodId, this.prodGrade, this.createComp});

	SearchProdData.fromJson(Map<String, dynamic> json) {
		imgPath = json['imgPath'];
		prodName = json['prodName'];
		xinHao = json['xinHao'];
		prodId = json['prodId'];
		prodGrade = json['prodGrade'];
		createComp = json['createComp'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['imgPath'] = this.imgPath;
		data['prodName'] = this.prodName;
		data['xinHao'] = this.xinHao;
		data['prodId'] = this.prodId;
		data['prodGrade'] = this.prodGrade;
		data['createComp'] = this.createComp;
		return data;
	}
}
