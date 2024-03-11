class payment_create_model {
  bool? success;
  String? message;
  Data? data;

  payment_create_model({this.success, this.message, this.data});

  payment_create_model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? transactionToken;
  String? orderId;
  String? message;
  bool? success;

  Data({this.transactionToken, this.orderId, this.message, this.success});

  Data.fromJson(Map<String, dynamic> json) {
    transactionToken = json['transaction_token'];
    orderId = json['order_id'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_token'] = this.transactionToken;
    data['order_id'] = this.orderId;
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}