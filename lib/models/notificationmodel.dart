class notificationmodel {

  bool? success;
  String? message;
  List<Data>? data;

  notificationmodel({this.success, this.message, this.data});

  notificationmodel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? description;
  Null? data;
  Null? link;
  int? isRead;
  String? createdAt;

  Data(
  {this.id,
  this.title,
  this.description,
  this.data,
  this.link,
  this.isRead,
  this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  title = json['title'];
  description = json['description'];
  data = json['data'];
  link = json['link'];
  isRead = json['is_read'];
  createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['title'] = this.title;
  data['description'] = this.description;
  data['data'] = this.data;
  data['link'] = this.link;
  data['is_read'] = this.isRead;
  data['created_at'] = this.createdAt;
  return data;
  }
  }