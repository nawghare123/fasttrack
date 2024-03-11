import 'package:fasttrack/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:intro_slider/slide_object.dart';

class Intro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IntroState();
  }
}

class IntroState extends State<Intro> {
  List<Slide> listSlides = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IntroSlider(
      colorDot: slider,
      showPrevBtn: false,
      showNextBtn: false,
      showDoneBtn: false,
      showSkipBtn: false,
      slides: listSlides,
      onDonePress: onPressedDone,
      verticalScrollbarBehavior: scrollbarBehavior.HIDE,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listSlides.add(Slide(
      widgetTitle: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("asset/images/login.png"),
            height: 200,
            width: 200,
          ),
          Image(
            image: AssetImage("asset/images/loginfast.png"),
            height: 50,
            width: 120,
          ),
          Text(
            'Book top Health care Experts',
            style: TextStyle(color: darkgrey, fontSize: 12),
          )
        ],
      ),
      backgroundColor: white,
    ));
    listSlides.add(Slide(
      widgetTitle: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("asset/images/login.png"),
            height: 200,
            width: 200,
          ),
          Image(
            image: AssetImage("asset/images/loginfast.png"),
            height: 50,
            width: 120,
          ),
          Text(
            'Book top Health care Experts',
            style: TextStyle(color: darkgrey, fontSize: 12),
          )
        ],
      ),
      backgroundColor: white,
    ));
    listSlides.add(Slide(
      widgetTitle: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("asset/images/login.png"),
            height: 200,
            width: 200,
          ),
          Image(
            image: AssetImage("asset/images/loginfast.png"),
            height: 50,
            width: 120,
          ),
          Text(
            'Book top Health care Experts',
            style: TextStyle(color: darkgrey, fontSize: 12),
          )
        ],
      ),
      backgroundColor: white,
    ));
  }

  onPressedDone() {}
}
