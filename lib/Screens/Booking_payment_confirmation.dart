import 'package:fasttrack/Screens/payment_confirmation_viewdetails.dart';
import 'package:fasttrack/api/booking_detailsclass.dart';
import 'package:fasttrack/others/bottomnavbar.dart';
import 'package:flutter/material.dart';

import '../style.dart';
import 'booking_details.dart';
import 'booking_payment_confirmation_failed.dart';

class booking_payment_confirmation extends StatefulWidget {
   booking_payment_confirmation({Key? key, this.orderid, this.amount,this.bookingid}) : super(key: key);
  String? orderid;
  String? amount;
  int? bookingid;

  @override
  _booking_payment_confirmationState createState() =>
      _booking_payment_confirmationState();
}

class _booking_payment_confirmationState
    extends State<booking_payment_confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: teal,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 20),
      //     child: IconButton(
      //         icon: Icon(
      //           Icons.arrow_back_sharp,
      //           color: Colors.white,
      //         ),
      //         onPressed: () {}),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100,left: 15,right: 15,bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset("asset/images/cright.png"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Your booking has been placed successfully!",textAlign: TextAlign.center,
                  style: Textnormal,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Order Id:"+widget.orderid!,
                  style: TextStyle(fontSize: 12, color: buttoncolor),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Amount paid:  ₹",
                        style: TextStyle(fontSize: 12, color: buttoncolor)),
                    Text(widget.amount!,
                        style: TextStyle(
                            fontSize: 12,
                            color: buttoncolor,
                            fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                MaterialButton(
                    color: buttoncolor,

                    //minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: Text(
                      "View details",
                      style: TextStyle(
                          color: pwhite, fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  payment_confirmation_viewdetails(
                                    orderid: widget.bookingid??0,


                                  )));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
