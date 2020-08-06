class CommentItemEntity {
	String msg;
	int code;
	List<CommentItemData> data;

	CommentItemEntity({this.msg, this.code, this.data});

	CommentItemEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<CommentItemData>();(json['data'] as List).forEach((v) { data.add(new CommentItemData.fromJson(v)); });
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

class CommentItemData {
	String replyText;
	int publishTimes;
	String secondNickName;

	CommentItemData({this.replyText, this.publishTimes, this.secondNickName});

	CommentItemData.fromJson(Map<String, dynamic> json) {
		replyText = json['replyText'];
		publishTimes = json['publishTimes'];
		secondNickName = json['secondNickName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['replyText'] = this.replyText;
		data['publishTimes'] = this.publishTimes;
		data['secondNickName'] = this.secondNickName;
		return data;
	}
}
