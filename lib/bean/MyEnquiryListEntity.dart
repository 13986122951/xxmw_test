class MyEnquiryListEntity {
	String msg;
	int code;
	MyEnquiryListData data;

	MyEnquiryListEntity({this.msg, this.code, this.data});

	MyEnquiryListEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		data = json['data'] != null ? new MyEnquiryListData.fromJson(json['data']) : null;
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

class MyEnquiryListData {
	String sumPrice;
	String bomName;
	List<MyEnquiryListDataProdlist> prodList;

	MyEnquiryListData({this.sumPrice, this.bomName, this.prodList});

	MyEnquiryListData.fromJson(Map<String, dynamic> json) {
		sumPrice = json['sumPrice'];
		bomName = json['bomName'];
		if (json['prodList'] != null) {
			prodList = new List<MyEnquiryListDataProdlist>();(json['prodList'] as List).forEach((v) { prodList.add(new MyEnquiryListDataProdlist.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['sumPrice'] = this.sumPrice;
		data['bomName'] = this.bomName;
		if (this.prodList != null) {
      data['prodList'] =  this.prodList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class MyEnquiryListDataProdlist {
	int prodNum;
	String fontType;
	String perGrade;
	String prodName;
	String xinHao;
	String fillMethod;

	MyEnquiryListDataProdlist({this.prodNum, this.fontType, this.perGrade, this.prodName, this.xinHao, this.fillMethod});

	MyEnquiryListDataProdlist.fromJson(Map<String, dynamic> json) {
		prodNum = json['prodNum'];
		fontType = json['fontType'];
		perGrade = json['perGrade'];
		prodName = json['prodName'];
		xinHao = json['xinHao'];
		fillMethod = json['fillMethod'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['prodNum'] = this.prodNum;
		data['fontType'] = this.fontType;
		data['perGrade'] = this.perGrade;
		data['prodName'] = this.prodName;
		data['xinHao'] = this.xinHao;
		data['fillMethod'] = this.fillMethod;
		return data;
	}
}
