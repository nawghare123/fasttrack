import 'dart:convert';
import 'package:fasttrack/models/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api.dart';

Future<HomeModel> Doctors() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  const url = "$ROOT/mobile/teleconsultancy";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': token
    },);

  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return HomeModel.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return HomeModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return HomeModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return HomeModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(jsonDecode(response.body));
  }
}