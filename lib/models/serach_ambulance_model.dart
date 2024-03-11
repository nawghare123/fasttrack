class Search_Ambulance_Model {
  bool? success;
  String? message;
  List<Data>? data;

  Search_Ambulance_Model({this.success, this.message, this.data});

  Search_Ambulance_Model.fromJson(Map<String, dynamic> json) {
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
  String? agencyName;
  int? consultationFees;
  String? ambulanceType;
  String? address;


  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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