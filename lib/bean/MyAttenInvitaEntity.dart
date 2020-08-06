class MyAttenInvitaEntity {
	String msg;
	int code;
	List<MyAttenInvitaData> data;

	MyAttenInvitaEntity({this.msg, this.code, this.data});

	MyAttenInvitaEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<MyAttenInvitaData>();(json['data'] as List).forEach((v) { data.add(new MyAttenInvitaData.fromJson(v)); });
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

class MyAttenInvitaData {
	String footViewId;
	String headDesc;
	int praiseNum;
	String title;
	int commentsNum;

	MyAttenInvitaData({this.footViewId, this.headDesc, this.praiseNum, this.title, this.commentsNum});

	MyAttenInvitaData.fromJson(Map<String, dynamic> json) {
		footViewId = json['footViewId'];
		headDesc = json['headDesc'];
		praiseNum = json['praiseNum'];
		title = json['title'];
		commentsNum = json['commentsNum'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['footViewId'] = this.footViewId;
		data['headDesc'] = this.headDesc;
		data['praiseNum'] = this.praiseNum;
		data['title'] = this.title;
		data['commentsNum'] = this.commentsNum;
		return data;
	}
}
