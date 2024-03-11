import 'dart:io';

import 'package:fasttrack/Screens/home.dart';
import 'package:fasttrack/Screens/login.dart';
import 'package:fasttrack/models/update_model.dart';
import 'package:fasttrack/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/onboarding.dart';
import '../api/update_class.dart';
import '../api/upload_medicalreport_class.dart';
import '../blocs/application_bloc.dart';
import '../models/updateprofile.dart';
import '../models/upload_medicalreport_model.dart';
import '../others/bottomnavbar.dart';

// Name - Ruchika Nawghare
// Start Date - 14-06-2022
// Modify Date -
// This is profile page of user

// Name - Kundan
// Start Date - 15-06-2022
// Modify Date - 15-06-2022
// This is profile page of user

class Inner_profile extends StatefulWidget {
  const Inner_profile({Key? key}) : super(key: key);

  @override
  _Inner_profileState createState() => _Inner_profileState();
}

class _Inner_profileState extends State<Inner_profile> {
  final TextEditingController _bgcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  File file=File('');
  String networkurl = '';
  int userid = 0;
  String mobile = "0";
  String chosebg = 'Select';
  List<String> bloodgroup = [
    'Select',
    'A+',
    'B+',
    'AB+',
    'O+',
    'A-',
    'B-',
    'AB-',
    'O-'
  ];
  UpdateProfileModel? updateProfileModel;
  @override
  void initState() {
    load();
    loadUser();
    super.initState();
  }

  void load() async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    await applicationBloc.userProfile();

    setState(() {
      _namecontroller.text = applicationBloc.name;
      _emailcontroller.text = applicationBloc.email;
      if (applicationBloc.bloodgroup != null &&
          applicationBloc.bloodgroup != "")
        chosebg = applicationBloc.bloodgroup!;
    });
  }

  void loadUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      if (pref.getInt("user_id") != null) userid = pref.getInt("user_id")!;
      if (pref.getString("mobile") != null) mobile = pref.getString("mobile")!;
      if (pref.getString("profilepic") != null) {
        networkurl = pref.getString("profilepic")!;
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
                                      String msg='';
                                      await getImageGallery();
                                      if (file.path != null && file.path != '') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FutureBuilder<
                                                  Upload_medicalreport>(
                                                  future: Upload(file.path, "profile"),
                                                  builder:
                                                      (BuildContext context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      final userdata = snapshot.data;

                                                      if (userdata!.success == true) {
                                                        msg = userdata!.message.toString();
                                                        return FutureBuilder<
                                                            Update_model>(
                                                            future: updateC(userdata!.data!.filePath!),
                                                            builder: (BuildContext context,
                                                                snapshot) {
                                                              if (snapshot.hasData) {
                                                                final userdata =
                                                                    snapshot.data;
                                                                if (userdata!.success ==
                                                                    true) {
                                                                  return bottomnavvar();
                                                                } else {
                                                                  msg = userdata!.message!;
                                                                  return Inner_profile();
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
                                                                              Colors
                                                                                  .white),
                                                                          minHeight: 5,
                                                                        )
                                                                      ]));
                                                            });
                                                      } else {
                                                        msg = userdata.message.toString();
                                                        return Inner_profile();
                                                      }
                                                    } else if (snapshot.hasError) {
                                                      return Text("${snapshot.error}");
                                                    }
                                                    return Container(
                                                        height: MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                        color: white,
                                                        child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
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
                                      String msg='';
                                      await getImageCamera();
                                      if (file.path != null && file.path != '') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FutureBuilder<
                                                  Upload_medicalreport>(
                                                  future: Upload(file.path, "profile"),
                                                  builder:
                                                      (BuildContext context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      final userdata = snapshot.data;

                                                      if (userdata!.success == true) {
                                                        msg = userdata!.message.toString();
                                                        return FutureBuilder<
                                                            Update_model>(
                                                            future: updateC(userdata!.data!.filePath!),
                                                            builder: (BuildContext context,
                                                                snapshot) {
                                                              if (snapshot.hasData) {
                                                                final userdata =
                                                                    snapshot.data;
                                                                if (userdata!.success ==
                                                                    true) {
                                                                  return bottomnavvar();
                                                                } else {
                                                                  msg = userdata!.message!;
                                                                  return Inner_profile();
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
                                                                              Colors
                                                                                  .white),
                                                                          minHeight: 5,
                                                                        )
                                                                      ]));
                                                            });
                                                      } else {
                                                        msg = userdata.message.toString();
                                                        return Inner_profile();
                                                      }
                                                    } else if (snapshot.hasError) {
                                                      return Text("${snapshot.error}");
                                                    }
                                                    return Container(
                                                        height: MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                        color: white,
                                                        child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
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

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.27,
            width: MediaQuery.of(context).size.width * 100,
            child: Container(
                width: double.infinity,
                height: 200.0,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: pwhite,
                    radius: 60,
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(60),
                      child: Stack(children: [
                        file!.path != '' ||
                                (networkurl != '' && networkurl != null)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: file.path != '' && file.path != null
                                    ? Image.file(
                                        file,
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        networkurl,
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ))
                            : Image.asset(
                                "asset/images/man.png",
                              ),
                        InkWell(
                            onTap: () async {
                              openCameraPopup(context);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: 0,
                                ),
                                child: FractionalTranslation(
                                    translation: Offset(0.0, 0.1),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: CircleAvatar(
                                          backgroundColor: buttoncolor,
                                          radius: 15,
                                          child: Container(
                                              child: SvgPicture.asset(
                                            "asset/images/camera2.svg",
                                            width: 15,
                                          ))),
                                    )))),
                      ]),
                    ),
                  ),
                )),
          ),
          Container(
              child: Padding(
            padding: const EdgeInsets.only(top: 30, right: 15, left: 15),
            child: Column(
              children: [
                TextFormField(
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(color: hinttext, fontSize: 16),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: hinttext),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: hinttext),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: hinttext),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                    hintText: "Email Id",
                    hintStyle: TextStyle(color: hinttext, fontSize: 16),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: hinttext),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: hinttext),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: hinttext),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                DropdownButtonFormField<String>(
                  focusColor: Colors.white,
                  value: chosebg,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: hinttext),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: hinttext),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: hinttext),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  iconEnabledColor: hinttext,
                  items:
                      bloodgroup.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text(
                    "Blood Group",
                    style: TextStyle(color: hinttext, fontSize: 16),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      chosebg = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Material(
                  color: buttoncolor,
                  borderRadius: BorderRadius.circular(50.0),
                  elevation: 0,
                  child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            color: pwhite,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      onPressed: () {
                        String msg = '';

                        String email = validateEmail(_emailcontroller.text);
                        if (_namecontroller.text.length <= 0) {
                          msg = "Please enter your name";
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(msg),
                          ));
                        } else if (email != "null") {
                          msg = validateEmail(_emailcontroller.text);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(msg),
                          ));
                        } else {
                          applicationBloc.updateProfileFun(
                              userid,
                              _namecontroller.text,
                              _emailcontroller.text,
                              mobile,
                              chosebg);
                          updateProfileModel =
                          applicationBloc.updateProfileModel!;

                          if (updateProfileModel != null) {

                            if (updateProfileModel!.success!)
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Profile successfully updated!"),
                              ));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        bottomnavvar(index: 0)));
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(updateProfileModel!.message!),
                            ));
                          }

                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => FutureBuilder<
                          //               UpdateProfileModel>(
                          //           future: updateuser(
                          //                userid,
                          //               _namecontroller.text,
                          //               _emailcontroller.text,
                          //                mobile,
                          //                chosebg),
                          //           builder: (BuildContext context, snapshot) {
                          //             if (snapshot.hasData) {
                          //               final userdata = snapshot.data;
                          //               if (userdata!.success == true) {
                          //                 msg = userdata!.message!;
                          //                 return bottomnavvar();
                          //               } else {
                          //                 msg = userdata!.message!;
                          //                 return profile();
                          //               }
                          //             } else if (snapshot.hasError) {
                          //               return Text("${snapshot.error}");
                          //             }
                          //
                          //             return Container(
                          //                 height: MediaQuery.of(context)
                          //                     .size
                          //                     .height,
                          //                 color: white,
                          //                 child: Column(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.start,
                          //                     children: [
                          //                       LinearProgressIndicator(
                          //                         backgroundColor: buttoncolor,
                          //                         valueColor:
                          //                             AlwaysStoppedAnimation(
                          //                                 Colors.white),
                          //                         minHeight: 5,
                          //                       )
                          //                     ]));
                          //           })),
                          // );
                        }
                      }),
                )
              ],
            ),
          ))
        ],
      )),
    );
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length > 0 && !regExp.hasMatch(value)) {
      return 'Please enter valid email address';
    } else
      return "null";
  }
}
