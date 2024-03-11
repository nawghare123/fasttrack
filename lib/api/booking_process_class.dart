import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../constants/api.dart';
import '../models/booking_process_model.dart';



Future<booking_process_model> booking_processC
    (int userid,String date,String type,String bookedfor,int amount ,String name,
    String mobile, String description,int paidamount,String slotid ,List<dynamic> slotids)
async {
  String url = "$ROOT/bookings";
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token')??"";
 // String bookingid =pref.getString("id")!;



  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token

      },
      body: json.encode({ "user_id": userid,
        "booking_date": date,
        "service_type":type,
        "booked_for":bookedfor,
        "total_amount" :amount,
        "other_name":name,
        "other_mobile":mobile,
        "short_description":description,
        "paid_amount":paidamount,
      "slots":(slotids.length>0?slotids:[{"slot_id":slotid}])
      }));
  print("hxssss");
  print(jsonDecode(response.body));


  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return booking_process_model.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return booking_process_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return booking_process_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return booking_process_model.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }
}