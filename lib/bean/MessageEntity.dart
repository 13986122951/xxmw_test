class MessageEntity {
	String msg;
	int code;
	List<MessageData> data;

	MessageEntity({this.msg, this.code, this.data});

	MessageEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<MessageData>();(json['data'] as List).forEach((v) { data.add(new MessageData.fromJson(v)); });
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

class MessageData {
	String pkId;
	int readState;
	int createTime;
	String title;
	String noticeId;
	String content;

	MessageData({this.pkId, this.readState, this.createTime, this.title, this.noticeId, this.content});

	MessageData.fromJson(Map<String, dynamic> json) {
		pkId = json['pkId'];
		readState = json['readState'];
		createTime = json['createTime'];
		title = json['title'];
		noticeId = json['noticeId'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['pkId'] = this.pkId;
		data['readState'] = this.readState;
		data['createTime'] = this.createTime;
		data['title'] = this.title;
		data['noticeId'] = this.noticeId;
		data['content'] = this.content;
		return data;
	}
}
