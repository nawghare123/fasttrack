import 'dart:async';

import 'package:fasttrack/Screens/login.dart';
import 'package:fasttrack/Screens/profile.dart';
import 'package:fasttrack/api/resendOTP_class.dart';
import 'package:fasttrack/models/resendOTP_model.dart';
import 'package:fasttrack/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Name - Ruchika Nawghare
// Start Date - 14-06-2022
// Modify Date -
// Reason to work on page -
import '../api/onboarding.dart';
import '../blocs/application_bloc.dart';
import '../models/otp.dart';
import '../others/bottomnavbar.dart';
import '../others/otpbox.dart';
import 'home.dart';

class otp extends StatefulWidget {
  const otp({Key? key}) : super(key: key);

  @override
  _otpState createState() => _otpState();
}
@override
class _otpState extends State<otp> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  late Timer _timer;
  int _start = 59;
  String firebasetoken = '';
  String deviceid = '';
  var otpcontiner;
  String mobile = '';
  VerifyOtpModal? verifyOTPModel;

  void initState() {
    otpcontiner = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        inputBox(_controller1, true, false),
        inputBox(_controller2, false, false),
        inputBox(_controller3, false, false),
        inputBox(_controller4, false, true),
      ],
    );
    loadmobile();
    //startTimer();
    super.initState();
  }

  void loadmobile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      if (pref.getString('mobile') != null) mobile = pref.getString('mobile')!;

    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Widget inputBox(TextEditingController teOtpDigitOne, bool f, bool l) {
    return otpBox(initVal: teOtpDigitOne, first: f, last: l);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width * 100,
          padding: EdgeInsets.only(top: 150),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Enter the OTP",
                    style: TextStyle(
                        color: buttoncolor,
                        fontWeight: FontWeight.w500,
                        fontSize: 22)),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 0, right: 15),
                  child: Form(
                    child: otpcontiner,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "A 4 digit OTP has been sent on your mobile",
                  style: TextStyle(fontSize: 16, color: hinttext),
                ),
                SizedBox(height: 60),
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
                        SharedPreferences pref =
                        await SharedPreferences.getInstance();

                        if (_controller1.text == "" ||
                            _controller2.text == "" ||
                            _controller3.text == "" ||
                            _controller4.text == "") {
                          msg = "Please enter 4 digit's OTP";
                        }
                        else {
                          await applicationBloc.verifyOTP(
                              _controller1.text +
                                  _controller2.text +
                                  _controller3.text +
                                  _controller4.text,
                              mobile);
                          verifyOTPModel = applicationBloc.verifyOTPModel!;

                          if (verifyOTPModel != null) {
                            if (verifyOTPModel!.success!) {
                              setState(() {
                                pref.setString("token",verifyOTPModel!.data!.token.toString());
                                pref.setInt("user_id", verifyOTPModel!.data!.user!.id!);
                              });

                              if (verifyOTPModel!.data!.user!.completedStep! <= 2) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => profile()));
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => bottomnavvar(
                                              index: 0,
                                            )));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('You have entered wrong OTP'),
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Something went wrong'),
                            ));
                          }
                        }
                        FocusScope.of(context).unfocus();
                        await Future.delayed(Duration(seconds: 1));
                        if (msg != '') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(msg),
                          ));
                        }
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => FutureBuilder<
                        //               VerifyOtpModal>(
                        //           // future: loginotp(
                        //           //     _controller1.text +
                        //           //         _controller2.text +
                        //           //         _controller3.text +
                        //           //         _controller4.text,
                        //           //     mobile),
                        //           builder: (context, snapshot) {
                        //             if (snapshot.hasData) {
                        //               final userdata = snapshot.data;
                        //
                        //               if (userdata!.success == true) {
                        //                 pref.setString("token",
                        //                     userdata.data!.token.toString());
                        //                 pref.setInt("user_id",
                        //                     userdata.data!.user!.id!);
                        //                 if (userdata
                        //                         .data!.user!.completedStep! <=
                        //                     2)
                        //                   return profile();
                        //                 else
                        //                   return bottomnavvar();
                        //               } else {
                        //                 msg = 'You have entered wrong OTP';
                        //                 return otp();
                        //               }
                        //             } else if (snapshot.hasError) {
                        //               return Text("${snapshot.error}");
                        //             }
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
                      }),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Haven't recived any OTP?",
                      style: TextStyle(fontSize: 16, color: hinttext),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () async {
                        String msg = '';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FutureBuilder<resendModel>(

                                      future: resendOTPC(mobile??''),
                                      builder:
                                          (BuildContext context, snapshot) {
                                        if (snapshot.hasData) {
                                          final userdata = snapshot.data;
                                          if (userdata?.success == true) {

                                            msg = userdata!.message.toString();
                                            print("Ruchika");
                                            print(userdata.message.toString());
                                            return otp();
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
                                                MainAxisAlignment.center,
                                                children: [
                                                  Center(child: CircularProgressIndicator())
                                                ]));
                                      })),
                        );
                        // msg = 'OTP Resent';
                        await Future.delayed(Duration(seconds: 2));
                        if (msg != '') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(msg),
                          ));
                        }

                      },

                        child: Container(
                          child: Center(
                            child: Text(
                              'Resend OTP',
                              style: TextStyle(
                                  color: buttoncolor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      //s),


                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

// Navigator.pushReplacement(
//   context,
//   MaterialPageRoute(
//       builder: (context) => FutureBuilder<
//               VerifyOtpModal>(
//           future: loginotp(
//               _controller1.text +
//                   _controller2.text +
//                   _controller3.text +
//                   _controller4.text,
//               mobile),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               final userdata = snapshot.data;
//
//               if (userdata!.success == true) {
//                 pref.setString("token",
//                     userdata.data!.token.toString());
//                 pref.setInt("user_id",
//                     userdata.data!.user!.id!);
//                 if (userdata
//                         .data!.user!.completedStep! <=
//                     2)
//                   return profile();
//                 else
//                   return bottomnavvar();
//               } else {
//                 msg = 'You have entered wrong OTP';
//                 return otp();
//               }
//             } else if (snapshot.hasError) {
//               return Text("${snapshot.error}");
//             }
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
// }
//
// await Future.delayed(Duration(seconds: 1));
// if (msg != '') {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     content: Text(msg),
//   ));
// }
