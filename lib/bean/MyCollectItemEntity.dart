class MyCollectItemEntity {
	String msg;
	int code;
	List<MyCollectItemData> data;

	MyCollectItemEntity({this.msg, this.code, this.data});

	MyCollectItemEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['data'] != null) {
			data = new List<MyCollectItemData>();(json['data'] as List).forEach((v) { data.add(new MyCollectItemData.fromJson(v)); });
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

class MyCollectItemData {
	String pkId;
	String fontType;
	String danWei;
	String imgPath;
	String xinHao;
	String prodId;
	String title;
	String dengJi;

	MyCollectItemData({this.pkId, this.fontType, this.danWei, this.imgPath, this.xinHao, this.prodId, this.title, this.dengJi});

	MyCollectItemData.fromJson(Map<String, dynamic> json) {
		pkId = json['pkId'];
		fontType = json['fontType'];
		danWei = json['danWei'];
		imgPath = json['imgPath'];
		xinHao = json['xinHao'];
		prodId = json['prodId'];
		title = json['title'];
		dengJi = json['dengJi'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['pkId'] = this.pkId;
		data['fontType'] = this.fontType;
		data['danWei'] = this.danWei;
		data['imgPath'] = this.imgPath;
		data['xinHao'] = this.xinHao;
		data['prodId'] = this.prodId;
		data['title'] = this.title;
		data['dengJi'] = this.dengJi;
		return data;
	}
}
