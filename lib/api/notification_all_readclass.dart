import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/notification_all_readmodel.dart';

import 'package:http/http.dart'as http;

Future<Notification_all_read_model>notification_all_readC() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String url= "$ROOT/notifications";
  String token = pref.getString('token')!;
  final response = await http.patch(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token
      });
print(jsonDecode(response.body));
print("vv");

  if(response.statusCode == 200) {
    final jsonStudent =jsonDecode(response.body);
    return Notification_all_read_model.fromJson(jsonStudent);
  }
  else if (response.statusCode == 404) {
    return Notification_all_read_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return Notification_all_read_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return Notification_all_read_model.fromJson(jsonDecode(response.body));
  }else{
    throw Exception();
  }

}