import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/delete_medicalreport_model.dart';

Future<medicalreportdeletemodel> medicalreportdeleteC(int id) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  var url = "$ROOT/users/medicalreport/$id";
  String token = pref.getString('token')!;

  final response = await http.delete(Uri.parse(url),
    headers: <String, String>{
      'Content-Type' :'application/json; charset=UTF-8',
      'authorization': token

    },);
  print(jsonDecode(response.body));
  print("cdbd");
  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return medicalreportdeletemodel.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return medicalreportdeletemodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return medicalreportdeletemodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return medicalreportdeletemodel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(jsonDecode(response.body));
  }
}