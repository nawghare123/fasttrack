import 'dart:convert';

import 'package:fasttrack/models/cancelBooking_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api.dart';

Future<cancelBookingModel>cancelBookingC(String id) async {
  String url = "$ROOT/bookings/changestatus/$id";
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token')!;

  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization' :token
      });

print("vfhr");
print(jsonDecode(response.body));

  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return cancelBookingModel.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return cancelBookingModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return cancelBookingModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return cancelBookingModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }
}