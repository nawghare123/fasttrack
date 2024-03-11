import 'package:fasttrack/Screens/home.dart';
import 'package:fasttrack/Screens/login.dart';
import 'package:fasttrack/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/onboarding.dart';
import '../blocs/application_bloc.dart';
import '../models/updateprofile.dart';
import '../others/bottomnavbar.dart';

// Name - Ruchika Nawghare
// Start Date - 14-06-2022
// Modify Date -
// This is profile page of user

// Name - Kundan
// Start Date - 15-06-2022
// Modify Date - 15-06-2022
// This is profile page of user

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _bgcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
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
    loadUser();
    super.initState();
  }

  void loadUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      if (pref.getInt("user_id") != null) userid = pref.getInt("user_id")!;
      if (pref.getString("mobile") != null) mobile = pref.getString("mobile")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            color: buttoncolor,
            height: MediaQuery.of(context).size.height * 0.27,
            width: MediaQuery.of(context).size.width * 100,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                bottom: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Personal Details",
                    style: TextStyle(
                        color: white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
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
                      onPressed: () async {
                        String msg = '';
                       // String name1 = namefeild(_namecontroller.text);
                        String email = validateEmail(_emailcontroller.text);
                        if(_namecontroller.text.trim().length<=0){
                        msg = 'Please enter your name';
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(msg),
                          ));
                        }
                        // else if (name1 != "null") {
                        //   msg = namefeild(_namecontroller.text);
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content: Text(msg),
                        //   ));
                        // }
                        else if (email != "null") {
                          msg = validateEmail(_emailcontroller.text);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(msg),
                          ));
                        } else {
                          await applicationBloc.updateProfileFun(
                              userid,
                              _namecontroller.text.trim(),
                              _emailcontroller.text.trim(),
                              mobile,
                              chosebg);
                              updateProfileModel =
                              applicationBloc.updateProfileModel!;

                          if (updateProfileModel != null) {

                            if (updateProfileModel!.success!) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Profile successfully updated!"),
                                  ));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          bottomnavvar(index: 0)));
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("User already exist with same email"),//updateProfileModel!.message!
                              ));
                            }

                           }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Something went wrong'),
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

  String namefeild(String value) {
    String pattern1= r'/^[a-zA-Z ]+*$/';
    RegExp regExp =  RegExp(pattern1);
    if (value.length > 0 && !regExp.hasMatch(value)) {
      return 'Please enter valid name';
    } else
      return "null";
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
