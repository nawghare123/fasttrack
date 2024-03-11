import 'package:fasttrack/Screens/Booking_process_profile_home%20care.dart';
import 'package:fasttrack/Screens/Service_provider_profile.dart';
import 'package:fasttrack/others/bottomnavbar.dart';
import 'package:flutter/material.dart';

import '../style.dart';
import 'booking_details.dart';

class booking_payment_confirmation_failed extends StatefulWidget {
  booking_payment_confirmation_failed({Key? key, this.servicetype,this.user_ID})
      : super(key: key);
  int? user_ID;
  String? servicetype;



  @override
  _booking_payment_confirmation_failedState createState() =>
      _booking_payment_confirmation_failedState();
}

class _booking_payment_confirmation_failedState
    extends State<booking_payment_confirmation_failed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100, left: 20, right: 20, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset("asset/images/cancel.png"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Payment Failed!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: cancelred,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Transaction failed, please try again",
                  style: TextStyle(
                      color: cancelred,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
                SizedBox(
                  height: 35,
                ),
                MaterialButton(
                    color: buttoncolor,
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: Text(
                      "Retry",
                      style: TextStyle(
                          color: pwhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    onPressed: () {

                        if (widget.servicetype == 'Doctor')
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      service_provider_profile(user_id: widget.user_ID!.toString(),)));

                        if (widget.servicetype == 'Nurse')
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Booking_process_profile_home_care(userid: widget.user_ID!.toString(),)));


                      }),

                SizedBox(
                  height: 15,
                ),
                Text(
                  "*If the amount was detected, it will be credit to your account within 7 To 8 days.",
                  textAlign: TextAlign.center,
                  style: Textsmall,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
