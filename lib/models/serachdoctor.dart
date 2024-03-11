class SearchDoctorModel {
  bool? success;
  String? message;
  List<Data>? data;

  SearchDoctorModel({this.success, this.message, this.data});

  SearchDoctorModel.fromJson(Map<String, dynamic> json) {
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
  String? profilePic;
  int? completedStep;
  String? gender;
  String? qualification;
  String? specialization;
  int? experience;
  int? consultationFees;
  String? bio;
  int? videoConsult;
  String? address;
  int? available;

  Data(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.timeZone,
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
        this.available});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    timeZone = json['time_zone'];
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
    available = json['Available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['time_zone'] = this.timeZone;
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
    data['Available'] = this.available;
    return data;
  }
}