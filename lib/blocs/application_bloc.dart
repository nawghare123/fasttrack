import 'dart:async';

import 'package:fasttrack/Screens/Payment_history.dart';
import 'package:fasttrack/Screens/booking_details.dart';
import 'package:fasttrack/Screens/profile.dart';
import 'package:fasttrack/api/search.dart';
import 'package:fasttrack/models/homecareservicelist.dart';
import 'package:fasttrack/models/search_nurse_model.dart';
import 'package:fasttrack/models/serachdoctor.dart';
import 'package:fasttrack/models/updateprofile.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fasttrack/models/geometry.dart';
import 'package:fasttrack/models/location.dart';
import 'package:fasttrack/models/place.dart';
import 'package:fasttrack/models/place_search.dart';
import 'package:fasttrack/api/geolocator_service.dart';
import 'package:fasttrack/api/marker_service.dart';
import 'package:fasttrack/api/places_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/booking_detailsclass.dart';
import '../api/Nurses_profile_slots_class.dart';
import '../api/doctor_profile_slots_class.dart';
import '../api/homecareservice_class.dart';
import '../api/onboarding.dart';
import '../api/usereprofileclass.dart';
import '../models/Nurses_profile_slots_model.dart';
import '../models/booking_detailsmodel.dart';
import '../models/doctor_profile_slots_model.dart';
import '../models/otp.dart';
import '../models/payment_historymodel.dart';
import '../models/search.dart';
import '../models/serach_ambulance_model.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();

  //Variables
  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  StreamController<Place?> selectedLocation =
      StreamController<Place?>.broadcast();
  StreamController<LatLngBounds> bounds =
      StreamController<LatLngBounds>.broadcast();

  Place? selectedLocationStatic;
  late String placeType;
  late List<Place> placeResults;

  UpdateProfileModel? updateProfileModel;
  VerifyOtpModal? verifyOTPModel;


  late List<Marker> markers = <Marker>[];
  double? lat;
  double? lng;
  String? city = 'bhopal';
  String name = '';
  String userid = "";
  String mobile = "";
  String email = "";
  String bloodgroup = "";
  String profilepic = "";

  SearchModel? searchModel;
  SearchDoctorModel? searchDoctorModel;
  Payment_historymodel? payment_historymodel;
  Search_Nurse_Model? searchNurseModel;
  Search_Ambulance_Model? searchAmbulanceModel;
  HomeCareServiceListModel? homeCareServiceListModel;
  doctor_profile_slots_model? doctorsProfileSlots;
  Nurses_profile_slots_model? nursesProfileSlots;
  booking_details_model?bookingDetails;

  List<String> cityList = [
    "Agartala",
    "Agra",
    "Agumbe",
    "Ahmedabad",
    "Aizawl",
    "Ajmer",
    "Alappuzha Beach",
    "Allahabad",
    "Alleppey",
    "Almora",
    "Amarnath",
    "Amritsar",
    "Anantagir",
    "Andaman and Nicobar Islands",
    "Araku valley",
    "Aurangabad",
    "Ayodhya",
    "Badrinath",
    "Bangalore",
    "Baroda",
    "Bastar",
    "Bhagalpur",
    "Bhilai",
    "Bhimtal",
    "Bhopal",
    "Bhubaneswar",
    "Bhuj",
    "Bidar",
    "Bilaspur",
    "Bodh Gaya",
    "Calicut",
    "Chail",
    "Chamba",
    "Chandigarh",
    "Chennai",
    "Chennai Beaches",
    "Cherai",
    "Cherrapunji",
    "Chidambaram",
    "Chikhaldara Hills",
    "Chopta",
    "Coimbatore",
    "Coonoor",
    "Coorg",
    "Corbett National Park",
    "Cotigao Wild Life Sanctuary",
    "Cuttack",
    "Dadra and Nagar Haveli",
    "Dalhousie",
    "Daman and Diu",
    "Darjeeling",
    "Dehradun",
    "Delhi",
    "Devikulam",
    "Dhanaulti",
    "Dharamashala",
    "Dindigul",
    "Dudhwa National Park",
    "Dwaraka",
    "Faridabad",
    "Gandhinagar",
    "Gangotri",
    "Gangtok",
    "Gir Wildlife Sanctuary",
    "Goa",
    "Great Himalayan National Park",
    "Gulmarg",
    "Gurgaon",
    "Guruvayoor",
    "Guwahati",
    "Gwalior",
    "Hampi",
    "Haridwar",
    "Hogenakkal",
    "Horsley Hills",
    "Hyderabad",
    "Idukki",
    "Imphal",
    "Indore",
    "Itangar",
    "Jabalpur",
    "Jaipur",
    "Jaisalmer",
    "Jalandhar",
    "Jammu",
    "Jamshedpur",
    "Jodhpur",
    "Kanchipuram",
    "Kanha National Park",
    "Kanpur",
    "Kanyakumari",
    "Kargil",
    "Karwar",
    "Kausani",
    "Kedarnath",
    "Keoladeoghana National Park",
    "Khajuraho",
    "Kochi",
    "Kodaikanal",
    "Kolkata",
    "Kollam",
    "Konark",
    "Kotagiri",
    "Kottakkal and Ayurveda",
    "Kovalam",
    "Kovalam and Ayurveda",
    "Kudremukh",
    "Kullu",
    "Kumaon",
    "Kumarakom",
    "Kumarakom and Ayurveda",
    "Kumarakom Bird Sanctuary",
    "Kurukshetra",
    "Lakshadweep",
    "Lucknow",
    "Ludhiana",
    "Madurai",
    "Mahabalipuram",
    "Malpe Beach",
    "Manas National Park",
    "Mangalore",
    "Maravanthe Beach",
    "Margoa",
    "Mount Abu",
    "Mumbai",
    "Munnar",
    "Mussoorie",
    "Mysore",
    "Nahsik",
    "Nagpur",
    "Nalanda",
    "Nanda Devi National Park",
    "Nandi Hills",
    "Netravali Wild Life Sanctuary",
    "Ooty",
    "Orchha",
    "Pahalgam",
    "Palakkad",
    "Panchgani",
    "Patna",
    "Patnitop",
    "Pattadakkal",
    "Periyar Wildlife Sanctuary",
    "Pithoragarh",
    "Pondicherry",
    "Pune",
    "Puri",
    "Pushkar",
    "Raipur",
    "Rajaji National Park",
    "Rajgir",
    "Rameshwaram",
    "Ranchi",
    "Ranganthittu Bird Sanctuary",
    "Ranikhet",
    "Ranthambore",
    "Rishikesh",
    "Rourkela",
    "Sanchi",
    "Saputara",
    "Sariska Wildlife Sanctuary",
    "Shillong",
    "Shimla",
    "Sohna_Hills",
    "Srinagar",
    "Sunderbans",
    "Surat",
    "Tezpur",
    "Thanjavur",
    "Thiruvananthapuram",
    "Thrissur",
    "Tirunelveli",
    "Tirupati",
    "Trichy",
    "Udaipur",
    "Ujjain",
    "Vaishali",
    "Valley of Flowers",
    "Varanasi",
    "Varkala and Ayurveda",
    "Vijayawada",
    "Vishakhapatnam",
    "Vrindhavan",
    "Warangal",
    "Wayanad",
    "Wayanad Wildlife Sanctuary",
    "Yercaud",
    "Zanskar"
  ];

  ApplicationBloc() {
    //setCurrentLocation();
    homecareservices();
  }


  setCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    currentLocation = await Geolocator.getCurrentPosition();
    print('currentLocation $currentLocation');

    var sLocation = await placesService.getPlacebylatlng(
        currentLocation!.latitude, currentLocation!.longitude);

    city = sLocation.results![0].addressComponents![0].shortName;

    selectedLocationStatic = Place(
        name: '',
        geometry: Geometry(
          location: Location(
              lat: currentLocation!.latitude, lng: currentLocation!.longitude),
        ),
        vicinity: '');
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults =
        (await placesService.getAutocomplete(searchTerm)).cast<PlaceSearch>();
    notifyListeners();
  }

  searchHome(String searchTerm, String location) async {
    searchModel = (await search(searchTerm, location)) as SearchModel?;
    notifyListeners();
  }

  userProfile() async {
    updateProfileModel = (await userprofileC()) as UpdateProfileModel?;

    userid = updateProfileModel!.data!.id!.toString();
    name = updateProfileModel!.data!.name ?? "";
    mobile = updateProfileModel!.data!.mobile ?? "";
    email = updateProfileModel!.data!.email ?? "";
    bloodgroup = updateProfileModel!.data!.blood_group ?? "";
    profilepic = updateProfileModel!.data!.profilePic ?? "";
    print('profileff $userid $name $mobile');
    //profilepic=updateProfileModel!.data!.profilePic!;

    notifyListeners();
  }

  searchDoctor(String searchTerm) async {
    searchDoctorModel = (await searchDoctors(searchTerm)) as SearchDoctorModel?;
    print(searchDoctorModel);
    notifyListeners();
  }

  bookingDetailsUsers(int id) async {
    bookingDetails = (await booking_details(id)) as booking_details_model?;
    print(bookingDetails);
    notifyListeners();
  }
  doctorProfile(String id) async {
    doctorsProfileSlots = (await doctor_profile_slotsC(id)) as doctor_profile_slots_model?;
    print(doctorsProfileSlots);
    notifyListeners();
  }

  searchNurse(String searchTerm) async {
    searchNurseModel = (await searchNurseC(searchTerm)) as Search_Nurse_Model?;
    print('ruchika class');
    print(searchNurseModel!.data![0].name);
    notifyListeners();
  }

  nurseProfile(String id) async {
    nursesProfileSlots = (await Nurses_profile_slotsC(id)) as Nurses_profile_slots_model?;
    print(nursesProfileSlots);
    notifyListeners();
  }

  searchAmbulance(String city, String type) async {
    searchAmbulanceModel =
        (await searchAmbulanceC(city, type)) as Search_Ambulance_Model?;
    print(Search_Ambulance_Model);
    notifyListeners();
  }

  homecareservices() async {
    homeCareServiceListModel =
        (await HomeCareServiceList()) as HomeCareServiceListModel?;
    notifyListeners();
  }

  updateProfileFun(int userid,String name,String email,String mobile,String bloodgroup) async {
    updateProfileModel = (await updateuser(userid, name, email, mobile, bloodgroup)) as UpdateProfileModel?;
    notifyListeners();
  }

 verifyOTP(String otp, String mobile) async {
    verifyOTPModel = (await loginotp( otp,  mobile)) as VerifyOtpModal?;
    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    var sLocation = await placesService.getPlace(placeId);
    lat = sLocation.geometry!.location.lat;
    lng = sLocation.geometry!.location.lng;
    if (sLocation.vicinity != null) {
      city = sLocation.vicinity;
    }

    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = null;
    notifyListeners();
  }

  clearSelectedLocation() {
    selectedLocation.add(null);
    selectedLocationStatic = null;
    searchResults = null;
    placeType = '';
    searchModel = null;
    searchDoctorModel = null;
    searchNurseModel = null;
    notifyListeners();
  }

  togglePlaceType(String value, bool selected) async {
    if (selected) {
      placeType = value;
    } else {
      placeType = '';
    }

    if (placeType != null) {
      var places = await placesService.getPlaces(
          selectedLocationStatic!.geometry!.location.lat,
          selectedLocationStatic!.geometry!.location.lng,
          placeType);
      markers = [];
      if (places.length > 0) {
        var newMarker = markerService.createMarkerFromPlace(places[0], false);
        markers.add(newMarker);
      }

      var locationMarker =
          markerService.createMarkerFromPlace(selectedLocationStatic!, true);
      markers.add(locationMarker);

      var _bounds = markerService.bounds(Set<Marker>.of(markers));
      bounds.add(_bounds!);

      notifyListeners();
    }
  }



  @override
  void dispose() {
    selectedLocation.close();
    bounds.close();
    super.dispose();
  }
}
