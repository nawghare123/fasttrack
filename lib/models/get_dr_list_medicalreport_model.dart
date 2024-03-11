class Dr_list_medicalreport_model {
  bool? success;
  String? message;
  List<Data>? data;

  Dr_list_medicalreport_model({this.success, this.message, this.data});

  Dr_list_medicalreport_model.fromJson(Map<String, dynamic> json) {
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
  String? mobile;
  String? email;
  String? timeZone;
  int? emailVerified;
  Null? profilePic;
  int? completedStep;
  String? gender;
  String? qualification;
  String? specialization;
  int? experience;
  int? consultationFees;
  Null? bio;
  int? videoConsult;
  String? address;
  int? isActive;
  int? available;

  Data(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.timeZone,
        this.emailVerified,
        this.profilePic,
        this.completedStep,
        this.gender,
        this.qualification,
        this.specialization,
        this.experience,
        this.consultationFees,
        this.bio,
        this.videoConsult,
        this.address,
        this.isActive,
        this.available});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    timeZone = json['time_zone'];
    emailVerified = json['email_verified'];
    profilePic = json['profile_pic'];
    completedStep = json['completed_step'];
    gender = json['gender'];
    qualification = json['qualification'];
    specialization = json['specialization'];
    experience = json['experience'];
    consultationFees = json['consultation_fees'];
    bio = json['bio'];
    videoConsult = json['video_consult'];
    address = json['address'];
    isActive = json['is_active'];
    available = json['Available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['time_zone'] = this.timeZone;
    data['email_verified'] = this.emailVerified;
    data['profile_pic'] = this.profilePic;
    data['completed_step'] = this.completedStep;
    data['gender'] = this.gender;
    data['qualification'] = this.qualification;
    data['specialization'] = this.specialization;
    data['experience'] = this.experience;
    data['consultation_fees'] = this.consultationFees;
    data['bio'] = this.bio;
    data['video_consult'] = this.videoConsult;
    data['address'] = this.address;
    data['is_active'] = this.isActive;
    data['Available'] = this.available;
    return data;
  }
}