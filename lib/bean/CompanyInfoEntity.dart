class CompanyInfoEntity {
	String msg;
	int code;
	CompanyInfoData data;

	CompanyInfoEntity({this.msg, this.code, this.data});

	CompanyInfoEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		data = json['data'] != null ? new CompanyInfoData.fromJson(json['data']) : null;
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

class CompanyInfoData {
	List<CompanyInfoDataProd> prods;
	String logo;
	String addr;
	String compName;
	String remarks;

	CompanyInfoData({this.prods, this.logo, this.addr, this.compName, this.remarks});

	CompanyInfoData.fromJson(Map<String, dynamic> json) {
		if (json['prods'] != null) {
			prods = new List<CompanyInfoDataProd>();(json['prods'] as List).forEach((v) { prods.add(new CompanyInfoDataProd.fromJson(v)); });
		}
		logo = json['logo'];
		addr = json['addr'];
		compName = json['compName'];
		remarks = json['remarks'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.prods != null) {
      data['prods'] =  this.prods.map((v) => v.toJson()).toList();
    }
		data['logo'] = this.logo;
		data['addr'] = this.addr;
		data['compName'] = this.compName;
		data['remarks'] = this.remarks;
		return data;
	}
}

class CompanyInfoDataProd {
	String prodImg;
	String prodName;
	String prodId;

	CompanyInfoDataProd({this.prodImg, this.prodName, this.prodId});

	CompanyInfoDataProd.fromJson(Map<String, dynamic> json) {
		prodImg = json['prodImg'];
		prodName = json['prodName'];
		prodId = json['prodId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['prodImg'] = this.prodImg;
		data['prodName'] = this.prodName;
		data['prodId'] = this.prodId;
		return data;
	}
}
