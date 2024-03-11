import 'package:fasttrack/models/resendOTP_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';



import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';


Future<resendModel> resendOTPC(String mobileNo) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var url = "$ROOT/auth/resend";
  final response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type' :'application/json; charset=UTF-8',
    },
      body: json.encode({"mobile": mobileNo}));

  print(jsonDecode(response.body));
  print("cdbd");
  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return resendModel.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return resendModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return resendModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return resendModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(jsonDecode(response.body));
  }
}