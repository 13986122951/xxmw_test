class BomInfoEntity {
	String msg;
	int code;
	BomInfoData data;

	BomInfoEntity({this.msg, this.code, this.data});

	BomInfoEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		data = json['data'] != null ? new BomInfoData.fromJson(json['data']) : null;
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

class BomInfoData {
	String singleMach;
	String singleStep;
	String bomId;
	String devUnit;
	String sysName;
	String bomName;
	String partName;
	String remarks;

	BomInfoData({this.singleMach, this.singleStep, this.bomId, this.devUnit, this.sysName, this.bomName, this.partName, this.remarks});

	BomInfoData.fromJson(Map<String, dynamic> json) {
		singleMach = json['singleMach'];
		singleStep = json['singleStep'];
		bomId = json['bomId'];
		devUnit = json['devUnit'];
		sysName = json['sysName'];
		bomName = json['bomName'];
		partName = json['partName'];
		remarks = json['remarks'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['singleMach'] = this.singleMach;
		data['singleStep'] = this.singleStep;
		data['bomId'] = this.bomId;
		data['devUnit'] = this.devUnit;
		data['sysName'] = this.sysName;
		data['bomName'] = this.bomName;
		data['partName'] = this.partName;
		data['remarks'] = this.remarks;
		return data;
	}
}
