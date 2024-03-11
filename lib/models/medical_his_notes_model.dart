class medical_his_notes_deletemodel {
  bool? success;
  String? message;

  medical_his_notes_deletemodel({this.success, this.message});

  medical_his_notes_deletemodel.fromJson(Map<String, dynamic> json) {
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