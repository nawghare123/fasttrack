import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/update_model.dart';

Future<Update_model> updateC(String profilepic) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String url = "$ROOT/users/profile";
  String token = pref.getString('token')!;
  final response = await http.put(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token
      },
      body: json.encode({
        "profile_pic": profilepic,
      }));

  if (response.statusCode == 200) {
    if (jsonDecode(response.body)['data']['profile_pic'] != null)
      pref.setString(
          "profilepic", jsonDecode(response.body)['data']['profile_pic']);

    final jsonStudent = jsonDecode(response.body);
    return Update_model.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return Update_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return Update_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return Update_model.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }
}
