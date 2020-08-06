class LoginRspEntity {
	String msg;
	int code;
	LoginRspData data;

	LoginRspEntity({this.msg, this.code, this.data});

	LoginRspEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		data = json['data'] != null ? new LoginRspData.fromJson(json['data']) : null;
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

class LoginRspData {
	String mobile;
	String token;
	String memberId;

	LoginRspData({this.mobile, this.token, this.memberId});

	LoginRspData.fromJson(Map<String, dynamic> json) {
		mobile = json['mobile'];
		token = json['token'];
		memberId = json['memberId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['mobile'] = this.mobile;
		data['token'] = this.token;
		data['memberId'] = this.memberId;
		return data;
	}
}
