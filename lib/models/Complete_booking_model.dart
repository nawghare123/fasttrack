class Complete_booking_model {
  bool? success;
  String? message;
  List<Data>? data;

  Complete_booking_model({this.success, this.message, this.data});

  Complete_booking_model.fromJson(Map<String, dynamic> json) {
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
  String? appoinmentDate;
  String? serviceType;
  String? bookedFor;
  String? pickupAddress;
  int? isVideoConsultancy;
  String? otherName;
  String? otherGender;
  String? otherMobile;
  String? otherAge;
  String? shortDescription;
  int? totalAmount;
  int? paidAmount;
  String? reason;
  String? status;
  int? isActive;
  String? name;
  String? profilePic;
  String? service;
  int? serviceProviderId;
  String? bookingDate;
  List<Docs>? docs;

  Data(
      {this.id,
        this.appoinmentDate,
        this.serviceType,
        this.bookedFor,
        this.pickupAddress,
        this.isVideoConsultancy,
        this.otherName,
        this.otherGender,
        this.otherMobile,
        this.otherAge,
        this.shortDescription,
        this.totalAmount,
        this.paidAmount,
        this.reason,
        this.status,
        this.isActive,
        this.name,
        this.profilePic,
        this.service,
        this.serviceProviderId,
        this.bookingDate,
        this.docs});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appoinmentDate = json['appoinment_date'];
    serviceType = json['service_type'];
    bookedFor = json['booked_for'];
    pickupAddress = json['pickup_address'];
    isVideoConsultancy = json['is_video_consultancy'];
    otherName = json['other_name'];
    otherGender = json['other_gender'];
    otherMobile = json['other_mobile'];
    otherAge = json['other_age'];
    shortDescription = json['short_description'];
    totalAmount = json['total_amount'];
    paidAmount = json['paid_amount'];
    reason = json['reason'];
    status = json['status'];
    isActive = json['is_active'];
    name = json['name'];
    profilePic = json['profile_pic'];
    service = json['service'];
    serviceProviderId = json['service_provider_id'];
    bookingDate = json['booking_date'];
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(new Docs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appoinment_date'] = this.appoinmentDate;
    data['service_type'] = this.serviceType;
    data['booked_for'] = this.bookedFor;
    data['pickup_address'] = this.pickupAddress;
    data['is_video_consultancy'] = this.isVideoConsultancy;
    data['other_name'] = this.otherName;
    data['other_gender'] = this.otherGender;
    data['other_mobile'] = this.otherMobile;
    data['other_age'] = this.otherAge;
    data['short_description'] = this.shortDescription;
    data['total_amount'] = this.totalAmount;
    data['paid_amount'] = this.paidAmount;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    data['name'] = this.name;
    data['profile_pic'] = this.profilePic;
    data['service'] = this.service;
    data['service_provider_id'] = this.serviceProviderId;
    data['booking_date'] = this.bookingDate;
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Docs {
  String? reportName;
  String? attachment;

  Docs({this.reportName, this.attachment});

  Docs.fromJson(Map<String, dynamic> json) {
    reportName = json['report_name'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['report_name'] = this.reportName;
    data['attachment'] = this.attachment;
    return data;
  }
}