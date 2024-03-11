import 'dart:convert';

import 'package:fasttrack/models/notificationmodel.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../constants/api.dart';



Future<notificationmodel>notificationC() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  const url= "$ROOT/users/notifications";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token
      });


  if(response.statusCode == 200) {

    final jsonStudent =jsonDecode(response.body);
    return notificationmodel.fromJson(jsonStudent);
  }
  else if (response.statusCode == 404) {
    return notificationmodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return notificationmodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return notificationmodel.fromJson(jsonDecode(response.body));
  }else{
    throw Exception();
  }

}
