class CommentListEntity {
	String msg;
	int code;
	List<CommentListEntityData> data;

	CommentListEntity({this.msg, this.code, this.data});

	CommentListEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<CommentListEntityData>();(json['data'] as List).forEach((v) { data.add(new CommentListEntityData.fromJson(v)); });
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

class CommentListEntityData {
	int commentNum;
	int ifPraise;
	String replyThirdNickName;
	String replyText;
	String firstNickName;
	String replyFirstNickName;
	String photo;
	String commentId;
	int praiseNum;
	int publishTimes;
	List<CommantListEntityDataChild> child;

	CommentListEntityData({this.commentNum, this.ifPraise, this.replyThirdNickName, this.replyText, this.firstNickName, this.replyFirstNickName, this.photo, this.commentId, this.praiseNum, this.publishTimes, this.child});

	CommentListEntityData.fromJson(Map<String, dynamic> json) {
		commentNum = json['commentNum'];
		ifPraise = json['ifPraise'];
		replyThirdNickName = json['replyThirdNickName'];
		replyText = json['replyText'];
		firstNickName = json['firstNickName'];
		replyFirstNickName = json['replyFirstNickName'];
		photo = json['photo'];
		commentId = json['commentId'];
		praiseNum = json['praiseNum'];
		publishTimes = json['publishTimes'];
		if (json['child'] != null) {
			child = new List<CommantListEntityDataChild>();(json['child'] as List).forEach((v) { child.add(new CommantListEntityDataChild.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['commentNum'] = this.commentNum;
		data['ifPraise'] = this.ifPraise;
		data['replyThirdNickName'] = this.replyThirdNickName;
		data['replyText'] = this.replyText;
		data['firstNickName'] = this.firstNickName;
		data['replyFirstNickName'] = this.replyFirstNickName;
		data['photo'] = this.photo;
		data['commentId'] = this.commentId;
		data['praiseNum'] = this.praiseNum;
		data['publishTimes'] = this.publishTimes;
		if (this.child != null) {
      data['child'] =  this.child.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class CommantListEntityDataChild {
	dynamic replyText;
	String commentId;
	dynamic thirdNickName;
	String secondNickName;

	CommantListEntityDataChild({this.replyText, this.commentId, this.thirdNickName, this.secondNickName});

	CommantListEntityDataChild.fromJson(Map<String, dynamic> json) {
		replyText = json['replyText'];
		commentId = json['commentId'];
		thirdNickName = json['thirdNickName'];
		secondNickName = json['secondNickName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['replyText'] = this.replyText;
		data['commentId'] = this.commentId;
		data['thirdNickName'] = this.thirdNickName;
		data['secondNickName'] = this.secondNickName;
		return data;
	}
}
