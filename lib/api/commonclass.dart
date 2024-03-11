import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../constants/api.dart';
import '../models/disease_speciality_model.dart';


Future<disease_speciality_model> common() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  const url= "$ROOT/disease?type=Common";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token      });


  if(response.statusCode == 200) {

    final jsonStudent =jsonDecode(response.body);
    return disease_speciality_model.fromJson(jsonStudent);
  }
  else if (response.statusCode == 404) {
    return disease_speciality_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return disease_speciality_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return disease_speciality_model.fromJson(jsonDecode(response.body));
  }else{
    throw Exception();
  }

}
