class SerahPostEntity {
	String msg;
	int code;
	List<SerahPostData> data;

	SerahPostEntity({this.msg, this.code, this.data});

	SerahPostEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<SerahPostData>();(json['data'] as List).forEach((v) { data.add(new SerahPostData.fromJson(v)); });
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

class SerahPostData {
	int commentNum;
	int createTime;
	int ifHot;
	int praiseNum;
	String postTitle;
	String postId;
	int ifUnique;
	String authorPhoto;
	String content;
	int curUserPraise;

	SerahPostData({this.commentNum, this.createTime, this.ifHot, this.praiseNum, this.postTitle, this.postId, this.ifUnique, this.authorPhoto, this.content, this.curUserPraise});

	SerahPostData.fromJson(Map<String, dynamic> json) {
		commentNum = json['commentNum'];
		createTime = json['createTime'];
		ifHot = json['ifHot'];
		praiseNum = json['praiseNum'];
		postTitle = json['postTitle'];
		postId = json['postId'];
		ifUnique = json['ifUnique'];
		authorPhoto = json['authorPhoto'];
		content = json['content'];
		curUserPraise = json['curUserPraise'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['commentNum'] = this.commentNum;
		data['createTime'] = this.createTime;
		data['ifHot'] = this.ifHot;
		data['praiseNum'] = this.praiseNum;
		data['postTitle'] = this.postTitle;
		data['postId'] = this.postId;
		data['ifUnique'] = this.ifUnique;
		data['authorPhoto'] = this.authorPhoto;
		data['content'] = this.content;
		data['curUserPraise'] = this.curUserPraise;
		return data;
	}
}
