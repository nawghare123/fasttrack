import 'dart:convert';

import 'package:fasttrack/constants/api.dart';
import 'package:fasttrack/models/login.dart';
import 'package:fasttrack/models/updateprofile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/otp.dart';

Future<Loginmodal> userlogin(String mobile) async {
  const url = "$ROOT/auth/login";
  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"mobile": mobile}));

  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return Loginmodal.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return Loginmodal.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return Loginmodal.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return Loginmodal.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }
}

Future<VerifyOtpModal> loginotp(String otp, String mobile) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  const url = "$ROOT/auth/verify";

  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"mobile": mobile, "otp": otp}));
  print('mjbuuububbjb');
  print(jsonDecode(response.body));





  if (response.statusCode == 200) {
    // if (jsonDecode(response.body)['data']['token'] != null)
    //   pref.setString("token", jsonDecode(response.body)['data']['token']);
    // if (jsonDecode(response.body)['data']['user'] != null)
    //   pref.setInt("user_id", jsonDecode(response.body)['data']['user']['id']);


    final jsonStudent = jsonDecode(response.body);
    return VerifyOtpModal.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return VerifyOtpModal.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return VerifyOtpModal.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return VerifyOtpModal.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(jsonDecode(response.body));
  }
}

Future<UpdateProfileModel> updateuser(
    int id, String name, String email, String mobile, String bloodgroup) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final url = "$ROOT/users/$id";
  String token = pref.getString('token')??'';
  final response = await http.put(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token
      },
      body: json.encode({
        "mobile": mobile,
        "name": name,
        "email": email,
        "blood_group": bloodgroup
      }));
  print('abcfggg');
  print(response.body);
  print(json.encode({
    "mobile": mobile,
    "name": name,
    "email": email,
    "blood_group": bloodgroup,
    "token":token
  }));

  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return UpdateProfileModel.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return UpdateProfileModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return UpdateProfileModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return UpdateProfileModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }
}
