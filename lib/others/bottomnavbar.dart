import 'package:fasttrack/Screens/Payment_history.dart';
import 'package:fasttrack/Screens/Teleconsultancy.dart';
import 'package:fasttrack/Screens/ambulance_services.dart';
import 'package:fasttrack/Screens/homecare_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Screens/home.dart';
import '../Screens/login.dart';
import '../Screens/profile.dart';
import '../style.dart';

class bottomnavvar extends StatefulWidget {
 bottomnavvar({Key? key,this.index}) : super(key: key);
  int? index;
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<bottomnavvar> {

  int _currentIndex = 0;
  void initState(){

    _currentIndex=widget.index??0;
    super.initState();
  }

  @override
  final pages = [
    const home(),
    const Teleconsultancy(),
    const Homecare_services(),
    const ambulance_services(),
    const payment_history(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[_currentIndex],

      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child:  BottomNavigationBar(
          elevation: 0,
          backgroundColor: greenlight,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: buttoncolor,
          unselectedItemColor: hinttext.withOpacity(.60),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          onTap: (value) {
            setState(() => _currentIndex = value);
          },
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle:TextStyle(fontWeight: FontWeight.w500),
          items:  [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color:_currentIndex==0?buttoncolor:hinttext.withOpacity(.60),),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("asset/images/doctor.png",color:_currentIndex==1?buttoncolor:hinttext.withOpacity(.60)),
              label: 'Doctor',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("asset/images/nurse.png",color:_currentIndex==2?buttoncolor:hinttext.withOpacity(.60)),
              label: 'Nurses',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("asset/images/ambulance1.png",color:_currentIndex==3?buttoncolor:hinttext.withOpacity(.60)),
              label: 'Ambulance',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("asset/images/booking.png",color:_currentIndex==4?buttoncolor:hinttext.withOpacity(.60)),
              label: 'Booking History',
            ),

          ],
          currentIndex: _currentIndex,

        ),
      ),

    ) ;
  }
}
