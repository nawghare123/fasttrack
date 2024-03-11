import 'dart:io';

import 'package:fasttrack/api/feedbacks_class.dart';
import 'package:fasttrack/models/feedbacks_model.dart';
import 'package:fasttrack/others/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/upload_medicalreport_class.dart';
import '../models/upload_medicalreport_model.dart';
import '../style.dart';

class feedback_query extends StatefulWidget {
  const feedback_query({Key? key}) : super(key: key);

  @override
  _feedback_queryState createState() => _feedback_queryState();
}


class _feedback_queryState extends State<feedback_query> {
  File? file;
  String networkurl = '';
  String tap = '';
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  String filepath = '';
  String filename = '';
  String type = "";

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
      if (pref.getString("filepath") != null) {
        filepath = pref.getString("filepath")!;
      }
    });
  }

  Future getImageGallery() async {
    var image = await ImagePicker.platform
        .getImage(source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      filename = image!.name;
      file = File(image!.path);
      print('Image Path $file');
    });
  }

  Future getImageCamera() async {
    var image = await ImagePicker.platform
        .getImage(source: ImageSource.camera, imageQuality: 25);

    setState(() {
      filename = image!.name;
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
                                      await getImageGallery();
                                      Navigator.pop(context);
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
                                      await getImageCamera();
                                      Navigator.pop(context);

                                      await Future.delayed(
                                          Duration(seconds: 2));
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
                Navigator.pop(context);
              }),
        ),
        title: Text('Feedback & Query', style: TextBold),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            children: [
                              MaterialButton(
                                  color: type == "feedback"
                                      ? buttoncolor:greenlight,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                          color:
                                              buttoncolor,

                                          width: 0.3)),
                                  child: Text(
                                    "Feedback",
                                    style: TextStyle(
                                        color: type == "feedback"
                                            ?white: buttoncolor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (type == "feedback")
                                        type = '';
                                      else
                                        type = 'feedback';
                                    });
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              MaterialButton(
                                  color: type == "query"
                                      ? buttoncolor:greenlight,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                          color:   buttoncolor, width: 0.3)),
                                  child: Text(
                                    "Query",
                                    style: TextStyle(
                                        color:  type == "query"
                                            ?white: buttoncolor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (type == "query")
                                        type = '';
                                      else
                                        type = "query";
                                    });
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              MaterialButton(
                                  color:  type == "performance"
                                      ? buttoncolor:greenlight
                                     ,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                          color: buttoncolor, width: 0.3)),
                                  child: Text(
                                    "Performance",
                                    style: TextStyle(
                                        color:  type == "performance"
                                            ?white: buttoncolor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (type == "performance")
                                        type = '';
                                      else
                                        type = "performance";
                                    });
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Summery",
                            style: TextStyle(color: text, fontSize: 14),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          TextFormField(
                            controller: _controller,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            minLines: 1,
                            maxLines: 10,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyc, width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: greyc, width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Explain in details",
                            style: TextStyle(color: text, fontSize: 14),
                          ),

                          SizedBox(
                            height: 25,
                          ),

                          TextField(
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              minLines: 1,
                              maxLines: 10,
                              controller: _controller1,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: greyc, width: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: greyc, width: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),

                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              MaterialButton(
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 17, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                          color: buttoncolor, width: 0.8)),
                                  child: Text(
                                    "Choose file",
                                    style: TextStyle(
                                        color: buttoncolor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onPressed: () {
                                    openCameraPopup(context);
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width: 170,
                                  child: Text(
                                    filename,
                                  )),
                            ],
                          ),
                          // if()
                          //
                          // Text("Successfully uploaded",style: TextStyle(color: red,fontWeight: FontWeight.w500,fontSize: 14),),

                          SizedBox(
                            height: 50,
                          ),

                          MaterialButton(
                              color: buttoncolor,
                              elevation: 0,
                              minWidth: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                vertical: 13,
                              ),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: pwhite,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              onPressed: () async {
                                String msg = '';

                                SharedPreferences pref =
                                await SharedPreferences.getInstance();
                                if (_controller.text.length <= 0) {
                                  msg = 'Please enter summery';
                                }else if(_controller1.text.length<=0){
                                  msg ='Please enter details';
                                }

                                else {
                                  if (file!.path != null && file!.path != '') {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FutureBuilder<
                                                  Upload_medicalreport>(
                                              future: Upload(
                                                  file!.path, "feedback"),
                                              builder: (BuildContext context,
                                                  snapshot) {
                                                if (snapshot.hasData) {
                                                  final userdata =
                                                      snapshot.data;

                                                  if (userdata!.success ==
                                                      true) {
                                                    msg = userdata!.message
                                                        .toString();
                                                    return FutureBuilder<
                                                            feedbacks_model>(
                                                        future: feedbacksC(
                                                            type,
                                                            _controller.text,
                                                            _controller1.text,
                                                            userdata!.data!
                                                                .filePath!),
                                                        builder: (BuildContext
                                                                context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            final userdata =
                                                                snapshot.data;
                                                            if (userdata
                                                                    ?.success ==
                                                                true) {
                                                              msg = userdata!
                                                                  .message
                                                                  .toString();
                                                              return bottomnavvar(
                                                                index: 0,
                                                              );
                                                            } else {
                                                              msg = userdata!
                                                                  .message
                                                                  .toString();
                                                              return feedback_query();
                                                            }
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                "${snapshot.error}");
                                                          }
                                                          return Container(
                                                              height:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height,
                                                              // color: white,
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.center,
                                                                  children: [
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator())
                                                                  ]));
                                                        });
                                                  } else {
                                                    msg = userdata.message
                                                        .toString();
                                                    return feedback_query();
                                                  }
                                                } else if (snapshot.hasError) {
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
                                  }
                                 else if (file!.path != null && file!.path != '') {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FutureBuilder<
                                              Upload_medicalreport>(
                                              future: Upload(
                                                  file!.path, "query"),
                                              builder: (BuildContext context,
                                                  snapshot) {
                                                if (snapshot.hasData) {
                                                  final userdata =
                                                      snapshot.data;

                                                  if (userdata!.success ==
                                                      true) {
                                                    msg = userdata!.message
                                                        .toString();
                                                    return FutureBuilder<
                                                        feedbacks_model>(
                                                        future: feedbacksC(
                                                            type,
                                                            _controller.text,
                                                            _controller1.text,
                                                            userdata!.data!
                                                                .filePath!),
                                                        builder: (BuildContext
                                                        context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            final userdata =
                                                                snapshot.data;
                                                            if (userdata
                                                                ?.success ==
                                                                true) {
                                                              msg = userdata!
                                                                  .message
                                                                  .toString();
                                                              return bottomnavvar(
                                                                index: 0,
                                                              );
                                                            } else {
                                                              msg = userdata!
                                                                  .message
                                                                  .toString();
                                                              return feedback_query();
                                                            }
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                "${snapshot.error}");
                                                          }
                                                          return Container(
                                                              height:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height,
                                                              // color: white,
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: [
                                                                    Center(
                                                                        child:
                                                                        CircularProgressIndicator())
                                                                  ]));
                                                        });
                                                  } else {
                                                    msg = userdata.message
                                                        .toString();
                                                    return feedback_query();
                                                  }
                                                } else if (snapshot.hasError) {
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
                                  }
                                  else if (file!.path != null && file!.path != '') {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FutureBuilder<
                                              Upload_medicalreport>(
                                              future: Upload(
                                                  file!.path, "performance"),
                                              builder: (BuildContext context,
                                                  snapshot) {
                                                if (snapshot.hasData) {
                                                  final userdata =
                                                      snapshot.data;

                                                  if (userdata!.success ==
                                                      true) {
                                                    msg = userdata!.message
                                                        .toString();
                                                    return FutureBuilder<
                                                        feedbacks_model>(
                                                        future: feedbacksC(
                                                            type,
                                                            _controller.text,
                                                            _controller1.text,
                                                            userdata!.data!
                                                                .filePath!),
                                                        builder: (BuildContext
                                                        context,
                                                            snapshot) {
                                                          if (snapshot.hasData) {
                                                            final userdata = snapshot.data;
                                                            if (userdata?.success == true) {
                                                              msg = userdata!.message.toString();
                                                              return bottomnavvar(
                                                                index: 0,
                                                              );
                                                            } else {
                                                              msg = userdata!
                                                                  .message
                                                                  .toString();
                                                              return feedback_query();
                                                            }
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                "${snapshot.error}");
                                                          }
                                                          return Container(
                                                              height:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height,
                                                              // color: white,
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: [
                                                                    Center(
                                                                        child:
                                                                        CircularProgressIndicator())
                                                                  ]));
                                                        });
                                                  } else {
                                                    msg = userdata.message
                                                        .toString();
                                                    return feedback_query();
                                                  }
                                                } else if (snapshot.hasError) {
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
                                  }
                                  else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FutureBuilder<
                                                  feedbacks_model>(
                                              future: feedbacksC(
                                                  type,
                                                  _controller.text,
                                                  _controller1.text,
                                                  ''),
                                              builder: (BuildContext context,
                                                  snapshot) {
                                                if (snapshot.hasData) {
                                                  final userdata =
                                                      snapshot.data;
                                                  if (userdata?.success ==
                                                      true) {
                                                    return feedback_query();
                                                  }
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      "${snapshot.error}");
                                                }

                                                return Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    // color: white,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator())
                                                        ]));
                                              })),
                                    );
                                  }
                                }

                                await Future.delayed(Duration(seconds: 1));
                                if (msg != '') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(msg),
                                  ));
                                }
                              }

                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
                              ),
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
