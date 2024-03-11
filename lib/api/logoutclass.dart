import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/logoutmodel.dart';
import 'package:http/http.dart' as http;

Future<logoutmodel>logoutC() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final url = "$ROOT/auth/logout";
  String token = pref.getString('token')??"";
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': token
    },
  );

  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return logoutmodel.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return logoutmodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return logoutmodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return logoutmodel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(jsonDecode(response.body));
  }
}
