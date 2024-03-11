
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Api/booking_detailsclass.dart';
import '../models/booking_detailsmodel.dart';
import '../style.dart';

class Booking_details extends StatefulWidget {
   Booking_details({Key? key,this.id}) : super(key: key);
int? id;
  @override
  _Booking_detailsState createState() => _Booking_detailsState();
}

class _Booking_detailsState extends State<Booking_details> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
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
        title: Text('Booking Details', style: TextBold),
      ),
      body:
      SingleChildScrollView(
        child: FutureBuilder<booking_details_model>(
            future: booking_details(widget.id??0),

            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                final userdata = snapshot.data;
                return  Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.data?.length,
                          itemBuilder: (BuildContext context, index) {
                            return   Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Approved order",
                                        style: Textnormal,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height:
                                        MediaQuery.of(context).size.height * 0.15,
                                        width:
                                        MediaQuery.of(context).size.width * 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10),
                                                    child: CircleAvatar(
                                                      radius: 35,
                                                      child:
                                                      userdata!
                                                          .data![index].profilePic!=null?
                                                      Image.network(userdata!
                                                          .data![index].profilePic??""):
                                                      Image.asset("asset/images/man.png",height: 60,width: 60,),
                                                      backgroundColor:
                                                      Colors.transparent,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      // mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          (userdata!.data![index]
                                                              .name??"")
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: textcolor,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        for (int j = 0;
                                                        j > 3;
                                                        j++)
                                                          // MouseRegion(
                                                          //   onHover: (_) => print('hover'),
                                                          //   child: GestureDetector(
                                                          //     onTap: () => print('tap'),
                                                          //     child:
                                                          //   ),
                                                          // ),

                                                          Text(
                                                            ((userdata.data![index].specializations![j].title??"").toString())
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: hinttext,
                                                            ),
                                                          ),



                                                        SizedBox(
                                                          height: 3,
                                                        ),


                                                        Row(
                                                          children: [
                                                            Image(
                                                              image: AssetImage(
                                                                  "asset/images/right.png"),
                                                              height: 10,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              (userdata!.data![index].experience??0)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: hinttext,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        // Row(
                                                        //   mainAxisAlignment:
                                                        //       MainAxisAlignment.start,
                                                        //   children: [
                                                        //     Image(
                                                        //         image: AssetImage(
                                                        //             "asset/images/done.png")),
                                                        //     SizedBox(
                                                        //       width: 5,
                                                        //     ),
                                                        //     Text(
                                                        //       "750 paitents served",
                                                        //       style: TextStyle(
                                                        //         fontSize: 12,
                                                        //         color: hinttext,
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                  color: hinttext,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Order deatils",
                                          style: Textnormal,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Order Id: ",
                                                        style: Textsmall,
                                                      ),
                                                      SizedBox(width: 60,),
                                                      Text(
                                                        "OD"+(userdata!.data![index].id!??"")
                                                            .toString(),
                                                        style: Textsmall1,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Paid by",
                                                        style: Textsmall,
                                                      ),
                                                      SizedBox(width:70,),
                                                      Text(
                                                        ( userdata!.data![index].paymentMode!
                                                            ??"")
                                                            .toString(),
                                                        style: Textsmall1,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          "Transaction Id",
                                                          style: Textsmall,
                                                        ),
                                                      SizedBox(width: 30,),
                                                      Text(
                                                        ( userdata!
                                                            .data![index]!.tranId??"")
                                                            .toString(),textAlign: TextAlign.center,
                                                        style: Textsmall1,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                  Row(mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Date",
                                                        style: Textsmall,
                                                      ),
                                                      SizedBox(width: 80),
                                                      SizedBox( width: MediaQuery.of(context).size.width*0.2,
                                                        child: Text(
                                                          DateFormat("dd MMM, yyyy hh:mm a").format(DateTime.parse(
                                                             ( userdata!.data![index]
                                                                  .bookingDate??'')
                                                                  .toString()),),
                                                          style: Textsmall1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                  color: hinttext,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Contact Fastrack",
                                          style: Textnormal,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Email:",
                                                        style: Textsmall,
                                                      ),
                                                      SizedBox(width: 60,),
                                                      Text(
                                                        userdata!.data![index].email??'',
                                                        style: Textsmall1,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Contact:",
                                                        style: Textsmall,
                                                      ),
                                                      SizedBox(width: 50,),
                                                      Text(
                                                        userdata!.data![index].mobile??'',
                                                        style: Textsmall1,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              // Column(
                                              //   crossAxisAlignment:
                                              //   CrossAxisAlignment.start,
                                              //   children: [
                                              //
                                              //     SizedBox(
                                              //       height: 5,
                                              //     ),
                                              //
                                              //   ],
                                              // )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })

                    ],
                  );

              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),


      ),

    );
  }
}
