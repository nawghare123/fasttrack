import 'dart:convert';

import 'package:fasttrack/models/payment_historymodel.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';



Future<Payment_historymodel> Payment_historyC() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  const url= "$ROOT/users/payments";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token});

  print(jsonDecode(response.body));
  print('cxccb');

  if(response.statusCode == 200) {

    final jsonStudent =jsonDecode(response.body);
    return Payment_historymodel.fromJson(jsonStudent);
  }
  else if (response.statusCode == 404) {
    return Payment_historymodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return Payment_historymodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return Payment_historymodel.fromJson(jsonDecode(response.body));
  }else{
    throw Exception();
  }

}