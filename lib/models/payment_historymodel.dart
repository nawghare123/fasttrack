class Payment_historymodel {
  bool? success;
  String? message;
  List<Data>? data;

  Payment_historymodel({this.success, this.message, this.data});

  Payment_historymodel.fromJson(Map<String, dynamic> json) {
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
  int? bookingId;
  int? transactionId;
  String? transactionStatus;
  String? transactionDate;
  int? amount;
  int? doctorId;
  List<Doctor>? doctor;

  Data(
      {this.bookingId,
        this.transactionId,
        this.transactionStatus,
        this.transactionDate,
        this.amount,
        this.doctorId,
        this.doctor});

  Data.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    transactionId = json['transaction_id'];
    transactionStatus = json['transaction_status'];
    transactionDate = json['transaction_date'];
    amount = json['amount'];
    doctorId = json['doctor_id'];
    if (json['doctor'] != null) {
      doctor = <Doctor>[];
      json['doctor'].forEach((v) {
        doctor!.add(new Doctor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['transaction_id'] = this.transactionId;
    data['transaction_status'] = this.transactionStatus;
    data['transaction_date'] = this.transactionDate;
    data['amount'] = this.amount;
    data['doctor_id'] = this.doctorId;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctor {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? profilePic;
  String? specialization;

  Doctor(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.profilePic,
        this.specialization});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    profilePic = json['profile_pic'];
    specialization = json['specialization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['profile_pic'] = this.profilePic;
    data['specialization'] = this.specialization;
    return data;
  }
}