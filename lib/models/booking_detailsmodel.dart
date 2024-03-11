class booking_details_model {
  bool? success;
  String? message;
  List<Data>? data;

  booking_details_model({this.success, this.message, this.data});

  booking_details_model.fromJson(Map<String, dynamic> json) {
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
  String? email;
  String? mobile;
  String? profilePic;
  String? service;
  int? serviceProviderId;
  String? scheduledAt;
  String? tranId;
  String? paymentMode;
  int? experience;
  String? qualification;
  String? bookingDate;
  List<Slots>? slots;
  List<Specializations>? specializations;

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
        this.email,
        this.mobile,
        this.profilePic,
        this.service,
        this.serviceProviderId,
        this.scheduledAt,
        this.tranId,
        this.paymentMode,
        this.experience,
        this.qualification,
        this.bookingDate,
        this.slots,
        this.specializations});

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
    email = json['email'];
    mobile = json['mobile'];
    profilePic = json['profile_pic'];
    service = json['service'];
    serviceProviderId = json['service_provider_id'];
    scheduledAt = json['scheduled_at'];
    tranId = json['tran_id'];
    paymentMode = json['payment_mode'];
    experience = json['experience'];
    qualification = json['qualification'];
    bookingDate = json['booking_date'];
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(new Slots.fromJson(v));
      });
    }
    if (json['specializations'] != null) {
      specializations = <Specializations>[];
      json['specializations'].forEach((v) {
        specializations!.add(new Specializations.fromJson(v));
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
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profile_pic'] = this.profilePic;
    data['service'] = this.service;
    data['service_provider_id'] = this.serviceProviderId;
    data['scheduled_at'] = this.scheduledAt;
    data['tran_id'] = this.tranId;
    data['payment_mode'] = this.paymentMode;
    data['experience'] = this.experience;
    data['qualification'] = this.qualification;
    data['booking_date'] = this.bookingDate;
    if (this.slots != null) {
      data['slots'] = this.slots!.map((v) => v.toJson()).toList();
    }
    if (this.specializations != null) {
      data['specializations'] =
          this.specializations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slots {
  int? slotId;

  Slots({this.slotId});

  Slots.fromJson(Map<String, dynamic> json) {
    slotId = json['slot_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot_id'] = this.slotId;
    return data;
  }
}

class Specializations {
  String? title;

  Specializations({this.title});

  Specializations.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
}