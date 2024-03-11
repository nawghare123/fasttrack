class UpdateProfileModel {
  bool? success;
  String? message;
  Data? data;

  UpdateProfileModel({this.success, this.message, this.data});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? mobile;
  String? email;
  String? userType;
  String? blood_group;
  int? completedStep;
  String? profilePic;
  String? timeZone;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.userType,
        this.blood_group,
        this.completedStep,
        this.profilePic,
        this.timeZone,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    userType = json['user_type'];
    blood_group = json['blood_group'];
    completedStep = json['completed_step'];
    profilePic = json['profile_pic'];
    timeZone = json['time_zone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['user_type'] = this.userType;
    data['blood_group'] = this.blood_group;
    data['completed_step'] = this.completedStep;
    data['profile_pic'] = this.profilePic;
    data['time_zone'] = this.timeZone;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}