import 'dart:async';
import 'dart:js';

import 'package:flutter/material.dart';

import 'login.dart';

// Name - Ruchika Nawghare
// Start Date - 14-06-2022
// Modify Date -
// Reason to work on page -

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Stack(children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 13,right: 13),
                  child: Text(""

                ),
                )  ] )]));
    ;
  }
}
