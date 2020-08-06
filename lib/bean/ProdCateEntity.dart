class ProdCateEntity {
	String msg;
	int code;
	List<ProdCateData> data;

	ProdCateEntity({this.msg, this.code, this.data});

	ProdCateEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<ProdCateData>();(json['data'] as List).forEach((v) { data.add(new ProdCateData.fromJson(v)); });
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

class ProdCateData {
	List<ProdCateDatachild> children;
	String cateId;
	String imgPath;
	String cateName;
	String parentId;

	ProdCateData({this.children, this.cateId, this.imgPath, this.cateName, this.parentId});

	ProdCateData.fromJson(Map<String, dynamic> json) {
		if (json['children'] != null) {
			children = new List<ProdCateDatachild>();(json['children'] as List).forEach((v) { children.add(new ProdCateDatachild.fromJson(v)); });
		}
		cateId = json['cateId'];
		imgPath = json['imgPath'];
		cateName = json['cateName'];
		parentId = json['parentId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.children != null) {
      data['children'] =  this.children.map((v) => v.toJson()).toList();
    }
		data['cateId'] = this.cateId;
		data['imgPath'] = this.imgPath;
		data['cateName'] = this.cateName;
		data['parentId'] = this.parentId;
		return data;
	}
}

class ProdCateDatachild {
	List<ProdCateDatachildchild> children;
	String cateId;
	String imgPath;
	String cateName;
	String parentId;

	ProdCateDatachild({this.children, this.cateId, this.imgPath, this.cateName, this.parentId});

	ProdCateDatachild.fromJson(Map<String, dynamic> json) {
		if (json['children'] != null) {
			children = new List<ProdCateDatachildchild>();(json['children'] as List).forEach((v) { children.add(new ProdCateDatachildchild.fromJson(v)); });
		}
		cateId = json['cateId'];
		imgPath = json['imgPath'];
		cateName = json['cateName'];
		parentId = json['parentId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.children != null) {
      data['children'] =  this.children.map((v) => v.toJson()).toList();
    }
		data['cateId'] = this.cateId;
		data['imgPath'] = this.imgPath;
		data['cateName'] = this.cateName;
		data['parentId'] = this.parentId;
		return data;
	}
}

class ProdCateDatachildchild {
	List<Null> children;
	String cateId;
	String imgPath;
	String cateName;
	String parentId;

	ProdCateDatachildchild({this.children, this.cateId, this.imgPath, this.cateName, this.parentId});

	ProdCateDatachildchild.fromJson(Map<String, dynamic> json) {
		if (json['children'] != null) {
			children = new List<Null>();
		}
		cateId = json['cateId'];
		imgPath = json['imgPath'];
		cateName = json['cateName'];
		parentId = json['parentId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.children != null) {
      data['children'] =  [];
    }
		data['cateId'] = this.cateId;
		data['imgPath'] = this.imgPath;
		data['cateName'] = this.cateName;
		data['parentId'] = this.parentId;
		return data;
	}
}
