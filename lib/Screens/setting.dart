import 'dart:io';

import 'package:fasttrack/Screens/Faqs.dart';
import 'package:fasttrack/Screens/login.dart';
import 'package:fasttrack/Screens/logout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/settingdeleteclass.dart';
import '../models/settingdeletemodel.dart';
import '../style.dart';

class setting extends StatefulWidget {
  const setting({Key? key}) : super(key: key);

  @override
  _settingState createState() => _settingState();
}

class _settingState extends State<setting> {
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
        title: Text('Settings', style: TextBold),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "About Fastrack",
                style: Textnormal2,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Privacy policy",
                style: Textnormal2,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Help & support",
                style: Textnormal2,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Share with friends & families",
                style: Textnormal2,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Rate feedback",
                style: Textnormal2,
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                  onTap: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    showDialog(
                      context: context,
                      builder: (context) => new AlertDialog(
                        title: new Text('Message'),
                        content: Text('Are you sure, do you want to delete?'),
                        actions: <Widget>[
                          new MaterialButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(); // dismisses only the dialog and returns nothing
                            },
                            child: new Text('Cancel'),
                          ),
                          new MaterialButton(
                            onPressed: () {
                              String msg = '';
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FutureBuilder<
                                              settingdeletedmodel>(
                                          future: deleteUsers(),
                                          builder:
                                              (BuildContext context, snapshot) {
                                            if (snapshot.hasData) {
                                              final userdata = snapshot.data;

                                              if (userdata?.success == true) {
                                                pref.clear();
                                                return login();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(msg)));
                                                pref.clear();
                                                return login();
                                              }
                                            } else if (snapshot.hasError) {
                                              return Text("${snapshot.error}");
                                            }
                                            return Container(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                          child:
                                                              CircularProgressIndicator())
                                                    ]));
                                          })));
                              // dismisses only the dialog and returns nothing
                            },
                            child: Text("Delete"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    "Delete account",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: cancelred),
                  )),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
