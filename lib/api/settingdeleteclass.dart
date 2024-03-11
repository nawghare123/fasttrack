import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/settingdeletemodel.dart';
import 'package:http/http.dart'as http;

Future<settingdeletedmodel> deleteUsers() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String userid = pref.getInt('user_id').toString()!;
  var url = "$ROOT/users/$userid";
  String token = pref.getString('token')??'';

  final response = await http.delete(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': token

    },);
print(jsonDecode(response.body));
  print(token);
print("cdbd");
  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return settingdeletedmodel.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return settingdeletedmodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return settingdeletedmodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return settingdeletedmodel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(jsonDecode(response.body));
  }
}