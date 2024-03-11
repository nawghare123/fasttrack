class notificationreadmodel {
  bool? success;
  String? message;
  Data? data;

  notificationreadmodel({this.success, this.message, this.data});

  notificationreadmodel
      .fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? description;
  Null? data;
  Null? link;
  bool? isRead;
  bool? isActive;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? userId;

  Data(
      {this.id,
        this.title,
        this.description,
        this.data,
        this.link,
        this.isRead,
        this.isActive,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    data = json['data'];
    link = json['link'];
    isRead = json['is_read'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['data'] = this.data;
    data['link'] = this.link;
    data['is_read'] = this.isRead;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['user_id'] = this.userId;
    return data;
  }
}