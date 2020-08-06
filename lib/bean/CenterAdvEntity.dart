class CenterAdvEntity {
	String msg;
	int code;
	CenterAdvData data;

	CenterAdvEntity({this.msg, this.code, this.data});

	CenterAdvEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		data = json['data'] != null ? new CenterAdvData.fromJson(json['data']) : null;
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

class CenterAdvData {
	String funcName;
	String pkId;
	String imgPath;

	CenterAdvData({this.funcName, this.pkId, this.imgPath});

	CenterAdvData.fromJson(Map<String, dynamic> json) {
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
