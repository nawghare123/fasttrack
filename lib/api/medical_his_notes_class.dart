import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/medical_his_notes_model.dart';

Future<medical_his_notes_deletemodel>medical_his_notesC(List<dynamic> medical_history,int bookingid, String notes) async {
  const url = "$ROOT/users/medicalhistory";
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token')!;

  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token

      },
      body: json.encode({
        "medical_history":medical_history,
        "booking_id":bookingid,
        "notes":notes
      }));




  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return medical_his_notes_deletemodel.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return medical_his_notes_deletemodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return medical_his_notes_deletemodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return medical_his_notes_deletemodel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(jsonDecode(response.body));
  }
}