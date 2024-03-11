class Notification_all_read_model {
  bool? success;
  String? message;

  Notification_all_read_model({this.success, this.message});

  Notification_all_read_model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}