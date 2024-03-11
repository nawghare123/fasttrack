class booking_process_model {
  bool? success;
  String? message;
  Data? data;

  booking_process_model({this.success, this.message, this.data});

  booking_process_model.fromJson(Map<String, dynamic>
  json) {
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
  String? status;
  int? id;
  int? userId;
  String? bookingDate;
  String? serviceType;
  String? bookedFor;
  bool? isVideoConsultancy;
  String? otherName;
  String? otherMobile;
  int? totalAmount;
  String? shortDescription;
  int? paidAmount;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.status,
        this.id,
        this.userId,
        this.bookingDate,
        this.serviceType,
        this.bookedFor,
        this.isVideoConsultancy,
        this.otherName,
        this.otherMobile,
        this.totalAmount,
        this.shortDescription,
        this.paidAmount,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    userId = json['user_id'];
    bookingDate = json['booking_date'];
    serviceType = json['service_type'];
    bookedFor = json['booked_for'];
    isVideoConsultancy = json['is_video_consultancy'];
    otherName = json['other_name'];
    otherMobile = json['other_mobile'];
    totalAmount = json['total_amount'];
    shortDescription = json['short_description'];
    paidAmount = json['paid_amount'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['booking_date'] = this.bookingDate;
    data['service_type'] = this.serviceType;
    data['booked_for'] = this.bookedFor;
    data['is_video_consultancy'] = this.isVideoConsultancy;
    data['other_name'] = this.otherName;
    data['other_mobile'] = this.otherMobile;
    data['total_amount'] = this.totalAmount;
    data['short_description'] = this.shortDescription;
    data['paid_amount'] = this.paidAmount;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}