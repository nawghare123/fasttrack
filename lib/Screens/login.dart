import 'package:fasttrack/others/bottomnavbar.dart';
import 'package:fasttrack/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fasttrack/api/onboarding.dart';
import '../introslider.dart';
import '../models/login.dart';
import 'home.dart';
import 'otp.dart';

// Name - Ruchika Nawghare
// Start Date - 14-06-2022
// Modify Date -
// Reason to work on page -

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController _controller = TextEditingController();
  String? token = '';

  @override
  void initState() {
    // TODO: implement initState

    loadtoken();
    super.initState();
  }

  void loadtoken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      if (pref.getString('token') != null)
        token = pref.getString('token') ?? "";
      else
        pref.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (token != '' && token != null)
            ? bottomnavvar()
            : SingleChildScrollView(
                child: Column(
                children: [
                  Container(
                    color: white,
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: Intro(),
                  ),
                  Container(
                    color: greenlight,
                    height: MediaQuery.of(context).size.height * 0.40,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 25,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Get started with Fasttrack",
                            style: TextStyle(
                                color: textcolor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 25),
                          TextFormField(
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLength: 10,
                            decoration: InputDecoration(
                                counterText: '',
                                contentPadding: EdgeInsets.all(10),
                                prefixIcon: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        right:
                                            BorderSide(color: verticalborder)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text("+91"),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: verticalborder),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: verticalborder),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: verticalborder),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                hintText: "Login/Signup with Mobile",
                                hintStyle:
                                    TextStyle(color: hinttext, fontSize: 14)),
                          ),
                          SizedBox(height: 35),
                          Material(
                            color: buttoncolor,
                            borderRadius: BorderRadius.circular(50.0),
                            elevation: 0,
                            child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 0),
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
                                  if (_controller.text.length == 0) {
                                    msg = 'Please enter your mobile number';
                                  } else if (validateMobile(_controller.text) !=
                                      null) {
                                    msg = validateMobile(_controller.text);
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FutureBuilder<
                                                  Loginmodal>(
                                              future:
                                                  userlogin(_controller.text),
                                              builder: (BuildContext context,
                                                  snapshot) {
                                                if (snapshot.hasData) {
                                                  final userdata =
                                                      snapshot.data;

                                                  if (userdata?.success ==
                                                      true) {
                                                    pref.setString("mobile",
                                                        _controller.text);

                                                    return otp();
                                                  } else {
                                                    msg = userdata!.message
                                                        .toString();
                                                    return login();
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
                                                                    Colors
                                                                        .white),
                                                            minHeight: 5,
                                                          )
                                                        ]));
                                              })),
                                    );
                                  }

                                  await Future.delayed(Duration(seconds: 1));
                                  if (msg != '') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(msg),
                                    ));
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )));
  }

  validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (value == "0000000000" || value == "1111111111") {
      return 'Please enter valid mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter 10 digit mobile number';
    }
  }
}
