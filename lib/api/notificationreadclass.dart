import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/notificationmodel.dart';
import '../models/notificationreadmodel.dart';



Future<notificationreadmodel>notificationread(int id) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String url= "$ROOT/notifications/$id";
  String token = pref.getString('token')!;
  final response = await http.patch(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token
      });


  if(response.statusCode == 200) {

    final jsonStudent =jsonDecode(response.body);
    return notificationreadmodel.fromJson(jsonStudent);
  }
  else if (response.statusCode == 404) {
    return notificationreadmodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return notificationreadmodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return notificationreadmodel.fromJson(jsonDecode(response.body));
  }else{
    throw Exception();
  }

}