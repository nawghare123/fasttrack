import 'package:fasttrack/models/logoutmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/logoutclass.dart';
import '../style.dart';
import 'home.dart';
import 'login.dart';


class logout extends StatefulWidget {
  const logout({Key? key}) : super(key: key);

  @override
  _logoutState createState() => _logoutState();
}

class _logoutState extends State<logout> {

  @override
  void initState() {
    super.initState();
    _loadId();
  }

  _loadId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      // return start_charging(make:widget.make,name:widget.name,address:widget.address,rating:widget.rating,date:widget.date,time:widget.time,id:widget.id,connectortype: widget.connectortype,connectorspeed: widget.connectorspeed,connectorprice: widget.connectorprice,paybleamount: widget.paybleamount,isStart: false,alreadyStart: true,initialvalue: int.parse(_timerController.value.toStringAsFixed(0)),);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>
                FutureBuilder<logoutmodel>(
                    future: logoutC(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        final userdata = snapshot.data;

                        if (userdata!.success==true) {
                          pref.clear();
                          return login();
                        } else {
                          SchedulerBinding.instance!
                              .addPostFrameCallback((_) {
                            final snackBar = SnackBar(
                              content: Text(
                                  userdata.message.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                          pref.clear();
                          return login();
                          //return start_charging(make:widget.make,name:widget.name,address:widget.address,rating:widget.rating,date:widget.date,time:widget.time,id:widget.id,connectortype: widget.connectortype,connectorspeed: widget.connectorspeed,connectorprice: widget.connectorprice,paybleamount: widget.paybleamount,isStart: false,alreadyStart: false,initialvalue: 0,);
                        }
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Container(
                          height: MediaQuery.of(
                              context)
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
                                      pwhite),
                                  minHeight: 5,
                                )
                              ]));
                    }))
        );
      });
    });
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    );
  }
}