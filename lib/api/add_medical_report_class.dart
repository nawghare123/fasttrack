import 'dart:convert';

import 'package:fasttrack/models/add_medical_report_model.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';



Future<AddMedicalReportModel>AddMedicalReportC(String report_date, String doctor_name,String specialization, String report_name,
    String details,String attachment,) async {
  const url = "$ROOT/users/medicalreports";
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token')!;

  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token

      },
      body: json.encode({
        "report_date": report_date,
        "doctor_name":doctor_name,
        "specialization":specialization,
        "report_name":report_name,
        'details':details,
        'attachment':attachment
      }));
  print("njjbbfvdjhuuvbb");
  print(jsonDecode(response.body));


  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return AddMedicalReportModel.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return AddMedicalReportModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return AddMedicalReportModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return AddMedicalReportModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }
}