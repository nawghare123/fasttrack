import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/CapturePaymentModel.dart';
import 'package:http/http.dart'as http;


Future<CapturePaymentModel> capturePayment(String oid, String tid, String amount,int bookingid) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final url = "$ROOT/users/payments/capture";
  String token = pref.getString('token')!;
  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token
      },
      body: json.encode({
        "order_id":oid,
        "transaction_id":tid,
        "amount":amount,
        "booking_id":bookingid
      }));
  print("hxssss");
  print(jsonDecode(response.body));

  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return CapturePaymentModel.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return CapturePaymentModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return CapturePaymentModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return CapturePaymentModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }
}
