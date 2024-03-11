import 'package:fasttrack/models/geometry.dart';

class Place {
  final Geometry? geometry;
  final String? name;
  final String? vicinity;

  Place({this.geometry,this.name,this.vicinity});

  factory Place.fromJson(Map<String,dynamic> json){
    return Place(
        geometry:  Geometry.fromJson(json['geometry']),
        name: json['formatted_address'],
        vicinity: json['vicinity'],
    );
  }
}

// class Place {
//   Result? result;
//   Geometry? geometry;
//   String? name;
//   String? vicinity;
//
//   Place({this.result, this.geometry,this.vicinity,this.name});
//
//   Place.fromJson(Map<String, dynamic> json) {
//     result =
//     json['result'] != null ? new Result.fromJson(json['result']) : null;
//     geometry = json['geometry'] != null
//         ? new Geometry.fromJson(json['geometry'])
//         : null;
//     name=json['name'];
//     vicinity=json['vicinity'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.result != null) {
//       data['result'] = this.result!.toJson();
//     }
//     if (this.geometry != null) {
//       data['geometry'] = this.geometry!.toJson();
//     }
//     if(this.name!=null){
//       data['name'] = this.name!;
//     }
//     if(this.vicinity!=null){
//       data['vicinity'] = this.vicinity!;
//     }
//     return data;
//   }
// }
//
// class Result {
//   List<AddressComponents>? addressComponents;
//
//   Result({this.addressComponents});
//
//   Result.fromJson(Map<String, dynamic> json) {
//     if (json['address_components'] != null) {
//       addressComponents = <AddressComponents>[];
//       json['address_components'].forEach((v) {
//         addressComponents!.add(new AddressComponents.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.addressComponents != null) {
//       data['address_components'] =
//           this.addressComponents!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class AddressComponents {
//   String? longName;
//   String? shortName;
//   List<String>? types;
//
//   AddressComponents({this.longName, this.shortName, this.types});
//
//   AddressComponents.fromJson(Map<String, dynamic> json) {
//     longName = json['long_name'];
//     shortName = json['short_name'];
//     types = json['types'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['long_name'] = this.longName;
//     data['short_name'] = this.shortName;
//     data['types'] = this.types;
//     return data;
//   }
// }
//
// class Geometry {
//   Location? location;
//
//   Geometry({this.location});
//
//   Geometry.fromJson(Map<String, dynamic> json) {
//     location = json['location'] != null
//         ? new Location.fromJson(json['location'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.location != null) {
//       data['location'] = this.location!.toJson();
//     }
//     return data;
//   }
// }
//
// class Location {
//   double? lat;
//   double? lng;
//
//   Location({this.lat, this.lng});
//
//   Location.fromJson(Map<String, dynamic> json) {
//     lat = json['lat'];
//     lng = json['lng'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     return data;
//   }
//}