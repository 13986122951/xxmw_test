class UserSayItemEntity {
	String msg;
	int code;
	List<UserSayItemData> data;

	UserSayItemEntity({this.msg, this.code, this.data});

	UserSayItemEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<UserSayItemData>();(json['data'] as List).forEach((v) { data.add(new UserSayItemData.fromJson(v)); });
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

class UserSayItemData {
	int createTime;
	String nickName;
	int ifPraise;
	int startNum;
	int praiseNum;
	String text;
	String customId;

	UserSayItemData({this.createTime, this.nickName, this.ifPraise, this.startNum, this.praiseNum, this.text, this.customId});

	UserSayItemData.fromJson(Map<String, dynamic> json) {
		createTime = json['createTime'];
		nickName = json['nickName'];
		ifPraise = json['ifPraise'];
		startNum = json['startNum'];
		praiseNum = json['praiseNum'];
		text = json['text'];
		customId = json['customId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['createTime'] = this.createTime;
		data['nickName'] = this.nickName;
		data['ifPraise'] = this.ifPraise;
		data['startNum'] = this.startNum;
		data['praiseNum'] = this.praiseNum;
		data['text'] = this.text;
		data['customId'] = this.customId;
		return data;
	}
}
