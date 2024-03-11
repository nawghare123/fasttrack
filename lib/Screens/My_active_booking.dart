import 'package:fasttrack/Screens/Service_provider_profile.dart';
import 'package:fasttrack/Screens/booking_details.dart';
import 'package:fasttrack/Screens/drawer.dart';
import 'package:fasttrack/Screens/payment_confirmation_viewdetails.dart';
import 'package:fasttrack/models/booking_detailsmodel.dart';
import 'package:fasttrack/others/bottomnavbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/Active_bookingclass.dart';
import '../api/cancelBooking_class.dart';
import '../blocs/application_bloc.dart';
import '../models/active_booking_model.dart';
import '../models/cancelBooking_model.dart';
import '../style.dart';
import 'Booking_process_profile_home care.dart';

class My_active_booking extends StatefulWidget {
  My_active_booking({Key? key, this.id}) : super(key: key);
  int? id;

  @override
  _My_active_bookingState createState() => _My_active_bookingState();
}

class _My_active_bookingState extends State<My_active_booking> {
  booking_details_model? data;

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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => bottomnavvar(index: 0)));
              }),
        ),
        title: Text('My Active Bookings', style: TextBold),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Active_booking_model>(
                future: active_booking(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    final userdata = snapshot.data;
                    return Column(children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.data?.length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    payment_confirmation_viewdetails(
                                                        orderid: userdata!
                                                            .data![index]
                                                            .id!)));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "OD" +
                                                  (userdata!.data![index].id ??
                                                          0)
                                                      .toString(),
                                              style: TextStyle(
                                                  color: textcolor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        child: Text(
                                                          DateFormat(
                                                                  "dd MMM, yyyy hh:mm a")
                                                              .format(
                                                            DateTime.parse((userdata
                                                                        .data![
                                                                            index]
                                                                        .appoinmentDate ??
                                                                    '')
                                                                .toString()),
                                                          ),
                                                          style: TextStyle(
                                                              color:
                                                                  buttoncolor),
                                                        )),
                                                  ],
                                                ),
                                                Text(
                                                  "₹ " +
                                                      (userdata.data![index]
                                                                  .paidAmount ??
                                                              0)
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: darkgrey),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          userdata.data![index]
                                                                      .profilePic !=
                                                                  null
                                                              ? Image.network(
                                                                  userdata
                                                                          .data![
                                                                              index]
                                                                          .profilePic ??
                                                                      "",
                                                                  width: 60,
                                                                  height: 60,
                                                                )
                                                              : Image.asset(
                                                                  "asset/images/man12.png",
                                                                  height: 60,
                                                                  width: 60,
                                                                ),
                                                          SizedBox(width: 15),
                                                          Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                  (userdata.data![index]
                                                                              .name ??
                                                                          "")
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color:
                                                                          textcolor,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                  height: 5,
                                                                ),
                                                                // for (int j = 0;
                                                                //     j >
                                                                //        3;
                                                                //     j++)
                                                                if(userdata.data![index].specializations!.length>0)
                                                                  Text(
                                                                    (userdata.data![index].specializations![0].title ??
                                                                            "")
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color:
                                                                            text,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                              ]),
                                                        ]),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        MaterialButton(
                                                            //color: slider,
                                                            elevation: 0,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        35),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                side: BorderSide(
                                                                    color:
                                                                        buttoncolor,
                                                                    width:
                                                                        0.5)),
                                                            child: Text(
                                                              "Reschedule",
                                                              style: TextStyle(
                                                                  color:
                                                                      buttoncolor,
                                                                  fontSize: 15),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              final applicationBloc =
                                                                  Provider.of<
                                                                          ApplicationBloc>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              await applicationBloc
                                                                  .bookingDetailsUsers(userdata
                                                                          .data![
                                                                              index]
                                                                          .id!);
                                                              setState(() {
                                                                data = applicationBloc.bookingDetails!;
                                                              });

                                                                if (data!.data![0].serviceType == 'Doctor')
                                                                  Navigator
                                                                      .pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(builder: (context) =>
                                                                              service_provider_profile(
                                                                                user_id: data!
                                                                                    .data![0]
                                                                                    .serviceProviderId!
                                                                                    .toString(),
                                                                                old_slot: data!
                                                                                    .data![0]
                                                                                    .slots!,
                                                                                booking_id: userdata.data![index].id!,
                                                                              )));


                                                                  if (data!.data![0].serviceType == 'Nurse')
                                                                    Navigator
                                                                        .pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (
                                                                                context) =>
                                                                                Booking_process_profile_home_care(
                                                                                  userid: data!
                                                                                      .data![0]
                                                                                      .serviceProviderId!
                                                                                      .toString(),
                                                                                  old_slot: data!
                                                                                      .data![0]
                                                                                      .slots!,
                                                                                  booking_id: userdata
                                                                                      .data![index]
                                                                                      .id!,
                                                                                )));

                                                     }),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        MaterialButton(
                                                            color: buttoncolor,
                                                            elevation: 0,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        35),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                side: BorderSide(
                                                                    color:
                                                                        buttoncolor,
                                                                    width:
                                                                        0.5)),
                                                            child: Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                  color: pwhite,
                                                                  fontSize: 15),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                                  String msg = '';
                                                                  SharedPreferences pref =
                                                                  await SharedPreferences.getInstance();
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => FutureBuilder<
                                                                            cancelBookingModel>(
                                                                        future: cancelBookingC(userdata
                                                                            .data![
                                                                                index]
                                                                            .id!
                                                                            .toString()),
                                                                        builder:
                                                                            (BuildContext context,
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            final userdata =
                                                                                snapshot.data;
                                                                            if (userdata?.success ==
                                                                                true) {
                                                                              msg = userdata!.message.toString();
                                                                              SchedulerBinding.instance.addPostFrameCallback((_) {       ScaffoldMessenger
                                                                                  .of(
                                                                                  context)
                                                                                  .showSnackBar(
                                                                                  SnackBar(
                                                                                      content: Text(
                                                                                          msg)));
                                                                              });

                                                                              return My_active_booking();
                                                                            } else {
                                                                              msg = userdata!.message.toString();
                                                                              SchedulerBinding.instance.addPostFrameCallback((_) {       ScaffoldMessenger
                                                                                  .of(
                                                                                  context)
                                                                                  .showSnackBar(
                                                                                  SnackBar(
                                                                                      content: Text(
                                                                                          msg)));
                                                                              });
                                                                              return My_active_booking();
                                                                            }
                                                                          } else if (snapshot
                                                                              .hasError) {
                                                                            return Text("${snapshot.error}");
                                                                          }
                                                                          return Container(
                                                                              height: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height,
                                                                              // color: white,
                                                                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                Center(child: CircularProgressIndicator())
                                                                              ]));
                                                                        }),


                                                                ),
                                                              );

                                                                  await Future.delayed(Duration(seconds: 2));
                                                                  if (msg != '') {
                                                                    ScaffoldMessenger.of(context)
                                                                        .showSnackBar(SnackBar(
                                                                      content: Text(msg),
                                                                    ));
                                                                  }
                                                            }),
                                                      ],
                                                    ),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                      color: hinttext,
                                    ),
                                  ]),
                            );
                          }),
                    ]);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}
