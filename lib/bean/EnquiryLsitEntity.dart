class EnquiryLsitEntity {
	String msg;
	int code;
	EnquiryLsitData data;

	EnquiryLsitEntity({this.msg, this.code, this.data});

	EnquiryLsitEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		data = json['data'] != null ? new EnquiryLsitData.fromJson(json['data']) : null;
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

class EnquiryLsitData {
	List<EnquiryLsitDataProdlist> prodList;
	String sumPay;

	EnquiryLsitData({this.prodList, this.sumPay});

	EnquiryLsitData.fromJson(Map<String, dynamic> json) {
		if (json['prodList'] != null) {
			prodList = new List<EnquiryLsitDataProdlist>();(json['prodList'] as List).forEach((v) { prodList.add(new EnquiryLsitDataProdlist.fromJson(v)); });
		}
		sumPay = json['sumPay'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.prodList != null) {
      data['prodList'] =  this.prodList.map((v) => v.toJson()).toList();
    }
		data['sumPay'] = this.sumPay;
		return data;
	}
}

class EnquiryLsitDataProdlist {
	int totalNum;
	String prodName;
	String xinHao;
	String fillMethod;
	String prodGrade;

	EnquiryLsitDataProdlist({this.totalNum, this.prodName, this.xinHao, this.fillMethod, this.prodGrade});

	EnquiryLsitDataProdlist.fromJson(Map<String, dynamic> json) {
		totalNum = json['totalNum'];
		prodName = json['prodName'];
		xinHao = json['xinHao'];
		fillMethod = json['fillMethod'];
		prodGrade = json['prodGrade'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['totalNum'] = this.totalNum;
		data['prodName'] = this.prodName;
		data['xinHao'] = this.xinHao;
		data['fillMethod'] = this.fillMethod;
		data['prodGrade'] = this.prodGrade;
		return data;
	}
}
