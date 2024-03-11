class Upload_medicalreport {
  bool? success;
  String? message;
  Data? data;

  Upload_medicalreport({this.success, this.message, this.data});

  Upload_medicalreport.fromJson(Map<String, dynamic> json) {
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
  String? filePath;
  String? fileType;
  int? fileSize;

  Data({this.filePath, this.fileType, this.fileSize});

  Data.fromJson(Map<String, dynamic> json) {
    filePath = json['filePath'];
    fileType = json['fileType'];
    fileSize = json['fileSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filePath'] = this.filePath;
    data['fileType'] = this.fileType;
    data['fileSize'] = this.fileSize;
    return data;
  }
}