
import 'package:fasttrack/others/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/capturePaymentClass.dart';
import '../models/CapturePaymentModel.dart';
import '../style.dart';
import 'Booking_payment_confirmation.dart';
import 'booking_payment_confirmation_failed.dart';


class Payment extends StatefulWidget {
  Payment(
      {Key? key,
        this.servicetype,
        required this.oid,
        required this.amount,
        required this.txntoken,this.userID})
      : super(key: key);
  String oid;
  String txntoken;
  String amount;
  int? userID;
  String? servicetype;

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String mid = "kKsHru10135334559039", orderId = "", txnToken = "";
  String result = "";
  bool isStaging = true;
  bool isApiCallInprogress = false;
  String callbackUrl = "";
  bool restrictAppInvoke = true;
  bool enableAssist = false;
  String planlat = '';
  String planlng = '';
  String planrange = '';
  String plansource = '';
  String plandestination = '';
  bool ispaymentdone = false;
  int bookingid=0;

  @override
  void initState() {

    super.initState();
    _startTransaction(mid, widget.oid, widget.amount, widget.txntoken);
  }


  void _startTransaction(
      String _mid, String _orderId, String _amount, String _txnToken) async {


    if (_txnToken.isEmpty) {
      return;
    }
    var sendMap = <String, dynamic>{
      "mid": _mid,
      "orderId": _orderId,
      "amount": _amount,
      "txnToken": _txnToken,
      "callbackUrl":
      "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=$_orderId",
      "isStaging": isStaging,
      "restrictAppInvoke": restrictAppInvoke,
      "enableAssist": enableAssist
    };
    print(sendMap);
    try {
      var response = AllInOneSdk.startTransaction(
          _mid,
          _orderId,
          _amount,
          _txnToken,
          "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=$_orderId",
          isStaging,
          restrictAppInvoke,
          enableAssist);

      response.then((value) {

        // _handlePaymentSuccess(
        //     value!['ORDERID'], value['TXNID'], value['TXNAMOUNT']);
        setState(() {
          result = value.toString();
        });
      }).catchError((onError) {
        if (onError is PlatformException) {
          // _handlePaymentSuccess(onError.details['ORDERID'],
          //     onError.details['TXNID'], onError.details['TXNAMOUNT']);
        } else {
          // _handlePaymentSuccess(onError.details['ORDERID'],
          //     onError.details['TXNID'], onError.details['TXNAMOUNT']);
        }
      }).whenComplete(() => _handlePaymentSuccess(_orderId, '', _amount));
    } catch (err) {
      //Navigator.pushReplacement(
          //context, MaterialPageRoute(builder: (context) => wallet()));
      print('error1');
      print(err.toString());
      result = err.toString();
    }

    // finally {
    //   SchedulerBinding.instance!.addPostFrameCallback((_) {
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => wallet()));
    //   });
    // }
  }

  Future<void> _handlePaymentSuccess(
      String orderid, String transactionid, String amount) async {
    String msg = '';


    SharedPreferences pref =
    await SharedPreferences.getInstance();

    setState(() {
      if(pref.getInt("bookingid")!=null)
        bookingid=pref.getInt("bookingid")!;

    });



    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => FutureBuilder<CapturePaymentModel>(
                future: capturePayment(orderid, transactionid, amount,bookingid),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    final userdata = snapshot.data;
                    if (userdata!.success) {
                      // msg = "Money added successfully";
                      // SchedulerBinding.instance.addPostFrameCallback((_) {  ScaffoldMessenger.of(
                      //     context)
                      //     .showSnackBar(
                      //     SnackBar(
                      //         content: Text(
                      //             msg)));
                      // });
                      return booking_payment_confirmation(
                        orderid: widget.oid,
                        amount: widget.amount,
                        bookingid: bookingid);
                    } else {
                      msg = "Payment failed";
                      SchedulerBinding.instance.addPostFrameCallback((_) {  ScaffoldMessenger.of(
                          context)
                          .showSnackBar(
                          SnackBar(
                              content: Text(
                                  msg)));
                      });
                      return booking_payment_confirmation_failed(user_ID:widget.userID!,servicetype: widget.servicetype!,);
                    }
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: CircularProgressIndicator());
                })));
    await Future.delayed(Duration(seconds:2 ));
    if (msg != '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
        body: Container(
            height: MediaQuery.of(context).size.height,
            color: white,
            child:
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              LinearProgressIndicator(
                backgroundColor: buttoncolor,
                valueColor: AlwaysStoppedAnimation(white),
                minHeight: 5,
              )
            ])));
  }
}
