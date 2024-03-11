class cancelBookingModel {
  bool? success;
  String? message;
  Data? data;

  cancelBookingModel({this.success, this.message, this.data});

  cancelBookingModel.fromJson(Map<String, dynamic> json) {
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
  String? bookingDate;
  String? serviceType;
  String? bookedFor;
  String? pickupAddress;
  bool? isVideoConsultancy;
  String? otherName;
  String? otherGender;
  String? otherMobile;
  String? otherAge;
  String? shortDescription;
  int? totalAmount;
  int? paidAmount;
  String? reason;
  String? notes;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? transactionId;

  Data(
      {this.id,
        this.bookingDate,
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
        this.notes,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.transactionId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingDate = json['booking_date'];
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
    notes = json['notes'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['user_id'];
    transactionId = json['transaction_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_date'] = this.bookingDate;
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
    data['notes'] = this.notes;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['transaction_id'] = this.transactionId;
    return data;
  }
}