class CapturePaymentModel {
  late bool success;
  late String message;
  late Data data;

  CapturePaymentModel({required this.success,required  this.message,required  this.data});

  CapturePaymentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if(json['data'] != null) {
      data =  new Data.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  late bool verificationStatus;

  Data({required this.verificationStatus});

  Data.fromJson(Map<String, dynamic> json) {
    verificationStatus = json['verification_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verification_status'] = this.verificationStatus;
    return data;
  }
}