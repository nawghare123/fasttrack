import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/doctor_profile_slots_model.dart';
import 'package:http/http.dart'as http;

Future<doctor_profile_slots_model> doctor_profile_slotsC(String id) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String url= "$ROOT/doctors/$id";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token });

  print(jsonDecode(response.body));
  if(response.statusCode == 200) {
print("bbbbb");

    final jsonStudent =jsonDecode(response.body);
    return doctor_profile_slots_model.fromJson(jsonStudent);
  }
  else if (response.statusCode == 404) {
    return doctor_profile_slots_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return doctor_profile_slots_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return doctor_profile_slots_model.fromJson(jsonDecode(response.body));
  }else{
    throw Exception();
  }

}