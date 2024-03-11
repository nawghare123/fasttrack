

import 'package:fasttrack/Screens/Notification.dart';
import 'package:fasttrack/others/bottomnavbar.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Api/payment_historyclass.dart';
import '../blocs/application_bloc.dart';
import '../models/payment_historymodel.dart';
import '../style.dart';


class payment_history extends StatefulWidget {
  const payment_history({Key? key}) : super(key: key);

  @override
  _payment_historyState createState() => _payment_historyState();
}
DateTime date = DateTime.now();

//
// void initState() {
//   load1("");
//   super.initState();
// }
// void load1(String s) async{
//   final applicationBloc =
//   Provider.of<ApplicationBloc>(context, listen: false);
//   await applicationBloc.searchDoctor(s);
//   setState(() {
//     data=applicationBloc.payment_historymodel;
//   });

//}
class _payment_historyState extends State<payment_history> {

 // Payment_historymodel? data;
  @override
  Widget build(BuildContext context) {
    //final applicationBloc = Provider.of<ApplicationBloc>(context);
    //String tap = '';
    return Scaffold(
      appBar:

      AppBar(
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
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>bottomnavvar(index: 0,)));
              }),
        ),
        title: Text('Payment History', style: TextBold),
      ),
      body:
      // ( data!=null
      //     //&& data!.data!=null
      // )?
      SingleChildScrollView(
        child: Column(
          children: [

            FutureBuilder<Payment_historymodel>(
                future: Payment_historyC(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    final userdata = snapshot.data;
                    return Column(children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.data?.length,
                          itemBuilder: (BuildContext context, index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "TransactionID " + (userdata!.data![index].transactionId??0).toString(),

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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image(
                                                        image: AssetImage(
                                                            "asset/images/calender1.png")),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                          DateFormat("dd MMM yyyy").format(DateTime.parse((userdata.data![index]
                                                          .transactionDate??'1900-07-01'))),
                                                      style: TextStyle(
                                                          color: buttoncolor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Image(
                                                        image: AssetImage(
                                                            "asset/images/clock.png")),
                                                    SizedBox(width: 10,),
                                                    Text(
                                                      DateFormat("hh:mm a").format(DateTime.parse((userdata.data![index]
                                                          .transactionDate??'1900-07-01'))),

                            // DateFormat("dd MMM yyyy hh:mm").format(DateTime.parse(+??'')
                            // ),

                            // DateFormat("yyyy MMM dd HH:mm").format(
                            // DateTime.parse("2022-07-01T" + (  userdata.data![index]
                            //     .transactionDate??'').toString()
                            // ))

                                                      style: TextStyle(
                                                          color: buttoncolor),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "₹" +
                                               (userdata
                                                      .data![index].amount??'').toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: green),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),

                                        for (int j = 0;
                                        j < userdata.data![index].doctor!.length;
                                        j++)
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[


                           ( userdata
                                .data![index]
                                .doctor![j].profilePic!= null)?
                             Image.network(userdata
                                 .data![index]
                                 .doctor![j].profilePic?? '' ,
                               width: 60,
                             height:60,
                            )
                                : Image.asset(
                            "asset/images/man12.png", width: 60,
                              height:60,),


                                                      SizedBox(width: 15),
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                      userdata
                                                                  .data![index]
                                                                  .doctor![j]
                                                                  .name??'',
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
                                                              userdata
                                                                  .data![index]
                                                                  .doctor![j]
                                                                  .specialization??'',                                                              style: TextStyle(
                                                                  color: text,
                                                                  fontSize: 12),
                                                            ),
                                                          ]),
                                                    ]),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    MaterialButton(
                                                        color: userdata.data![index].transactionStatus == "Success"
                                                            ? green : cancelred,
                                                        elevation: 0,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          //   side: BorderSide(color: buttoncolor,width: 0.5)
                                                        ),
                                                        child: Text(
                                                        (userdata
                                                              .data![index]
                                                              .transactionStatus??'').toString(),
                                                          style: TextStyle(
                                                              color: pwhite,
                                                              fontSize: 15),
                                                        ),
                                                        onPressed: () {
                                                          // Navigator.push(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //         builder: (context) => setting()));
                                                        }),
                                                  ],
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    color: hinttext,
                                  )
                                ]);
                          }),
                    ]);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ],


        // :LinearProgressIndicator()
        )));
  }
}

// Container(
// width: MediaQuery.of(context).size.width,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.end,
// children: <Widget>[
//
// Padding(
// padding: const EdgeInsets.all(15  ),
// child: Column(  crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Text("OD65423",style: TextStyle(color: textcolor,fontWeight: FontWeight.w500),
// ),
// SizedBox(height: 20,),
// Row(crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Column(crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Row(
// children: [
// Image(image: AssetImage("asset/images/calender1.png")),
// SizedBox(width: 10,),
// Text("Jan 21, 2022 ",style: TextStyle(color: buttoncolor),),
// ],
// ),
// SizedBox(height: 5,),
// Row(
// children: [
// Image(image: AssetImage("asset/images/clock.png")),
// SizedBox(width: 10,),
// Text("08:15 PM",style: TextStyle(color: buttoncolor),
// ),
// ],
// ),
//
// ],
// ),
// Text("₹ 349",style: TextStyle(fontWeight: FontWeight.bold ,color: green),)
// ],
// ),
//
// SizedBox(height: 15,),
// Container(
// width: MediaQuery.of(context).size.width,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.end,
// children: <Widget>[
//
//
//
// Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.start,
// children: <Widget>[
//
// Image.asset(
// "asset/images/girlc.png",
// width: 60,
// height: 60,
// ),
// SizedBox(width: 15),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// SizedBox(height: 10),
// Text(
// "Pallavi Singh",style: TextStyle(color: textcolor,fontWeight: FontWeight.w500),
// ),
// SizedBox(width: 5,height: 5,),
// Text(
// "Short term nurse",style: TextStyle(color: text,fontSize: 12),
// ),
// ]),
//
//
//
//
//
//
// ]),
// SizedBox(height: 10,),
//
// Row(mainAxisAlignment: MainAxisAlignment.center,
// children: [
// MaterialButton(
// color: green,
// elevation: 0,
// padding: EdgeInsets.symmetric(horizontal: 20),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(5),
// //   side: BorderSide(color: buttoncolor,width: 0.5)
// ),
//
// child: Text(
// "Paid",
// style: TextStyle(
// color: pwhite,
// fontSize: 15),
// ),
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => setting()));
// }),
//
// ],
// ),
// ]),
// ),
// ],
// ),
// ),
//
// Divider(
// thickness: 0.5,
// color: hinttext,
// ),
//
// Padding(
// padding: const EdgeInsets.all(15  ),
// child: Column(  crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Text("OD65423",style: TextStyle(color: textcolor,fontWeight: FontWeight.w500),
// ),
// SizedBox(height: 20,),
// Row(crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Column(crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Row(
// children: [
// Image(image: AssetImage("asset/images/calender1.png")),
// SizedBox(width: 10,),
// Text("Jan 21, 2022 ",style: TextStyle(color: buttoncolor),),
// ],
// ),
// SizedBox(height: 5,),
// Row(
// children: [
// Image(image: AssetImage("asset/images/clock.png")),
// SizedBox(width: 10,),
// Text("08:15 PM",style: TextStyle(color: buttoncolor),
// ),
// ],
// ),
//
// ],
// ),
// Text("₹ 349",style: TextStyle(fontWeight: FontWeight.bold ,color: cancelred),)
// ],
// ),
//
// SizedBox(height: 15,),
// Container(
// width: MediaQuery.of(context).size.width,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.end,
// children: <Widget>[
//
//
//
// Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.start,
// children: <Widget>[
//
// Image.asset(
// "asset/images/girlc.png",
// width: 60,
// height: 60,
// ),
// SizedBox(width: 15),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// SizedBox(height: 10),
// Text(
// "Dr. Urmila Singh",style: TextStyle(color: textcolor,fontWeight: FontWeight.w500),
// ),
// SizedBox(width: 5,height: 5,),
// Text(
// "Obstetrician-Gynecologists",style: TextStyle(color: text,fontSize: 12),
// ),
// ]),
//
//
//
//
//
//
// ]),
// SizedBox(height: 10,),
//
// Row(mainAxisAlignment: MainAxisAlignment.center,
// children: [
// MaterialButton(
// color: cancelred,
// elevation: 0,
// padding: EdgeInsets.symmetric(horizontal: 20),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(5),
// //   side: BorderSide(color: buttoncolor,width: 0.5)
// ),
//
// child: Text(
// "Canceled",
// style: TextStyle(
// color: pwhite,
// fontSize: 15),
// ),
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>notification()));
// }),
//
// ],
// ),
// ]),
// ),
// ],
// ),
// ),
//
// Divider(
// thickness: 0.5,
// color: hinttext,
// ),
//
//
// Padding(
// padding: const EdgeInsets.all(15  ),
// child: Column(  crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Text("OD65423",style: TextStyle(color: textcolor,fontWeight: FontWeight.w500),
// ),
// SizedBox(height: 20,),
// Row(crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Column(crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Row(
// children: [
// Image(image: AssetImage("asset/images/calender1.png")),
// SizedBox(width: 10,),
// Text("Jan 21, 2022 ",style: TextStyle(color: buttoncolor),),
// ],
// ),
// SizedBox(height: 5,),
// Row(
// children: [
// Image(image: AssetImage("asset/images/clock.png")),
// SizedBox(width: 10,),
// Text("08:15 PM",style: TextStyle(color: buttoncolor),
// ),
// ],
// ),
//
// ],
// ),
// Text("₹ 349",style: TextStyle(fontWeight: FontWeight.bold ,color: darkgrey),)
// ],
// ),
//
// SizedBox(height: 15,),
// Container(
// width: MediaQuery.of(context).size.width,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.end,
// children: <Widget>[
//
//
//
// Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.start,
// children: <Widget>[
//
// Image.asset(
// "asset/images/girlc.png",
// width: 60,
// height: 60,
// ),
// SizedBox(width: 15),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// SizedBox(height: 10),
// Text(
// "Dr. Urmila Singh",style: TextStyle(color: textcolor,fontWeight: FontWeight.w500),
// ),
// SizedBox(width: 5,height: 5,),
// Text(
// "Obstetrician-Gynecologists",style: TextStyle(color: text,fontSize: 12),
// ),
// ]),
//
//
//
//
//
//
// ]),
// SizedBox(height: 10,),
//
// Row(mainAxisAlignment: MainAxisAlignment.center,
// children: [
// MaterialButton(
// color: cancelred,
// elevation: 0,
// padding: EdgeInsets.symmetric(horizontal: 20),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(5),
// //   side: BorderSide(color: buttoncolor,width: 0.5)
// ),
//
// child: Text(
// "Canceled",
// style: TextStyle(
// color: pwhite,
// fontSize: 15),
// ),
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Help_support()));
// }),
//
// ],
// ),
// ]),
// ),
// ],
// ),
// ),
//
// Divider(
// thickness: 0.5,
// color: hinttext,
// ),
//
//
//
//
//
//
//
//
//
//
//
//
// ]),
// ),
