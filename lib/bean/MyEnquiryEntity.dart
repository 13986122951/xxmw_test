class MyEnquiryEntity {
	String msg;
	int code;
	List<MyEnquiryData> data;

	MyEnquiryEntity({this.msg, this.code, this.data});

	MyEnquiryEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<MyEnquiryData>();(json['data'] as List).forEach((v) { data.add(new MyEnquiryData.fromJson(v)); });
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

class MyEnquiryData {
	String pkId;
	int total;
	String img;
	int createTime;
	String bomName;
	String bomRemarks;

	MyEnquiryData({this.pkId, this.total, this.img, this.createTime, this.bomName, this.bomRemarks});

	MyEnquiryData.fromJson(Map<String, dynamic> json) {
		pkId = json['pkId'];
		total = json['total'];
		img = json['img'];
		createTime = json['createTime'];
		bomName = json['bomName'];
		bomRemarks = json['bomRemarks'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['pkId'] = this.pkId;
		data['total'] = this.total;
		data['img'] = this.img;
		data['createTime'] = this.createTime;
		data['bomName'] = this.bomName;
		data['bomRemarks'] = this.bomRemarks;
		return data;
	}
}
