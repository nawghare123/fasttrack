class medical_reportmodel {

  bool? success;
  String? message;
  List<Data>? data;

  medical_reportmodel({this.success, this.message, this.data});

  medical_reportmodel.fromJson(Map<String, dynamic> json) {
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
  String? reportDate;
  String? doctorName;
  String? specialization;
  String? reportName;
  String? summary;
  String? attachment;
  int? isActive;

  Data(
      {this.id,
        this.reportDate,
        this.doctorName,
        this.specialization,
        this.reportName,
        this.summary,
        this.attachment,
        this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reportDate = json['report_date'];
    doctorName = json['doctor_name'];
    specialization = json['specialization'];
    reportName = json['report_name'];
    summary = json['summary'];
    attachment = json['attachment'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['report_date'] = this.reportDate;
    data['doctor_name'] = this.doctorName;
    data['specialization'] = this.specialization;
    data['report_name'] = this.reportName;
    data['summary'] = this.summary;
    data['attachment'] = this.attachment;
    data['is_active'] = this.isActive;
    return data;
  }
}