import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/ambulance_profile_model.dart';

import 'package:http/http.dart'as http;

Future<Ambulance_profile_slot_model>Ambulance_profile_slotC(String id) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String url= "$ROOT/ambulances/$id";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token });


  if(response.statusCode == 200) {
    print("fgugyih");
    print(jsonDecode(response.body));
    final jsonStudent =jsonDecode(response.body);
    return Ambulance_profile_slot_model.fromJson(jsonStudent);
  }
  else if (response.statusCode == 404) {
    return Ambulance_profile_slot_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return Ambulance_profile_slot_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return Ambulance_profile_slot_model.fromJson(jsonDecode(response.body));
  }else{
    throw Exception();
  }

}