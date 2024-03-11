class medical_hismodel {
  bool? success;
  String? message;
  List<Data>? data;

  medical_hismodel({this.success, this.message, this.data});

  medical_hismodel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? historyName;
  int? status;

  Data({this.id, this.historyName, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    historyName = json['history_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['history_name'] = this.historyName;
    data['status'] = this.status;
    return data;
  }
}