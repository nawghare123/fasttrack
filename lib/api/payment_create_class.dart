import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/payment_create_model.dart';


Future<payment_create_model> createOrderC(String amount) async {
  const url = "$ROOT/users/payments/orders";
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token')??'';

  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token

      },
      body: json.encode({
        "amount":amount,
      "requestfrom":"MOBILE"}));

  print("hxssss");
  print(jsonDecode(response.body));


  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return payment_create_model.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return payment_create_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return payment_create_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return payment_create_model.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }
}