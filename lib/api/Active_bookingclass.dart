import 'dart:convert';

import 'package:fasttrack/models/active_booking_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../constants/api.dart';


Future<Active_booking_model> active_booking() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  const url= "$ROOT/bookings?status=Booked";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token });

  print("aasdd");
  print(jsonDecode(response.body));

  if(response.statusCode == 200) {

    final jsonStudent =jsonDecode(response.body);
    return Active_booking_model.fromJson(jsonStudent);
  }
  else if (response.statusCode == 404) {
    return Active_booking_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return Active_booking_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return Active_booking_model.fromJson(jsonDecode(response.body));
  }else{
    throw Exception();
  }

}