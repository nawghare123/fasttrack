import 'dart:convert';

import 'package:fasttrack/models/reschedule_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';


Future<reschedule_model> rescheduleC(int id,String bookingDate,List<dynamic> old_slotid,int slotid) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String url = "$ROOT/bookings/reschedule/$id";
  String token = pref.getString('token')!;
  final response = await http.put(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token
      },
      body: json.encode({
        "booking_date": bookingDate,
        "slots":[{"slot_id":slotid}],
        "old_slots":old_slotid
      }));

  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return reschedule_model.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return reschedule_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return reschedule_model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return reschedule_model.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }
}
