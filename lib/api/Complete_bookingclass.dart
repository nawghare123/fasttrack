import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/Complete_booking_model.dart';


Future <Complete_booking_model>complete_booking() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  const url = "$ROOT/bookings?status=Completed";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
  headers: <String,String>{
    'Content-Type' :'application/json;charset=UTF-8',
    'authorization' :token  });

  print("mzzz");
  print(response.statusCode==200);

  if (response.statusCode==200){
    final jsonStudent = jsonDecode(response.body);
    return Complete_booking_model.fromJson(jsonDecode(response.body));
  }else if (response.statusCode==400){
    return Complete_booking_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode==404) {
    return Complete_booking_model.fromJson(jsonDecode(response.body));
  }else if (response.statusCode==401) {
    return Complete_booking_model.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }


}