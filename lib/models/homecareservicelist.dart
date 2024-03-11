class HomeCareServiceListModel {
  bool? success;
  String? message;
  List<Data>? data;

  HomeCareServiceListModel({this.success, this.message, this.data});

  HomeCareServiceListModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? shortDescription;
  String? bannerImage;
  int? price;
  bool? isActive;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.shortDescription,
        this.bannerImage,
        this.price,
        this.isActive,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDescription = json['short_description'];
    bannerImage = json['banner_image'];
    price = json['price'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['banner_image'] = this.bannerImage;
    data['price'] = this.price;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}