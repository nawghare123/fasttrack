import 'package:fasttrack/Screens/Faqs.dart';
import 'package:fasttrack/Screens/Help_support.dart';
import 'package:fasttrack/Screens/Payment_history.dart';
import 'package:fasttrack/Screens/profile.dart';
import 'package:fasttrack/Screens/setting.dart';
import 'package:fasttrack/api/Active_bookingclass.dart';
import 'package:fasttrack/api/faqclass.dart';
import 'package:fasttrack/api/usereprofileclass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../blocs/application_bloc.dart';
import '../style.dart';
import 'Feedback_query.dart';
import 'Medical_history.dart';
import 'Medical_reports.dart';
import 'My_active_booking.dart';
import 'My_completed_bookings.dart';
import 'logout.dart';
import 'medical_his_notes.dart';

class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.userProfile();


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      body: Drawer(
        child:
            //padding: EdgeInsets.zero,
            WillPopScope(
                onWillPop: () async => false,
                child: Drawer(
                    child: Container(
                  //  color:teal,
                  child: ListView(
                      // Important: Remove any padding from the ListView.
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        SizedBox(
                          height: 170,
                          child: DrawerHeader(
                            decoration: BoxDecoration(color: teal),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: pwhite,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipOval(
                                                    child: SizedBox(
                                                        height: 40,
                                                        width: 40,
                                                        child: (
                                                            applicationBloc
                                                                    .profilepic != null && applicationBloc.profilepic != "")
                                                            ? Image.network(
                                                                (applicationBloc
                                                                            .profilepic??
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
                                                  SizedBox(width: 15),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          (applicationBloc
                                                                      .name ??
                                                                  "")
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: pwhite),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          (applicationBloc
                                                                      .mobile ??
                                                                  "")
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: pwhite),
                                                        ),
                                                      ]),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              medical_history(

                                                                  //style: TextStyle(color: pwhite),

                                                                  )));
                                                },
                                                child: Text(
                                                  "Edit",
                                                  style:
                                                      TextStyle(color: pwhite),
                                                ),
                                              )
                                            ]),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Image.asset('asset/images/completeicon.png'),
                          title: Text('Completed bookings',
                              style: TextStyle(fontSize: 14, color: text)),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: hinttext,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        my_completed_bookings()));
                          },
                        ),
                        ListTile(
                          leading: Image.asset('asset/images/feedbackicon.png'),
                          title: Text('Active bookings',
                              style: TextStyle(fontSize: 14, color: text)),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: hinttext,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => My_active_booking()));
                          },
                        ),
                        ListTile(
                          leading: Image.asset('asset/images/bookingheart.png'),
                          title: Text('My medical report',
                              style: TextStyle(fontSize: 14, color: text)),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: hinttext,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => medical_reports()));
                          },
                        ),
                        // ListTile(
                        //   leading: Image.asset('asset/images/bookingheart.png'),
                        //   title: Text(' Medical history',
                        //       style: TextStyle(fontSize: 14, color: text)),
                        //   trailing: Icon(Icons.keyboard_arrow_right_outlined,color: hinttext,),
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => medical_history()));
                        //   },
                        // ),
                        ListTile(
                          leading: Image.asset('asset/images/activeicon.png'),
                          title: Text('Feedback & query',
                              style: TextStyle(fontSize: 14, color: text)),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: hinttext,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => feedback_query()));
                          },
                        ),
                        ListTile(
                          leading: Image.asset('asset/images/setting.png'),
                          title: Text('Medical history & Notes',
                              style: TextStyle(fontSize: 14, color: text)),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: hinttext,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => medical_h(
                                          bookingid: 1,
                                        )));
                          },
                        ),
                        ListTile(
                          leading: Image.asset('asset/images/paymenticon.png'),
                          title: Text('Payment history',
                              style: TextStyle(fontSize: 14, color: text)),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: hinttext,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => payment_history()));
                          },
                        ),
                        Container(
                          color: containercolor,
                          height: 10,
                          width: MediaQuery.of(context).size.width,
                        ),
                        ListTile(
                          leading: Image.asset('asset/images/helpSupportIcon.png'),
                          title: Text('Help & support',
                              style: TextStyle(fontSize: 14, color: text)),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: hinttext,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Help_support()));
                          },
                        ),
                        ListTile(
                          leading: Image.asset('asset/images/setting.png'),
                          title: Text('FAQs',
                              style: TextStyle(fontSize: 14, color: text)),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: hinttext,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Faqs()));
                          },
                        ),
                        ListTile(
                          leading: Image.asset('asset/images/setting.png'),
                          title: Text('Settings',
                              style: TextStyle(fontSize: 14, color: text)),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: hinttext,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => setting()));
                          },
                        ),
                        ListTile(
                          leading: Image.asset('asset/images/bothg.png'),
                          title: Text('Partner with fastrack',
                              style: TextStyle(fontSize: 14, color: text)),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: hinttext,
                          ),
                          onTap: () async {
                            String url = "https://v2.fasttrackhealthcare.in/#/partner-with-us";
                            var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                            if(urllaunchable){
                              await launch(url); //launch is from url_launcher package to launch URL
                            } else{
                              print("URL can't be launched.");
                            }
                        },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          tileColor: containercolor,
                          leading: Image.asset('asset/images/logout.png'),
                          title: Text('Logout',
                              style: TextStyle(fontSize: 14, color: teal)),
                          trailing: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: buttoncolor,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => logout()));
                          },
                        ),

                        SizedBox(
                          height: 80,
                        ),
                      ]),
                ))),
      ),
    );
  }
}
