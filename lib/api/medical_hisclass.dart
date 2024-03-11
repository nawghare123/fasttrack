import 'dart:convert';

import 'package:flutter/material.dart';



import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../constants/api.dart';
import '../models/medical_hismodel.dart';



Future<medical_hismodel> medical_historyC() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  const url= "$ROOT/users/medicalhistory";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token      });

  print("aasdd");
  print(jsonDecode(response.body));

  if(response.statusCode == 200) {

    final jsonStudent =jsonDecode(response.body);
    return medical_hismodel.fromJson(jsonStudent);
  }
  else if (response.statusCode == 404) {
    return medical_hismodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return medical_hismodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return medical_hismodel.fromJson(jsonDecode(response.body));
  }else{
    throw Exception();
  }

}