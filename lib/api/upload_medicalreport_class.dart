import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';
import '../models/upload_medicalreport_model.dart';

Future<Upload_medicalreport> Upload(String image, String type) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token')!;

  var headers = {'authorization': token};
  var request =
      http.MultipartRequest('POST', Uri.parse('$ROOT/uploads?for=$type'));
  request.files.add(await http.MultipartFile.fromPath('files', image));
  request.headers.addAll(headers);

  final response = await request.send();
  final respStr = await http.Response.fromStream(response);
  print("hxssss");
  print(jsonDecode(respStr.body));

  if (response.statusCode == 200) {

    final jsonStudent = jsonDecode(respStr.body);
    return Upload_medicalreport.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return Upload_medicalreport.fromJson(jsonDecode(respStr.body));
  } else if (response.statusCode == 400) {
    return Upload_medicalreport.fromJson(jsonDecode(respStr.body));
  } else if (response.statusCode == 401) {
    return Upload_medicalreport.fromJson(jsonDecode(respStr.body));
  } else {
    throw Exception();
  }
}
