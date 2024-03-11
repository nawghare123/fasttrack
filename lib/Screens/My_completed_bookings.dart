import 'package:fasttrack/Screens/Payment_history.dart';
import 'package:fasttrack/Screens/booking_details.dart';
import 'package:fasttrack/Screens/payment_confirmation_viewdetails.dart';
import 'package:fasttrack/models/Complete_booking_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Api/Complete_bookingclass.dart';
import '../style.dart';
import 'My_active_booking.dart';

class my_completed_bookings extends StatefulWidget {
  const my_completed_bookings({Key? key}) : super(key: key);

  @override
  _my_completed_bookingsState createState() => _my_completed_bookingsState();
}

class _my_completed_bookingsState extends State<my_completed_bookings> {
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
        title: Text('Completed Bookings', style: TextBold),
      ),
      body:

      SingleChildScrollView(
        child:
       Column(
            children: [
              FutureBuilder<Complete_booking_model>(
                  future: complete_booking(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      final userdata = snapshot.data;
                      return Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data?.data?.length,
                              itemBuilder: (BuildContext context, index) {
                                return  InkWell(onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder:
                                        (context)=>Booking_details(id: userdata!.data![index].id!,)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[


                                       // for(int i=0;i<userdata!.data!.length;i++)

                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                              (userdata!.data![index].id??0)
                                                    .toString(),
                                                style: TextStyle(
                                                    color: textcolor,
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
                                                      width: MediaQuery.of(context).size.width*0.3,
                                                      child: Text(   DateFormat("dd MMM, yyyy hh:mm a").format(DateTime.parse(
                                                          userdata!.data![index]
                                                          .bookingDate
                                                          .toString()),),
                                                              style: TextStyle(
                                                                  color:
                                                                      buttoncolor),
                                                            ),
                                                    ),
                                                    ],
                                                  ),
                                                  Text(
                                                   "₹"+ (userdata!
                                                        .data![index].paidAmount??0)
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
                                                        CrossAxisAlignment.end,
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
                                                            userdata!
                                                                .data![index]
                                                                .profilePic!=null?
                                                            Image.network(
                                                             ( userdata!
                                                                  .data![index]
                                                                  .profilePic!??''),
                                                              width: 60,
                                                              height: 60,
                                                            ):Image.asset("asset/images/man12.png",height: 60,width: 60,),
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
                                                                   (userdata!
                                                                        .data![index].name??'').toString(),
                                                                    style: TextStyle(
                                                                        color:
                                                                            textcolor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                    height: 5,
                                                                  ),

                                                                  Text(
                                                                     (userdata!
                                                                          .data![index]
                                                                          .service??"")
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
                                                        height: 10,
                                                      )
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          thickness: 0.5,
                                          color: hinttext,
                                        ),

                                      ]),
                                ));
                              })
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })
            ],
          ),

      ),
    );
  }
}
