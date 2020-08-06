import 'CommentListEntity.dart';

class CommentItemInfoEntity {
	String msg;
	int code;
	CommentListEntityData data;

	CommentItemInfoEntity({this.msg, this.code, this.data});

	CommentItemInfoEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = json['data'] != null ? new CommentListEntityData.fromJson(json['data']) : null;
		}
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
