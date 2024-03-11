import 'dart:convert';

import 'package:fasttrack/models/faqmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../constants/api.dart';


Future<faqmodel> faq() async {
  const url= "$ROOT/faqs";
  final response = await http.get(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });


  if(response.statusCode == 200) {

    final jsonStudent =jsonDecode(response.body);
    return faqmodel.fromJson(jsonStudent);
  }
  else if (response.statusCode == 404) {
    return faqmodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 400) {
    return faqmodel.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    return faqmodel.fromJson(jsonDecode(response.body));
  }else{
    throw Exception();
  }

}