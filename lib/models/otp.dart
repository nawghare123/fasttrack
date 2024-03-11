class VerifyOtpModal {
  bool? success;
  String? message;
  Data? data;

  VerifyOtpModal({this.success, this.message, this.data});

  VerifyOtpModal.fromJson(Map<String, dynamic> json) {
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
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? userType;
  bool? emailVerified;
  int? completedStep;
  String? profilePic;
  String? timeZone;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.userType,
        this.emailVerified,
        this.completedStep,
        this.profilePic,
        this.timeZone,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    userType = json['user_type'];
    emailVerified = json['email_verified'];
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
    data['email_verified'] = this.emailVerified;
    data['completed_step'] = this.completedStep;
    data['profile_pic'] = this.profilePic;
    data['time_zone'] = this.timeZone;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}