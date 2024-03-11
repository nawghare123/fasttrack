import 'dart:async';

import 'package:fasttrack/Screens/Booking_process_profile_home%20care.dart';
import 'package:fasttrack/Screens/Payment_history.dart';
import 'package:fasttrack/Screens/drawer.dart';
import 'package:fasttrack/Screens/serviceproviderlist.dart';
import 'package:fasttrack/api/home.dart';
import 'package:fasttrack/models/search.dart';
import 'package:fasttrack/others/bottomnavbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/commonclass.dart';
import '../api/diseaseclass.dart';
import '../api/specialityclass.dart';
import '../blocs/application_bloc.dart';
import '../models/disease_speciality_model.dart';
import '../style.dart';
import 'Notification.dart';
import 'Service_provider_profile.dart';
import 'Teleconsultancy.dart';
import 'ambulance_services.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _locationcontroller = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String location = "Select";
  List<String> findLocation = [];
  StreamSubscription? locationSubscription;
  Completer<GoogleMapController> _mapController = Completer();
  late GoogleMapController mapController;
  String? token = '';

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.setCurrentLocation();

    if (applicationBloc.city != null) {
      location = applicationBloc.city!.toLowerCase();
      _locationcontroller.text = applicationBloc.city!.toUpperCase();
    }
    loadtoken();
    super.initState();
  }

  void loadtoken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      if (pref.getString('token') != null)
        token = pref.getString('token') ?? "";
    });
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          //Autocomplete locations
          NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollStartNotification) {
                  applicationBloc.clearSelectedLocation();
                  _controller.text = "";
                  findLocation.clear();
                }
                return true;
              },
              child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 100,
                  color: teal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: SizedBox(
                                width: 150,
                                child: TextFormField(
                                    controller: _locationcontroller,
                                    style: TextStyle(color: pwhite),
                                    decoration: InputDecoration(
                                        filled: false,
                                        prefixIcon: Image.asset(
                                          "asset/images/location.png",
                                        ),
                                        hintText: "Search City",
                                        hintStyle: TextStyle(
                                            color: pwhite, fontSize: 14),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 15),
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      if (value.length > 1) {
                                        setState(() {
                                          findLocation.clear();
                                          applicationBloc.cityList
                                              .forEach((data) {
                                            if (data.toLowerCase().contains(value.toLowerCase()))
                                              findLocation.add(data);
                                          });
                                        });
                                      }
                                    },
                                    onTap: () {
                                      findLocation.clear();
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      applicationBloc.clearSelectedLocation();
                                      _locationcontroller.text = "";
                                    }),
                              ),
                            ),
                            SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 40),
                              child: SizedBox(
                                width: 100,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      notification()));
                                        },
                                        child: Image.asset(
                                            "asset/images/bell.png")),
                                    InkWell(
                                      onTap: () {
                                        _scaffoldKey.currentState
                                            ?.openEndDrawer();
                                      },
                                      child: ClipOval(
                                        child: SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: (applicationBloc.profilepic !=
                                                        null &&
                                                    applicationBloc.profilepic !=
                                                        "")
                                                ? Image.network(
                                                    (applicationBloc.profilepic ??
                                                            "")
                                                        .toString(),
                                                    width: 50,
                                                    height: 50,
                                                  )
                                                : Image.asset(
                                                    "asset/images/boy.png",
                                                    width: 50,
                                                    height: 50,
                                                  )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "FastTrack",
                          style: TextStyle(
                              fontSize: 20,
                              color: pwhite,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Book verified Health care expert",
                            style: TextStyle(fontSize: 16, color: pwhite)),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            controller: _controller,
                            //onEditingComplete: _controller.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: pwhite,
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: hinttext,
                              ),
                              hintText: "Search for a health care expert",
                              hintStyle:
                                  TextStyle(color: hinttext, fontSize: 14),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: pwhite),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: pwhite),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.length > 2) {
                                applicationBloc.searchHome(value, location);
                              }

                            },
                            onTap: () {
                              applicationBloc.clearSelectedLocation();
                              FocusManager.instance.primaryFocus?.unfocus();
                              _controller.text = "";
                            }),
                      ],
                    ),
                  ),
                ),
                (token!=null && token!="")?
                FutureBuilder(
                    future: homeapi(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        final userdata = snapshot.data;
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: snapshot.data.data.length,
                                itemBuilder: (BuildContext context, index) {
                                  if (userdata.data[index].layout ==
                                      "RectangularCard") {
                                    return Container(
                                      width: MediaQuery.of(context).size.width *
                                          100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              userdata.data[index].title,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: text,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            GridView(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 5,
                                                      mainAxisSpacing: 5,
                                                      mainAxisExtent: 195),
                                              children: [
                                                for (int i = 0;
                                                    i <
                                                        userdata.data[index]
                                                            .cards.length;
                                                    i++)
                                                  InkWell(
                                                    onTap: () {
                                                      if (userdata.data[index]
                                                              .cards[i].header
                                                              .toLowerCase() ==
                                                          "teleconsultancy")
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        bottomnavvar(
                                                                          index:
                                                                              1,
                                                                        )));
                                                      if (userdata.data[index]
                                                              .cards[i].header
                                                              .toLowerCase() ==
                                                          "home care")
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        bottomnavvar(
                                                                          index:
                                                                              2,
                                                                        )));
                                                      if (userdata.data[index]
                                                          .cards[i].header
                                                          .toLowerCase()
                                                          .contains(
                                                              "ambulance"))
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        bottomnavvar(
                                                                          index:
                                                                              3,
                                                                        )));
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          elevation: 0.5,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                  height: 100,
                                                                  width: 120,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        bluelight,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                15),
                                                                        topRight:
                                                                            Radius.circular(15)),
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    userdata
                                                                            .data[index]
                                                                            .cards[i]
                                                                            .bannerImage ??
                                                                        "",
                                                                    height: 20,
                                                                  )),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      userdata
                                                                          .data[
                                                                              index]
                                                                          .cards[
                                                                              i]
                                                                          .title,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              darkgrey),
                                                                    ),
                                                                    Text(
                                                                      userdata
                                                                          .data[
                                                                              index]
                                                                          .cards[
                                                                              i]
                                                                          .header,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              text,
                                                                          fontSize:
                                                                              11),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                              ],
                                              padding: EdgeInsets.all(10),
                                              shrinkWrap: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else if (userdata.data[index].layout ==
                                      "Banner") {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      color: greenlight,
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 200,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.network(
                                                    userdata
                                                            .data[index]
                                                            .cards[0]
                                                            .bannerImage ??
                                                        "",
                                                    height: 100,
                                                  )
                                                ],
                                              )),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 25,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  userdata.data[index].cards[0]
                                                      .header,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: text,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Center(
                                                child: MaterialButton(
                                                    color: buttoncolor,
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      side: BorderSide(
                                                          color: buttoncolor,
                                                          width: 1),
                                                    ),

                                                    //  minWidth: MediaQuery.of(context).size.width*0.10,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8,
                                                            horizontal: 20),
                                                    child: Text(
                                                      "Book now",
                                                      style: TextStyle(
                                                          color: pwhite,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ambulance_services()));
                                                    }),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  } else if (userdata.data[index].layout ==
                                      "CircularCard") {
                                    return Container(
                                      width: MediaQuery.of(context).size.width *
                                          100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              userdata.data[index].title,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: text,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            GridView(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 5,
                                                      mainAxisSpacing: 5,
                                                      mainAxisExtent: 120),
                                              children: [
                                                for (int i = 0;
                                                    i <
                                                        userdata.data[index]
                                                            .cards.length;
                                                    i++)
                                                  InkWell(onTap: (){

                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>service_provider_list(
                                                      search_value: userdata!.data![index].cards[i].header,
                                                    )));

                                                  },
                                                    child: Column(
                                                      children: [
                                                        ClipOval(
                                                          child:
                                                              SizedBox.fromSize(
                                                            size: Size.fromRadius(
                                                                40),
                                                            // Image radius
                                                            child: Image.network(
                                                                userdata
                                                                        .data[
                                                                            index]
                                                                        .cards[i]
                                                                        .bannerImage ??
                                                                    "",
                                                                fit:
                                                                    BoxFit.cover),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          userdata.data[index]
                                                              .cards[i].header,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color: text,
                                                              fontSize: 11),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                              padding: EdgeInsets.all(10),
                                              shrinkWrap: true,
                                            ),
                                            SizedBox(height: 20),
                                            Center(
                                              child: MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    side: BorderSide(
                                                        color: buttoncolor,
                                                        width: 1),
                                                  ),

                                                  //  minWidth: MediaQuery.of(context).size.width*0.10,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 40),
                                                  child: Text(
                                                    "View all",
                                                    style: TextStyle(
                                                        color: buttoncolor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18),
                                                  ),
                                                  onPressed: () {
                                                    if (userdata
                                                        .data[index].viewMore)
                                                      showModalBottomSheet(
                                                          context: context,
                                                          enableDrag: true,
                                                          isScrollControlled:
                                                              true,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .vertical(
                                                              top: Radius
                                                                  .circular(20),
                                                            ),
                                                          ),
                                                          builder: (builder) {
                                                            return new Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.9,
                                                                child:
                                                                    DraggableScrollableSheet(
                                                                        initialChildSize:
                                                                            1,
                                                                        builder:
                                                                            (_, controller) {
                                                                          return SingleChildScrollView(
                                                                              child: Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              FutureBuilder<disease_speciality_model>(
                                                                                  future: (userdata.data[index].title.contains('spec'))
                                                                                      ? speciality()
                                                                                      : (userdata.data[index].title.contains('Comm'))
                                                                                          ? common()
                                                                                          : disease(),
                                                                                  builder: (BuildContext context, snapshot) {
                                                                                    if (snapshot.hasData) {
                                                                                      final userdatas = snapshot.data;
                                                                                      return Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.all(15),
                                                                                            child: Text(
                                                                                              userdata.data[index].title,
                                                                                              style: TextStyle(fontSize: 18, color: text, fontWeight: FontWeight.w500),
                                                                                            ),
                                                                                          ),
                                                                                          ListView.builder(
                                                                                              shrinkWrap: true,
                                                                                              physics: NeverScrollableScrollPhysics(),
                                                                                              itemCount: snapshot.data?.data?.length,
                                                                                              itemBuilder: (BuildContext context, index) {
                                                                                                return Column(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.only(left: 15, bottom: 10, right: 10, top: 15),
                                                                                                      child: Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                        children: [
                                                                                                          SizedBox(
                                                                                                            width: MediaQuery.of(context).size.width * 0.6,
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                                              children: [
                                                                                                                Image.network(
                                                                                                                  userdatas!.data![index]!.imagePath!,
                                                                                                                  height: 30,
                                                                                                                ),
                                                                                                                SizedBox(width: 10),
                                                                                                                Text(
                                                                                                                  userdatas!.data![index]!.title.toString(),
                                                                                                                  style: TextStyle(color: teal, fontSize: 14, fontWeight: FontWeight.w500),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          Container(
                                                                                                              width: MediaQuery.of(context).size.width * 0.2,
                                                                                                              child: Icon(
                                                                                                                Icons.keyboard_arrow_right_outlined,
                                                                                                                color: hinttext,
                                                                                                              ))
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                    Divider(
                                                                                                      thickness: 0.5,
                                                                                                      color: hinttext,
                                                                                                    ),
                                                                                                  ],
                                                                                                );
                                                                                              })
                                                                                        ],
                                                                                      );
                                                                                    } else if (snapshot.hasError) {
                                                                                      return Text('${snapshot.error}');
                                                                                    }
                                                                                    return Center(
                                                                                      child: CircularProgressIndicator(),
                                                                                    );
                                                                                  })
                                                                            ],
                                                                          ));
                                                                        }));
                                                          });


                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Text('');
                                  }
                                }));
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Center(child: CircularProgressIndicator());
                    }):Center(child:CircularProgressIndicator()),
              ],
            ),
          )),
          if (applicationBloc.searchModel != null &&
              applicationBloc.searchModel!.data!.length != 0 &&
              _controller.text.length > 0)
            Padding(
                padding: EdgeInsets.only(left: 20, right: 15, top: 0),
                child: Container(
                  height: 300.0,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.29),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                      itemCount: applicationBloc.searchModel!.data!.length,
                      itemBuilder: (context, index) {
                        return Ink(
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                applicationBloc
                                        .searchModel!.data![index].name! +
                                    " - " +
                                    applicationBloc
                                        .searchModel!.data![index].type!,
                                style: TextStyle(color: Colors.black),
                              ),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (applicationBloc
                                        .searchModel!.data![index].type ==
                                    "Doctor")
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              service_provider_profile(
                                                user_id: applicationBloc
                                                    .searchModel!
                                                    .data![index]
                                                    .id
                                                    .toString(),
                                              )));
                                if (applicationBloc
                                        .searchModel!.data![index].type ==
                                    "Nurse")
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Booking_process_profile_home_care(
                                                userid: applicationBloc
                                                    .searchModel!
                                                    .data![index]
                                                    .id
                                                    .toString(),
                                              )));
                                if (applicationBloc
                                        .searchModel!.data![index].type ==
                                    "specialization")
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              service_provider_list(
                                                userid: applicationBloc
                                                    .searchModel!
                                                    .data![index]
                                                    .id
                                                    .toString(),
                                                //   name:  applicationBloc.searchModel!.data![index].name!
                                              )));
                                setState(() {});
                              },
                            ));
                      }),
                )),

          if (findLocation != null &&
              findLocation.length != 0 &&
              _locationcontroller.text.length > 0)
            Padding(
                padding: EdgeInsets.only(left: 20, right: 15, top: 0),
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.12),
                  width: 130,
                  decoration: BoxDecoration(
                    color: teal,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                      itemCount: findLocation.length,
                      itemBuilder: (context, index) {
                        return Ink(
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                findLocation[index],
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  _locationcontroller.text =
                                      findLocation[index].toUpperCase();
                                  findLocation.clear();
                                });
                              },
                            ));
                      }),
                )),
        ],
      ),
      endDrawer: drawer(),
    );
  }
}
