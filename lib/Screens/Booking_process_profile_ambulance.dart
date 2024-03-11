import 'package:fasttrack/models/Nurses_profile_slots_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/Ambulance_profile_slot_class.dart';
import '../api/Nurses_profile_slots_class.dart';
import '../api/reschedule_class.dart';
import '../models/ambulance_profile_model.dart';
import '../models/reschedule_model.dart';
import '../others/tabs.dart';
import '../style.dart';
import 'Booking Process - Ambulance.dart';
import 'Booking Process -HomeCare.dart';

class Booking_process_profile_ambulance extends StatefulWidget {
  Booking_process_profile_ambulance({Key? key,required this.userid}) : super(key: key);

  String userid;
  DateTime datetime = DateTime.now();

  @override
  Booking_process_profile_ambulanceState createState() => Booking_process_profile_ambulanceState();
}

class Booking_process_profile_ambulanceState extends State<Booking_process_profile_ambulance> {

  List<bool> value = [false,false,false,false,false,false,false,false,false,false,false];
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
        title: Text(
            'Select Time Slot',style:TextBold
        ),
      ),

      body: SingleChildScrollView(child:


      Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<Ambulance_profile_slot_model>(
              future: Ambulance_profile_slotC(widget.userid!),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  final userdata = snapshot.data;

                  return   Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                      //height: MediaQuery.of(context).size.height*10,
                      width: MediaQuery.of(context).size.width*100,
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
                                    radius: 40,
                                    child:

                                    (userdata!.data!.ambulance!.profilePic!=null)?
                                    Image.network(userdata!.data!.ambulance!.profilePic??""):
                                    Image.asset("asset/images/ambulancered.png"),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 25,),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        userdata!.data!.ambulance!.name??"",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: textcolor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 3,),

                                      Text(
                                        userdata!.data!.ambulance!.email??"",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: hinttext,
                                        ),
                                      ),
                                      SizedBox(height: 3,),

                                      Text(
                                        userdata!.data!.ambulance!.agencyName??"",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: hinttext,
                                        ),
                                      ),
                                      SizedBox(height: 3,),
                                      Text(
                                        userdata!.data!.ambulance!.mobile.toString()??"",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: hinttext,
                                        ),
                                      ),
                                      SizedBox(height: 3,),

                                      Text(
                                        userdata!.data!.ambulance!.ambulanceType??"",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: hinttext,
                                        ),
                                      ),
                                      SizedBox(height: 3,),

                                      Text(
                                        userdata!.data!.ambulance!.mobile.toString()??"",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: hinttext,
                                        ),
                                      ),
                                      SizedBox(height: 3,),

                                  SizedBox(width: 190,
                                    child: Text(
                                            userdata!.data!.ambulance!.address.toString()??"",textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: hinttext,
                                            ),
                                          ),
                                  ),

                                      // Row(
                                      //   children: [
                                      //     Image(image: AssetImage("asset/images/right.png"),height: 10,),
                                      //     SizedBox(width: 5,),
                                      //     Text(
                                      //       userdata!.data!.ambulance!.address.toString()??"",
                                      //       style: TextStyle(
                                      //         fontSize: 12,
                                      //         color: hinttext,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      // SizedBox(height: 5,),
                                      // Row(mainAxisAlignment: MainAxisAlignment.start,
                                      //   children: [
                                      //     Image(image: AssetImage("asset/images/done2.png"),height: 10,),
                                      //     SizedBox(width: 5,),
                                      //     Text ("96%",style: TextStyle(
                                      //       fontSize: 12,
                                      //       color: green,
                                      //     ),),
                                      //     Text(
                                      //       " (935 votes)",
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

                            // Padding(
                            //   padding: const EdgeInsets.all(10),
                            //   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            //     //mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //
                            //       Center(
                            //         child: RichText(
                            //             textAlign:
                            //             TextAlign.center,
                            //             text: TextSpan(
                            //                 text:
                            //                 userdata!.data!.ambulance!.agencyName??"",
                            //                 style: TextStyle(
                            //                     fontSize: 12,
                            //                     color: hinttext),
                            //                 children: [
                            //                   TextSpan(
                            //                     text: "more..",
                            //                     style: TextStyle(
                            //                         fontSize: 12,
                            //                         color:
                            //                         buttoncolor),
                            //                   ),
                            //                 ])),
                            //       ),
                            //     ],
                            //   ),
                            // ),


                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: lightcolorblue,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 100,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              "Ambulance Charge",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: hinttext,
                                  fontWeight: FontWeight.w500),
                            ),

                          ),

                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text((userdata!.data!.ambulance!.consultationFees??0).toString(),style: TextStyle(color: darkgrey,fontSize: 16,
                                fontWeight: FontWeight.w500),),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Additional Requirements",style: Textnormal,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(

                              border: Border.all(color: hinttext)
                          ),

                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Checkbox(
                              side: BorderSide(color: hinttext, width: 1),
                              value: this.value[0],
                              onChanged: (bool? value) {
                                setState(() {
                                  this.value.removeAt(0);
                                  this.value.insert(0, value!);
                                });
                              },
                            ),
                             Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("Oxygen Required",style: TextStyle(fontSize: 14,color: text),),
                            Text("less than 5L/min",style: TextStyle(fontSize: 12,color: hinttext))
                          ],
                        ),
                            Text("₹ 20")
                      ],),),
                    )

                    // Container(child:
                    // Column(children: [
                    //
                    //   NewEntryPage()
                    //
                    // ],),),
                    // for (int i = 0;
                    // i < userdata!.data!.length;
                    // i++)
//                       Container(
//
//                         width: MediaQuery.of(context).size.width*100,
//                         child: Padding(
//                           padding: const EdgeInsets.all(15),
//                           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                             //  if(userdata!.data!.slots![i].mornings!=null && userdata!.data!.slots![i].mornings!.length>0)
//                                 // Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                 //   mainAxisAlignment: MainAxisAlignment.start,
//                                 //   children: [
//                                 //     Row(
//                                 //       children: [
//                                 //         Text("Morning",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                                 //         Text("(${userdata!.data!.slots![i].mornings!.length} Slots)",style: TextStyle(fontSize: 14,color: hinttext),)
//                                 //
//                                 //       ],
//                                 //     ),
//                                 //     Padding(
//                                 //       padding: const EdgeInsets.all(8.0),
//                                 //       child:
//                                 //       GridView(
//                                 //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                 //             crossAxisCount: 3,
//                                 //             crossAxisSpacing: 5,
//                                 //             mainAxisSpacing: 5,
//                                 //             mainAxisExtent: 40
//                                 //         ),
//                                 //         children: [
//                                 //
//                                 //           for (int j = 0;
//                                 //           j <
//                                 //               userdata
//                                 //                   .data!
//                                 //                   .slots![i]!
//                                 //                   .mornings!
//                                 //                   .length;
//                                 //           j++)
//                                 //           // OutlinedButton(
//                                 //           //     style: OutlinedButton.styleFrom(backgroundColor: blue,
//                                 //           //       side: BorderSide.none,),
//                                 //           //
//                                 //           //
//                                 //           //
//                                 //           //     onPressed: (){
//                                 //           //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>booking_process()));
//                                 //           //     }, child: Text("06:15PM",style: TextStyle(color: pwhite),)),
//                                 //
//                                 //             // OutlinedButton(
//                                 //             //     style: OutlinedButton.styleFrom(backgroundColor: fillcolor,
//                                 //             //       side: BorderSide(width: 0.5,color: border1),),
//                                 //             //
//                                 //             //     onPressed: (){
//                                 //             //       Navigator.push(
//                                 //             //           context,
//                                 //             //           MaterialPageRoute(
//                                 //             //               builder: (context) =>
//                                 //             //                   booking_process_homeCareService(
//                                 //             //                     // slot_id:
//                                 //             //                     // userdata!.data!.slots![i].mornings![j].id!.toString(),
//                                 //             //                     amount:
//                                 //             //                     userdata!.data!.ambulance!.consultationFees??0,
//                                 //             //                     slotdate:
//                                 //             //                     userdata!.data!.slots![i].date!.toString(),
//                                 //             //                     name:
//                                 //             //                     userdata!.data!.nurse!.name??"",
//                                 //             //                     profile_pic:
//                                 //             //                     userdata!.data!.nurse!.profilePic ?? "",
//                                 //             //                     start_time:
//                                 //             //                     userdata!.data!.slots![i].mornings![j].startTime??"",
//                                 //             //                     qualification:
//                                 //             //                     userdata!.data!.nurse!.qualification??"",
//                                 //             //                     experience:
//                                 //             //                     userdata!.data!.nurse!.experience.toString()??"",
//                                 //             //                     specialization:
//                                 //             //                     userdata!.data!.nurse!.specialization??"",
//                                 //             //                   )));
//                                 //             //     }, child: Text( userdata!
//                                 //             //     .data!
//                                 //             //     .slots![i]
//                                 //             //     .mornings![
//                                 //             // j]
//                                 //             //     .startTime ??
//                                 //             //     '',style: TextStyle(color: blue),)),
//                                 //
//                                 //         ],
//                                 //         padding: EdgeInsets.all(5),
//                                 //         shrinkWrap: true,
//                                 //       ),
//                                 //     ),
//                                 //     SizedBox(height: 20,),
//                                 //   ],
//                                 // ),
//                              // if(userdata!.data!.slots![i].afternoons!=null && userdata!.data!.slots![i].afternoons!.length>0)
//                                 Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text("Afternoon ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                                        // Text("(${userdata!.data!.slots![i].afternoons!.length} Slots)",style: TextStyle(fontSize: 14,color: hinttext),)
//
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(5.0),
//                                       child:
//                                       GridView(scrollDirection: Axis.vertical,
//                                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 3,
//                                             crossAxisSpacing: 5,
//                                             mainAxisSpacing: 5,
//                                             mainAxisExtent: 40
//                                         ),
//                                         children: [
//
//                                           // for (int j = 0;
//                                           // j <
//                                           //     userdata
//                                           //         .data!
//                                           //         .slots![i]!
//                                           //         .afternoons!
//                                           //         .length;
//                                           // j++)
// //                                             OutlinedButton(
// //                                                 style: OutlinedButton.styleFrom(backgroundColor: fillcolor,
// //                                                   side: BorderSide(width: 0.5,color: border1),),
// //
// //
// //
// //                                                 onPressed: (){
// //                                                   Navigator
// //                                                       .pushReplacement(
// //                                                       context,
// //                                                       MaterialPageRoute(
// //                                                           builder: (context) =>
// //                                                               booking_process_homeCareService(
// //                                                                 slot_id:
// //                                                                 userdata!.data!.slots![i].afternoons![j]!.id!.toString(),
// //
// //                                                                 slotdate:
// //                                                                 userdata!.data!.slots![i].date!.toString()??"",
// //                                                                 name:
// //                                                                 userdata!.data!.nurse!.name??"",
// //                                                                 profile_pic:
// //                                                                 userdata!.data!.nurse!.profilePic ?? '',
// //                                                                 amount:
// //                                                                 userdata!.data!.nurse!.consultationFees??0,
// //                                                                 start_time:
// //                                                                 userdata!.data!.slots![i].afternoons![j].startTime ?? "",
// //                                                                 qualification:
// //                                                                 userdata!.data!.nurse!.qualification ?? "",
// //                                                                 experience:
// //                                                                 userdata!.data!.nurse!.experience.toString()??"",
// //                                                                 specialization:
// //                                                                 userdata!.data!.nurse!.specialization ?? "",
// //
// // //video_consult: userdata!.data!.doctor!.videoConsult!,
// //                                                               )));
// //                                                 }, child: Text( userdata!
// //                                                 .data!
// //                                                 .slots![i]
// //                                                 .afternoons![j]
// //                                                 .startTime!,style: TextStyle(color: blue),)),
//
//
//
//
//                                         ],
//                                         padding: EdgeInsets.all(5),
//                                         shrinkWrap: true,
//                                       ),
//
//                                     ),
//                                     SizedBox(height: 20,),
//                                   ],
//                                 ),
//                               // if(userdata!.data!.slots![i].evenings!=null && userdata!.data!.slots![i].evenings!.length>0)
//                               //   Column(crossAxisAlignment: CrossAxisAlignment.start,
//                               //     mainAxisAlignment: MainAxisAlignment.start,
//                               //     children: [
//                               //       Row(
//                               //         children: [
//                               //           Text("Evening ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                               //           Text("(${userdata!.data!.slots![i].evenings!.length} Slots)",style: TextStyle(fontSize: 14,color: hinttext),)
//                               //
//                               //         ],
//                               //       ),
//                               //       Padding(
//                               //         padding: const EdgeInsets.all(8.0),
//                               //         child:
//                               //
//                               //         GridView(scrollDirection: Axis.vertical,
//                               //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                               //               crossAxisCount: 3,
//                               //               crossAxisSpacing: 5,
//                               //               mainAxisSpacing: 5,
//                               //               mainAxisExtent: 40
//                               //           ),
//                               //           children: [
//                               //             for (int j = 0;
//                               //             j <
//                               //                 userdata
//                               //                     .data!
//                               //                     .slots![i]!
//                               //                     .evenings!
//                               //                     .length;
//                               //             j++)
//                               //               OutlinedButton(
//                               //                   style: OutlinedButton.styleFrom(backgroundColor: fillcolor,
//                               //                     side: BorderSide(width: 0.5,color: border1),),
//                               //
//                               //
//                               //
//                               //                   onPressed: (){
//                               //                     Navigator.push(
//                               //                         context,
//                               //                         MaterialPageRoute(
//                               //                             builder: (context) =>
//                               //                                 booking_process_homeCareService(
//                               //                                   // slot_id:
//                               //                                   // userdata!.data!.slots![i].evenings![j].id!.toString(),
//                               //                                   amount:
//                               //                                   userdata!.data!.ambulance!.consultationFees??0,
//                               //                                   // slotdate:
//                               //                                   // userdata!.data!.slots![i].date!.toString(),
//                               //                                   name:
//                               //                                   userdata!.data!.ambulance!.name??"",
//                               //                                   profile_pic:
//                               //                                   userdata!.data!.ambulance!.profilePic ?? "",
//                               //                                   // start_time:
//                               //                                   // userdata!.data!.slots![i].evenings![j].startTime??"",
//                               //                                   // qualification:
//                               //                                   // userdata!.data!.ambulance!.qualification??"",
//                               //                                   // experience:
//                               //                                   // userdata!.data!.ambulance!.experience.toString()??"",
//                               //                                   // specialization:
//                               //                                   // userdata!.data!.ambulance!.specialization??"",
//                               //                                 )));
//                               //
//                               //
//                               //                   }, child: Text(userdata!
//                               //                   .data!
//                               //                   .slots![i]
//                               //                   .evenings![j]
//                               //                   .startTime!,style: TextStyle(color: blue),)),
//                               //
//                               //
//                               //
//                               //
//                               //
//                               //           ],
//                               //           padding: EdgeInsets.all(5),
//                               //           shrinkWrap: true,
//                               //         ),
//                               //
//                               //       ),
//                               //       SizedBox(height: 20,),
//                               //     ],
//                               //   ),
//                             ],),
//                         ),
//                       )
                ]);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(child: CircularProgressIndicator());
              }),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "₹",
                      // +
                      // ((data!.data!.nurse!
                      //     .consultationFees??0) *
                      //     (slotids.length))
                      //     .toString(),
                  style: TextStyle(
                      color: darkgrey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                      color: buttoncolor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(5),
                          side: BorderSide(
                              color: buttoncolor,
                              width: 0.5)),
                      child: Text(
                        "Book",
                        style: TextStyle(
                            color: pwhite,
                            fontSize: 16),
                      ),
                      onPressed: () async {
                        String msg = '';

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                            booking_process_ambulance()));






                        // SharedPreferences pref =
                        // await SharedPreferences
                           // .getInstance();

                        // if (location1 == "Full day" &&
                        //     slotids.length <= 0) {
                        //   msg = 'Slot not available';
                        //   SchedulerBinding.instance.addPostFrameCallback((_) {
                        //     ScaffoldMessenger.of(
                        //         context)
                        //         .showSnackBar(
                        //         SnackBar(
                        //             content: Text(
                        //                 msg)));
                        //   });
                       // }
                        // if (widget.booking_id != null) {
                        //   Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => FutureBuilder<
                        //             reschedule_model>(
                        //             future: rescheduleC(
                        //                 widget
                        //                     .booking_id!,
                        //                 data!
                        //                     .data!
                        //                     .slots![
                        //                 i]
                        //                     .date ??
                        //                     "",
                        //                 widget
                        //                     .old_slot!,
                        //                 slotids[0]),
                        //             builder:
                        //                 (BuildContext
                        //             context,
                        //                 snapshot) {
                        //               if (snapshot
                        //                   .hasData) {
                        //                 final userdata =
                        //                     snapshot
                        //                         .data;
                        //                 if (userdata!
                        //                     .success == true) {
                        //                   msg ="Reschedule successfully";
                        //                   SchedulerBinding.instance.addPostFrameCallback((_) {
                        //                     ScaffoldMessenger
                        //                         .of(
                        //                         context)
                        //                         .showSnackBar(
                        //                         SnackBar(
                        //                             content: Text(
                        //                                 msg)));
                        //                   });
                        //                   return My_active_booking(
                        //                     id: widget
                        //                         .booking_id,
                        //                   );
                        //                 } else {
                        //                   msg = userdata
                        //                       .message!;
                        //                   SchedulerBinding.instance.addPostFrameCallback((_) {
                        //                     ScaffoldMessenger
                        //                         .of(
                        //                         context)
                        //                         .showSnackBar(
                        //                         SnackBar(
                        //                             content: Text(
                        //                                 msg)));
                        //                   });
                        //                   return Booking_process_profile_home_care(
                        //                     booking_id:
                        //                     widget
                        //                         .booking_id,
                        //                     userid: widget
                        //                         .userid,
                        //                     old_slot: widget
                        //                         .old_slot,
                        //                   );
                        //                 }
                        //               } else if (snapshot
                        //                   .hasError) {
                        //                 return Text(
                        //                     "${snapshot.error}");
                        //               }
                        //               return Container(
                        //                   height: MediaQuery.of(
                        //                       context)
                        //                       .size
                        //                       .height,
                        //                   color: white,
                        //                   child: Column(
                        //                       mainAxisAlignment:
                        //                       MainAxisAlignment
                        //                           .start,
                        //                       children: [
                        //                         LinearProgressIndicator(
                        //                           backgroundColor:
                        //                           buttoncolor,
                        //                           valueColor:
                        //                           AlwaysStoppedAnimation(Colors.white),
                        //                           minHeight:
                        //                           5,
                        //                         )
                        //                       ]));
                        //             }),
                        //       ));
                        //}


                        //  else {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               booking_process_homeCareService(
                        //                 slot_ids:
                        //                 slotids,
                        //                 slotdate:
                        //                 slotdate,
                        //                 amount: data!
                        //                     .data!
                        //                     .nurse!
                        //                     .consultationFees ??
                        //                     0,
                        //                 name: data!
                        //                     .data!
                        //                     .nurse!
                        //                     .name ??
                        //                     "",
                        //                 profile_pic: data!
                        //                     .data!
                        //                     .nurse!
                        //                     .profilePic ??
                        //                     "",
                        //                 qualification: data!
                        //                     .data!
                        //                     .nurse!
                        //                     .qualification ??
                        //                     "",
                        //                 experience: data!
                        //                     .data!
                        //                     .nurse!
                        //                     .experience
                        //                     .toString() ??
                        //                     "",
                        //                 specialization: data!
                        //                     .data!
                        //                     .nurse!
                        //                     .specialization ??
                        //                     "",
                        //               )));
                        // }


                        FocusScope.of(context).unfocus();
                        await Future.delayed(Duration(seconds: 1));
                        if (msg != '') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(msg),
                          ));
                        }
                      }),
                ),
              ],
            ),
          ),




        ],
      ),),
    );
  }
}
