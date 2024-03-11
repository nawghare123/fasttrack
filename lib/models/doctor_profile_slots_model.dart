class doctor_profile_slots_model {
  bool? success;
  String? message;
  Data? data;

  doctor_profile_slots_model({this.success, this.message, this.data});

  doctor_profile_slots_model.fromJson(Map<String, dynamic> json) {
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
  Doctor? doctor;
  List<Slots>? slots;

  Data({this.doctor, this.slots});

  Data.fromJson(Map<String, dynamic> json) {
    doctor =
    json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(new Slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.slots != null) {
      data['slots'] = this.slots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctor {
  int? id;
  String? name;
  String? profilePic;
  String? qualification;
  String? specialization;
  int? experience;
  int? consultationFees;
  String? bio;
  String? videoConsult;


  Doctor(
      {this.id,
        this.name,
        this.profilePic,
        this.qualification,
        this.specialization,
        this.experience,
        this.consultationFees,
        this.bio,
        this.videoConsult,
       });

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePic = json['profile_pic'];
    qualification = json['qualification'];
    specialization = json['specialization'];
    experience = json['experience'];
    consultationFees = json['consultation_fees'];
    bio = json['bio'];
    videoConsult = json['video_consult'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_pic'] = this.profilePic;
    data['qualification'] = this.qualification;
    data['specialization'] = this.specialization;
    data['experience'] = this.experience;
    data['consultation_fees'] = this.consultationFees;
    data['bio'] = this.bio;
    data['video_consult'] = this.videoConsult;

    return data;
  }
}

class Slots {
  String? date;
  List<Mornings>? mornings;
  List<Afternoons>? afternoons;
  List<Evenings>? evenings;

  Slots({this.date, this.mornings, this.afternoons, this.evenings});

  Slots.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['mornings'] != null) {
      mornings = <Mornings>[];
      json['mornings'].forEach((v) {
        mornings!.add(new Mornings.fromJson(v));
      });
    }
    if (json['afternoons'] != null) {
      afternoons = <Afternoons>[];
      json['afternoons'].forEach((v) {
        afternoons!.add(new Afternoons.fromJson(v));
      });
    }
    if (json['evenings'] != null) {
      evenings = <Evenings>[];
      json['evenings'].forEach((v) {
        evenings!.add(new Evenings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.mornings != null) {
      data['mornings'] = this.mornings!.map((v) => v.toJson()).toList();
    }
    if (this.afternoons != null) {
      data['afternoons'] = this.afternoons!.map((v) => v.toJson()).toList();
    }
    if (this.evenings != null) {
      data['evenings'] = this.evenings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Mornings {
  int? id;
  String? date;
  String? startTime;
  String? endTime;
  String? status;

  Mornings({this.id, this.date, this.startTime, this.endTime, this.status});

  Mornings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['status'] = this.status;
    return data;
  }
}
class Afternoons {
  int? id;
  String? date;
  String? startTime;
  String? endTime;
  String? status;

  Afternoons({this.id, this.date, this.startTime, this.endTime, this.status});

  Afternoons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['status'] = this.status;
    return data;
  }
}
class Evenings {
  int? id;
  String? date;
  String? startTime;
  String? endTime;
  String? status;

  Evenings({this.id, this.date, this.startTime, this.endTime, this.status});

  Evenings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['status'] = this.status;
    return data;
  }
}