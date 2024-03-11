class AddMedicalReportModel {
  bool? success;
  String? message;
  Data? data;

  AddMedicalReportModel({this.success, this.message, this.data});

  AddMedicalReportModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? reportDate;
  String? doctorName;
  String? specialization;
  String? reportName;
  String? details;
  String? attachment;
  int? userId;
  String? updatedAt;
  String? createdAt;

  Data(
      {
        this.id,
        this.reportDate,
        this.doctorName,
        this.specialization,
        this.reportName,
        this.details,
        this.attachment,
        this.userId,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reportDate = json['report_date'];
    doctorName = json['doctor_name'];
    specialization = json['specialization'];
    reportName = json['report_name'];
    details = json['details'];
    attachment = json['attachment'];
    userId = json['user_id'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['report_date'] = this.reportDate;
    data['doctor_name'] = this.doctorName;
    data['specialization'] = this.specialization;
    data['report_name'] = this.reportName;
    data['details'] = this.details;
    data['attachment'] = this.attachment;
    data['user_id'] = this.userId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}