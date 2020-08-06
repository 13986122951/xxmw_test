class AttTopicListEntity {
	String msg;
	int code;
	List<AttTopicListData> data;

	AttTopicListEntity({this.msg, this.code, this.data});

	AttTopicListEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<AttTopicListData>();(json['data'] as List).forEach((v) { data.add(new AttTopicListData.fromJson(v)); });
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

class AttTopicListData {
	String footViewId;
	String headDesc;
	String title;

	AttTopicListData({this.footViewId, this.headDesc, this.title});

	AttTopicListData.fromJson(Map<String, dynamic> json) {
		footViewId = json['footViewId'];
		headDesc = json['headDesc'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['footViewId'] = this.footViewId;
		data['headDesc'] = this.headDesc;
		data['title'] = this.title;
		return data;
	}
}
