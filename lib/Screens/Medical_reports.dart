import 'dart:io';

import 'package:fasttrack/Screens/drawer.dart';
import 'package:fasttrack/Screens/upload_medicalreport_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/delete_medicalreport_class.dart';
import '../api/medical_reportclass.dart';
import '../api/upload_medicalreport_class.dart';
import '../models/delete_medicalreport_model.dart';
import '../models/medical_reportmodel.dart';
import '../models/upload_medicalreport_model.dart';
import '../style.dart';

class medical_reports extends StatefulWidget {
  const medical_reports({Key? key}) : super(key: key);

  @override
  _medical_reportsState createState() => _medical_reportsState();
}

class _medical_reportsState extends State<medical_reports> {


  File? file;
  String networkurl = '';

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  void loaddata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      // _controller1.text = pref.getString('name')!;
      // _controller2.text = pref.getString('email')!;
      // _controller3.text = pref.getString('phone')!;
      if (pref.getString("profilepic") != null) {
        networkurl = pref.getString("profilepic")!;
        print('demo $file');
      }
    });
  }

  Future getImageGallery() async {
    var image = await ImagePicker.platform
        .getImage(source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      file = File(image!.path);
      print('Image Path $file');
    });
  }

  Future getImageCamera() async {
    var image = await ImagePicker.platform
        .getImage(source: ImageSource.camera, imageQuality: 25);

    setState(() {
      file = File(image!.path);
      print('Image Path $file');
    });
  }

  Future openCameraPopup(BuildContext context) async {
    showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.bottomCenter,
          insetPadding: EdgeInsets.all(0),
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
              height: 150,
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: border,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  FloatingActionButton(
                                    backgroundColor: Colors.black,
                                    onPressed: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      String msg = '';
                                      await getImageGallery();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FutureBuilder<
                                                    Upload_medicalreport>(
                                                future: Upload(file!.path,
                                                    "medical_report"),
                                                builder: (BuildContext context,
                                                    snapshot) {
                                                  if (snapshot.hasData) {
                                                    final userdata =
                                                        snapshot.data;

                                                    if (userdata!.success ==
                                                        true) {
                                                      return medical_reports();
                                                    } else {
                                                      msg = userdata.message
                                                          .toString();
                                                    }
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text(
                                                        "${snapshot.error}");
                                                  }
                                                  return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      color: white,
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            LinearProgressIndicator(
                                                              backgroundColor:
                                                                  buttoncolor,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation(
                                                                      white),
                                                              minHeight: 5,
                                                            )
                                                          ]));
                                                })),
                                      );
                                      await Future.delayed(
                                          Duration(seconds: 2));
                                      if (msg != '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(msg),
                                        ));
                                      }
                                    },
                                    tooltip: "Pick Image form gallery",
                                    child: Icon(Icons.photo),
                                  ),
                                  SizedBox(height: 5),
                                  Text('Gallery',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              Column(
                                children: [
                                  FloatingActionButton(
                                    backgroundColor: Colors.black,
                                    onPressed: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      String msg = '';
                                      await getImageCamera();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FutureBuilder<
                                                    Upload_medicalreport>(
                                                future: Upload(file!.path,
                                                    "medical_report"),
                                                builder: (BuildContext context,
                                                    snapshot) {
                                                  if (snapshot.hasData) {
                                                    final userdata =
                                                        snapshot.data;

                                                    if (userdata!.success ==
                                                        true) {
                                                      return medical_reports();
                                                    } else {
                                                      msg = userdata.message
                                                          .toString();
                                                    }
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text(
                                                        "${snapshot.error}");
                                                  }
                                                  return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      color: white,
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            LinearProgressIndicator(
                                                              backgroundColor:
                                                                  buttoncolor,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation(
                                                                      white),
                                                              minHeight: 5,
                                                            )
                                                          ]));
                                                })),
                                      );

                                      await Future.delayed(
                                          Duration(seconds: 2));
                                      if (msg != '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(msg),
                                        ));
                                      }
                                    },
                                    tooltip: "Pick Image from camera",
                                    child: Icon(Icons.camera_alt),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Camera',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ))
                ],
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    late String day;
    late String month;
    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    var formattermonth = new DateFormat('MMMM');
    var formatterday = new DateFormat('EEE');

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: teal,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>drawer()));
                }),
          ),
          title: Text('Medical Report', style: TextBold),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  color: slider,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: buttoncolor, width: 0.5)),
                  child: Text(
                    "Upload record",
                    style: TextStyle(color: hinttext, fontSize: 15),
                  ),
                  onPressed: ()  {
                    //openCameraPopup(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  medicalreport_form()));


                  },
                ),
              ],
            ),
          ),
          FutureBuilder<medical_reportmodel>(
              future: medical_reportC(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  final userdata = snapshot.data;
                  return Column(
                    children: [


                      // Text(
                      //   DateFormat("yyyy").format(
                      //       DateTime.parse(
                      //           userdata!
                      //               .data![
                      //           i]!
                      //               .reportDate!))??'',
                      //   style: TextStyle(
                      //       color: teal,
                      //       fontWeight: FontWeight.w500,
                      //       fontSize: 16),
                      // ),
                     
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.data?.length,
                          itemBuilder: (BuildContext context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DateFormat("yyyy").format(
                                            DateTime.parse(
                                                userdata!
                                                    .data![
                                                index]!
                                                    .reportDate!))??'',
                                        style: TextStyle(
                                            color: teal,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                     // for(int i=0;i<userdata!.data!.length;i++)
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                100,
                                            margin: EdgeInsets.only(bottom: 15),
                                            decoration: BoxDecoration(
                                                color: lightcolorblue,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Container(
                                                    height: 50,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.27,
                                                    decoration: BoxDecoration(
                                                        color: pwhite,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          DateFormat("dd").format(
                                                              DateTime.parse(
                                                                  userdata!
                                                                      .data![
                                                                          index]!
                                                                      .reportDate!))??'',
                                                          style: TextStyle(
                                                              color: text,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          DateFormat("MMM")
                                                              .format(DateTime
                                                                  .parse(userdata!
                                                                      .data![
                                                                          index].reportDate!))??'',
                                                          style: TextStyle(
                                                              color: greyc,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: MediaQuery.of(context).size.width*0.4,
                            child:Text(
                                                        userdata!
                                                            .data![index]!
                                                            .doctorName??'',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: text,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(width: MediaQuery.of(context).size.width*0.4,
                                                      child: Text(
                                                       ( userdata!
                                                            .data![index]!
                                                            .specialization??'').toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: greyc,
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width*0.1,

                                               child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          new AlertDialog(
                                                        title:
                                                            new Text('Message'),
                                                        content: Text(
                                                            'Are you sure, do you want to delete?'),
                                                        actions: <Widget>[
                                                          new MaterialButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context,
                                                                      rootNavigator:
                                                                          true)
                                                                  .pop(); // dismisses only the dialog and returns nothing
                                                            },
                                                            child: new Text(
                                                                'Cancel'),
                                                          ),
                                                          new MaterialButton(
                                                            onPressed: () {
                                                              String msg = '';
                                                              Navigator.pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => FutureBuilder<medicalreportdeletemodel>(
                                                                          future: medicalreportdeleteC(userdata!.data![index]!.id!),
                                                                          builder: (BuildContext context, snapshot) {
                                                                            if (snapshot.hasData) {
                                                                              final userdata = snapshot.data;

                                                                              if (userdata?.success == true) {
                                                                                return medical_reports();
                                                                              } else {
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                                                                              }
                                                                            } else if (snapshot.hasError) {
                                                                              return Text("${snapshot.error}");
                                                                            }
                                                                            return Container(
                                                                                height: MediaQuery.of(context)
                                                                                    .size
                                                                                    .height,
                                                                                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                  Center(child: CircularProgressIndicator())
                                                                                ]));
                                                                          })));
                                                              // dismisses only the dialog and returns nothing
                                                            },
                                                            child:
                                                                Text("Delete"),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0,
                                                            bottom: 30),
                                                    child: Image(
                                                        image: AssetImage(
                                                            "asset/images/point.png")),
                                                  ),
                                                ) ),
                                              ],
                                            )),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                      Divider(
                        color: hinttext,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(
                  child: LinearProgressIndicator(),
                );
              })
        ]))

        // Divider(
        //
        //   color: hinttext,
        //
        // )

        );
  }
}
