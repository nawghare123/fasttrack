import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/get_dr_list_medicalreport_model.dart';

import 'package:http/http.dart'as http;


Future<Dr_list_medicalreport_model> Dr_list_medicalreportC() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  const url= "$ROOT/disease?type=Disease";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token });



  if(response.statusCode == 200) {

    final jsonStudent =jsonDecode(response.body);
    return Dr_list_medicalreport_model.fromJson(jsonStudent);
  }
  else if (response.statusCode == 404) {
    return Dr_list_medicalreport_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return Dr_list_medicalreport_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return Dr_list_medicalreport_model.fromJson(jsonDecode(response.body));
  }else{
    throw Exception();
  }

}