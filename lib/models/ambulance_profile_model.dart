class Ambulance_profile_slot_model {
  bool? success;
  String? message;
  Data? data;

  Ambulance_profile_slot_model({this.success, this.message, this.data});

  Ambulance_profile_slot_model.fromJson(Map<String, dynamic> json) {
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
  Ambulance? ambulance;

  Data({this.ambulance});

  Data.fromJson(Map<String, dynamic> json) {
    ambulance = json['ambulance'] != null
        ? new Ambulance.fromJson(json['ambulance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ambulance != null) {
      data['ambulance'] = this.ambulance!.toJson();
    }
    return data;
  }
}

class Ambulance {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? timeZone;
  String? profilePic;
  String? agencyName;
  int? consultationFees;
  String? ambulanceType;
  String? address;


  Ambulance(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.timeZone,
        this.profilePic,
        this.agencyName,
        this.consultationFees,
        this.ambulanceType,
        this.address,
        });

  Ambulance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    timeZone = json['time_zone'];
    profilePic = json['profile_pic'];
    agencyName = json['agency_name'];
    consultationFees = json['consultation_fees'];
    ambulanceType = json['ambulance_type'];
    address = json['address'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['time_zone'] = this.timeZone;
    data['profile_pic'] = this.profilePic;
    data['agency_name'] = this.agencyName;
    data['consultation_fees'] = this.consultationFees;
    data['ambulance_type'] = this.ambulanceType;
    data['address'] = this.address;

    return data;
  }
}