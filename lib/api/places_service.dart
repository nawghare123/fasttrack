import 'package:fasttrack/models/place_by_latlng.dart';
import 'package:http/http.dart' as http;
import 'package:fasttrack/models/place.dart';
import 'dart:convert' as convert;

import 'package:fasttrack/models/place_search.dart';

class PlacesService {
  final key = 'AIzaSyA6KSQ1K4AYunLrJLZzibbZOAMWBSuqIPo';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String,dynamic>;
    return Place.fromJson(jsonResult);
  }

  Future<PlaceLatlng> getPlacebylatlng(double lat,double lng) async {
    var url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json as Map<String,dynamic>;
    return PlaceLatlng.fromJson(jsonResult);
  }

  Future<List<Place>> getPlaces(double lat, double lng,String placeType) async {
    var url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}