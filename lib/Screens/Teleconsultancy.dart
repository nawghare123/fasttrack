import 'package:fasttrack/Screens/serviceproviderlist.dart';
import 'package:fasttrack/api/teleconsoulting.dart';
import 'package:fasttrack/models/serachdoctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/commonclass.dart';
import '../api/diseaseclass.dart';
import '../api/search.dart';
import '../api/specialityclass.dart';
import '../blocs/application_bloc.dart';
import '../models/disease_speciality_model.dart';
import '../style.dart';
import 'Service_provider_profile.dart';

class Teleconsultancy extends StatefulWidget {
  const Teleconsultancy({Key? key}) : super(key: key);

  @override
  _TeleconsultancyState createState() => _TeleconsultancyState();
}

class _TeleconsultancyState extends State<Teleconsultancy> {
  TextEditingController _controller = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  SearchDoctorModel? data;

  void initState() {
    loaduser1("");
    super.initState();
  }

  void loaduser1(String s) async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    await applicationBloc.searchDoctor(s);
    setState(() {
      data = applicationBloc.searchDoctorModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
        key: _scaffoldKey,

        body: (data != null && data!.data != null)
            ? Stack(children: [
          NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollStartNotification) {
                  applicationBloc.clearSelectedLocation();
                  _controller.text = "";
                  _controller.clear();
                }
                return true;
              },
              child:  SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Search disease/speciality",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: text,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _controller,
                              decoration: InputDecoration(
                                //filled: true,
                                // fillColor: pwhite,
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  color: hinttext,
                                ),
                                hintText: "Ex. Fever, Orthopedician",
                                hintStyle: TextStyle(
                                    color: hinttext,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 0.5, color: hinttext),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 0.5, color: hinttext),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.length > 2) {
                                  loaduser1(value);
                                } else {
                                  loaduser1("");
                                }
                              },
                              onTap: () {
                                applicationBloc.clearSelectedLocation();
                                _controller.text = "";
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            FutureBuilder(
                                future: Doctors(),
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData) {
                                    final userdata = snapshot.data;
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            itemCount:
                                                snapshot.data.data.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              if (userdata.data[index].layout ==
                                                  "RectangularCard") {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      100,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          userdata.data[index]
                                                              .title,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: text,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        GridView(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      3,
                                                                  crossAxisSpacing:
                                                                      5,
                                                                  mainAxisSpacing:
                                                                      5,
                                                                  mainAxisExtent:
                                                                      165),
                                                          children: [
                                                            for (int i = 0;
                                                                i <
                                                                    userdata
                                                                        .data[
                                                                            index]
                                                                        .cards
                                                                        .length;
                                                                i++)
                                                              Column(
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => service_provider_list(
                                                                                    search_value: userdata.data![index].cards![i].header??"",
                                                                                userid:
                                                                              applicationBloc.userid!,

                                                                                  )));
                                                                    },
                                                                    child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                              height: 100,
                                                                              width: 100,
                                                                              decoration: BoxDecoration(
                                                                                color: bluelight,
                                                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                                                              ),
                                                                              child: Image.network(userdata.data[index].cards[i].bannerImage ?? "",fit: BoxFit.fill,)),
                                                                          Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  userdata.data[index].cards[i].title,
                                                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11, color: darkgrey),
                                                                                ),
                                                                                Text(
                                                                                  userdata.data[index].cards[i].header,
                                                                                  style: TextStyle(fontWeight: FontWeight.w600, color: text, fontSize: 11),
                                                                                ),
                                                                              ],
                                                                            ),

                                                                        ],
                                                                      ),

                                                                  )
                                                                ],
                                                              ),
                                                            if (userdata
                                                                .data[index]
                                                                .viewMore)
                                                              InkWell(
                                                                onTap: () {
                                                                  showModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      enableDrag:
                                                                          true,
                                                                      isScrollControlled:
                                                                          true,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.vertical(
                                                                          top: Radius.circular(
                                                                              20),
                                                                        ),
                                                                      ),
                                                                      builder:
                                                                          (builder) {
                                                                        return new Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.9,
                                                                            child: DraggableScrollableSheet(
                                                                                initialChildSize: 1,
                                                                                builder: (_, controller) {
                                                                                  return SingleChildScrollView(
                                                                                      child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      FutureBuilder<disease_speciality_model>(
                                                                                          future: disease(),
                                                                                          builder: (BuildContext context, snapshot) {
                                                                                            if (snapshot.hasData) {
                                                                                              final userdata = snapshot.data;
                                                                                              return Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.all(15),
                                                                                                    child: Text(
                                                                                                      "Select a disease",
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
                                                                                                                          userdata!.data![index]!.imagePath!,
                                                                                                                          height: 30,
                                                                                                                          width: 40,
                                                                                                                        ),
                                                                                                                        SizedBox(width: 10),
                                                                                                                        Text(
                                                                                                                          userdata!.data![index]!.title.toString(),
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

                                                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>Homecare_services()));
                                                                },
                                                                // child: Column(
                                                                //   crossAxisAlignment:
                                                                //       CrossAxisAlignment
                                                                //           .center,
                                                                //   mainAxisAlignment:
                                                                //       MainAxisAlignment
                                                                //           .start,
                                                                //   children: [
                                                                //     SizedBox(
                                                                //       height:
                                                                //           15,
                                                                //     ),
                                                                //     // CircleAvatar(
                                                                //     //   radius:
                                                                //     //       35,
                                                                //     //   backgroundColor:
                                                                //     //       teal,
                                                                //     //   child: Image
                                                                //     //       .asset(
                                                                //     //           "asset/images/arrowupr.png"),
                                                                //     // ),
                                                                //     // SizedBox(
                                                                //     //   height:
                                                                //     //       15,
                                                                //     // ),
                                                                //     // Text(
                                                                //     //   "See all",
                                                                //     //   style: TextStyle(
                                                                //     //       fontWeight: FontWeight
                                                                //     //           .w500,
                                                                //     //       color:
                                                                //     //           teal,
                                                                //     //       fontSize:
                                                                //     //           14),
                                                                //     // ),
                                                                //   ],
                                                                // ),
                                                              ),
                                                          ],
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          shrinkWrap: true,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                              else if (userdata
                                                      .data[index].layout ==
                                                  "Banner") {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  color: greenlight,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          width: 200,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.network(
                                                                userdata
                                                                        .data[
                                                                            index]
                                                                        .cards[
                                                                            0]
                                                                        .bannerImage ??
                                                                    "",
                                                                height: 100,
                                                              )
                                                            ],
                                                          )),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 25,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Text(
                                                              userdata
                                                                  .data[index]
                                                                  .cards[0]
                                                                  .header,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: text,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Center(
                                                            child:
                                                                MaterialButton(
                                                                    color:
                                                                        buttoncolor,
                                                                    elevation:
                                                                        0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      side: BorderSide(
                                                                          color:
                                                                              buttoncolor,
                                                                          width:
                                                                              1),
                                                                    ),

                                                                    //  minWidth: MediaQuery.of(context).size.width*0.10,
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            8,
                                                                        horizontal:
                                                                            22),
                                                                    child: Text(
                                                                      "Book now",
                                                                      style: TextStyle(
                                                                          color:
                                                                              pwhite,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>otp()));
                                                                    }),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              } else if (userdata
                                                      .data[index].layout ==
                                                  "CircularCard") {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      100,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          userdata.data[index]
                                                              .title,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: text,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        GridView(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      3,
                                                                  crossAxisSpacing:
                                                                      5,
                                                                  mainAxisSpacing:
                                                                      5,
                                                                  mainAxisExtent:
                                                                      120),
                                                          children: [
                                                            for (int i = 0;
                                                                i <
                                                                    userdata
                                                                        .data[
                                                                            index]
                                                                        .cards
                                                                        .length;
                                                                i++)
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => service_provider_list(
                                                                                search_value: userdata.data[index].cards[i].header,
                                                                                userid: applicationBloc.userid,
                                                                              )));
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    ClipOval(
                                                                      child: SizedBox.fromSize(
                                                                        size: Size.fromRadius(40), // Image radius
                                                                        child: Image.network(userdata.data[index].cards[i].bannerImage ?? "", fit: BoxFit.cover),
                                                                      ),
                                                                    ),

                                                                    SizedBox(height:5),
                                                                    Text(
                                                                      userdata
                                                                          .data[
                                                                              index]
                                                                          .cards[
                                                                              i]
                                                                          .header,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              text,
                                                                          fontSize:
                                                                              11),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            if (userdata
                                                                .data[index]
                                                                .viewMore)
                                                              InkWell(
                                                                onTap: () {
                                                                  showModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      enableDrag:
                                                                          true,
                                                                      isScrollControlled:
                                                                          true,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.vertical(
                                                                          top: Radius.circular(
                                                                              20),
                                                                        ),
                                                                      ),
                                                                      builder:
                                                                          (builder) {
                                                                        return new Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.9,
                                                                            child: DraggableScrollableSheet(
                                                                                initialChildSize: 1,
                                                                                builder: (_, controller) {
                                                                                  return SingleChildScrollView(
                                                                                      child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
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

                                                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>Homecare_services()));
                                                                },
                                                                // child: Column(
                                                                //   crossAxisAlignment:
                                                                //       CrossAxisAlignment
                                                                //           .center,
                                                                //   mainAxisAlignment:
                                                                //       MainAxisAlignment
                                                                //           .start,
                                                                //   children: [
                                                                //
                                                                //     // CircleAvatar(
                                                                //     //   radius:
                                                                //     //       35,
                                                                //     //   backgroundColor:
                                                                //     //       teal,
                                                                //     //   child: Image
                                                                //     //       .asset(
                                                                //     //           "asset/images/arrowupr.png"),
                                                                //     // ),
                                                                //     // SizedBox(
                                                                //     //   height:
                                                                //     //       15,
                                                                //     // ),
                                                                //     // Text(
                                                                //     //   "See all",
                                                                //     //   style: TextStyle(
                                                                //     //       fontWeight: FontWeight
                                                                //     //           .w500,
                                                                //     //       color:
                                                                //     //           teal,
                                                                //     //       fontSize:
                                                                //     //           11),
                                                                //     // ),
                                                                //   ],
                                                                // ),
                                                              ),
                                                          ],
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          shrinkWrap: true,
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
                                  return Center(
                                      child: CircularProgressIndicator());
                                }),
                            // SizedBox(
                            //   height: 20,
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
                if (applicationBloc.searchDoctorModel != null &&
                    applicationBloc.searchDoctorModel!.data!.length != 0 &&
                    _controller.text.length > 0)
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 15, top: 0),
                      child: Container(
                        height: 300.0,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.18),
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
                            itemCount:
                                applicationBloc.searchDoctorModel!.data!.length,
                            itemBuilder: (context, index) {
                              return Ink(
                                 // color: Colors.lightGreen,
                                  child: ListTile(
                                    title: Text(
                                      applicationBloc.searchDoctorModel!
                                          .data![index].name!,

                                      style: TextStyle(color: Colors.black),
                                    ),

                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  service_provider_profile(
                                                    user_id: applicationBloc
                                                        .searchDoctorModel!
                                                        .data![index]
                                                        .id
                                                        .toString(),
                                                  )));
                                      setState(() {});
                                    },
                                  ),
                              );
                            }),
                      )),
              ])
            : LinearProgressIndicator());
  }
}
