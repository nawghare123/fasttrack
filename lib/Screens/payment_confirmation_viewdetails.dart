import 'package:fasttrack/Screens/My_active_booking.dart';
import 'package:fasttrack/Screens/drawer.dart';
import 'package:fasttrack/Screens/serviceproviderlist.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Api/booking_detailsclass.dart';
import '../models/booking_detailsmodel.dart';
import '../style.dart';
class payment_confirmation_viewdetails extends StatefulWidget {
   payment_confirmation_viewdetails({Key? key,this.orderid}) : super(key: key);
   int? orderid;

  @override
  _payment_confirmation_viewdetailsState createState() => _payment_confirmation_viewdetailsState();
}

class _payment_confirmation_viewdetailsState extends State<payment_confirmation_viewdetails> {
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
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>My_active_booking()));
              }),
        ),
        title: Text(
            'Order Summery',style:TextBold
        ),
      ),

      body: SingleChildScrollView(child:




      FutureBuilder<booking_details_model>(
          future: booking_details(widget.orderid??0),

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
                        return    Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(color: greenlight,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5,),

                                    Text("Approved order",style: Textnormal1,),

                                    SizedBox(height: 20,),
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.15,
                                      width: MediaQuery.of(context).size.width * 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: CircleAvatar(
                                                    radius: 35,
                                                    child:userdata!.data![index].profilePic!=null?

                                                    Image.asset(userdata!.data![index].profilePic??'')
                                                        :Image.asset("asset/images/man12.png"),
                                                    backgroundColor: Colors.transparent,
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(left: 25),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                    userdata!.data![index].name??'',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: textcolor,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                      SizedBox(height: 3,),
                                                      for (int j = 0;
                                                      j >
                                                         3;
                                                      j++)
                                                      Text(
                                                        userdata.data![index].specializations![j].title??'',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: hinttext,
                                                        ),
                                                      ),
                                                      SizedBox(height: 3,),
                                                      Row(
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                                "asset/images/right.png"),
                                                          ),
                                                          SizedBox(width: 5,),
                                                          Text(
                                                            (userdata.data![index].experience??0).toString(),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: hinttext,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5,),
                                                      // Row(mainAxisAlignment: MainAxisAlignment.start,
                                                      //   children: [
                                                      //     Image(image: AssetImage("asset/images/done.png")),
                                                      //     SizedBox(width: 5,),
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
                            ),

                            SizedBox(height: 10,),

                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text("Order status: "+"OD"+(userdata.data![index].id!??"")
                                        .toString(),style: Textnormal,),


                                    Column(crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 40,),
                                            Image.asset("asset/images/greenlocation.png"),

                                          ],),
                                        Row(mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            SizedBox(height: 30,width: MediaQuery.of(context).size.width*0.20,
                                              child: Text("Booking placed",textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 10,color: green),),
                                            ),
                                            SizedBox(width: 60,),
                                            SizedBox(height: 30,width: MediaQuery.of(context).size.width*0.20,
                                              child: Text("Booking Acknowledged ",textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 10,color: hinttext),),
                                            ),

                                            SizedBox(width: 50,),
                                            SizedBox(height: 30,width: MediaQuery.of(context).size.width*0.20,
                                              child: Text(("schedule at"+(DateFormat("hh:mm a").
                                                format(DateTime.parse("2022-01-01T"+
                                                  userdata.data![index].scheduledAt!))??"")),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 10,color: hinttext),),
                                            ),


                                          ],)
                                      ],)

                                  ],),),
                            ),
                            Divider(
                              thickness: 0.5,
                              color: hinttext,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text("Order deatils",style: Textnormal,),

                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                                      DateFormat("dd MMM, yyyy hh:mm a").

                                                      format(DateTime.parse(
                                                          ( userdata!.data![index]
                                                              .appoinmentDate??'')
                                                              .toString())),

                                                      style: Textsmall1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          // Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text("OD"+(userdata!.data![index].id!).toString(),style: Textsmall1,),
                                          //     SizedBox(height: 5,),
                                          //     Text( userdata!.data![index].paymentMode??'',style: Textsmall1,),
                                          //     SizedBox(height: 5,),
                                          //     Text(( userdata!.data![index].tranId??0).toString(),style: Textsmall1,),
                                          //     SizedBox(height: 5,),
                                          //     SizedBox( width: MediaQuery.of(context).size.width*0.2,
                                          //       child: Text(
                                          //         DateFormat("dd MMM, yyyy hh:mm a").format(DateTime.parse(
                                          //             ( userdata!.data![index]
                                          //                 .bookingDate??'')
                                          //                 .toString()),),
                                          //         style: Textsmall1,
                                          //       ),
                                          //     ),
                                          //
                                          //
                                          //   ],)
                                        ],),
                                    )

                                  ],),),
                            ),
                            Divider(
                              thickness: 0.5,
                              color: hinttext,
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text("Contact Fastrack",style: Textnormal,),

                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                          // Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text(userdata!.data![index].email??'',style: Textsmall1,),
                                          //     SizedBox(height: 5,),
                                          //     Text(  userdata!.data![index].mobile??'',style: Textsmall1,),
                                          //
                                          //
                                          //
                                          //
                                          //   ],)
                                        ],),
                                    )

                                  ],),),
                            ),




                          ],);
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
