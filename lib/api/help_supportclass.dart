import 'dart:convert';

import 'package:flutter/material.dart';



import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../constants/api.dart';
import '../models/help_supportmodel.dart';

Future<help_supportmodel>help_supportC(String issue) async {
  const url = "$ROOT/users/issues";
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token')!;

  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token

      },
      body: json.encode({"issue": issue}));
  print("hxssss");
  print(jsonDecode(response.body));


  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return help_supportmodel.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return help_supportmodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return help_supportmodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return help_supportmodel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }
}