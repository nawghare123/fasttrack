import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../constants/api.dart';
import '../models/booking_detailsmodel.dart';
import 'package:http/http.dart'as http;


Future<booking_details_model> booking_details(int id) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String url= "$ROOT/bookings/$id";
  String token = pref.getString('token')??'';
  final response = await http.get(Uri.parse(url),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token});

print("scddv");
print(jsonDecode(response.body));

  if(response.statusCode == 200) {

    final jsonStudent =jsonDecode(response.body);
    return booking_details_model.fromJson(jsonStudent);
  }
  else if (response.statusCode == 404) {
    return booking_details_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return booking_details_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return booking_details_model.fromJson(jsonDecode(response.body));
  }else{
    throw Exception();
  }

}



