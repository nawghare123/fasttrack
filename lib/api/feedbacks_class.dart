import 'dart:convert';

import 'package:fasttrack/models/feedbacks_model.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';



Future<feedbacks_model>feedbacksC(String type, String shortdescription,String description, String attachment) async {
  const url = "$ROOT/users/feedback";
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token')!;

  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token

      },
      body: json.encode({
        "type": type,
      "short_description":shortdescription,
        "description":description,
        "attachment":attachment
      }));
  print("njjjbb");
  print(jsonDecode(response.body));


  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return feedbacks_model.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return feedbacks_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return feedbacks_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return feedbacks_model.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }
}