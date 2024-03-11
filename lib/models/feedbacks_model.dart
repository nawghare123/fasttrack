class feedbacks_model {
  bool? success;
  String? message;
  Data? data;

  feedbacks_model({this.success, this.message, this.data});

  feedbacks_model.fromJson(Map<String, dynamic> json) {
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
  bool? isActive;
  bool? isDeleted;
  int? id;
  String? type;
  String? shortDescription;
  String? description;
  String? attachment;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.isActive,
        this.isDeleted,
        this.id,
        this.type,
        this.shortDescription,
        this.description,
        this.attachment,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    id = json['id'];
    type = json['type'];
    shortDescription = json['short_description'];
    description = json['description'];
    attachment = json['attachment'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['id'] = this.id;
    data['type'] = this.type;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['attachment'] = this.attachment;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}