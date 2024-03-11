import 'dart:convert';
import 'package:fasttrack/models/search.dart';
import 'package:fasttrack/models/serachdoctor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api.dart';
import '../models/search_nurse_model.dart';
import '../models/serach_ambulance_model.dart';

Future<SearchModel> search(String text,String location) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var url = "$ROOT/search?location=$location&search_key=$text";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': token
    },);

  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return SearchModel.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return SearchModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return SearchModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return SearchModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(jsonDecode(response.body));
  }
}

Future<SearchDoctorModel>searchDoctors(String text) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var url = "$ROOT/search/doctors?&search_key=$text";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': token
    },);

  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return SearchDoctorModel.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return SearchDoctorModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return SearchDoctorModel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return SearchDoctorModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(jsonDecode(response.body));
  }
}



Future<Search_Nurse_Model>searchNurseC(String text) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var url = "$ROOT/search/nurses?&search_key=$text";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': token
    },);
print(jsonDecode(response.body));
print("jfbvd");
  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return Search_Nurse_Model.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return Search_Nurse_Model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return Search_Nurse_Model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return Search_Nurse_Model.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(jsonDecode(response.body));
  }
}


Future<Search_Ambulance_Model>searchAmbulanceC(String city,String type) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var url = "$ROOT/ambulances?city=$city&type=$type";
  String token = pref.getString('token')!;
  final response = await http.get(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': token
    },);

  print("jffvfnf");
  print( jsonDecode(response.body));

  if (response.statusCode == 200) {
    final jsonStudent = jsonDecode(response.body);
    return Search_Ambulance_Model.fromJson(jsonStudent);
  } else if (response.statusCode == 404) {
    return Search_Ambulance_Model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return Search_Ambulance_Model.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return Search_Ambulance_Model.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(jsonDecode(response.body));
  }
}