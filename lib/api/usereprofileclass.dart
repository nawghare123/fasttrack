import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/updateprofile.dart';



Future<UpdateProfileModel> userprofileC() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  const url= "$ROOT/users/me";
  String token = pref.getString('token')??'';
  final response = await http.get(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': token
    },);
  print('profileff');
  print(response.body);
  if(response.statusCode == 200) {

    final jsonStudent =jsonDecode(response.body);
    return UpdateProfileModel.fromJson(jsonStudent);
  }
  else if (response.statusCode == 404) {
    return UpdateProfileModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return UpdateProfileModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return UpdateProfileModel.fromJson(jsonDecode(response.body));
  }else{
    throw Exception();
  }

}