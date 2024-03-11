import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import '../style.dart';

class silderIntro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SliderIntroState();
  }
}

class SliderIntroState extends State<silderIntro> {
  List<Slide> listSlides = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(height: MediaQuery.of(context).size.height*0.20,
      child: IntroSlider(
       isScrollable:true,
        colorActiveDot: red,
        colorDot: redl,
        showPrevBtn: false,
        showNextBtn: false,
        showDoneBtn: false,
        showSkipBtn: false,
        slides: listSlides,
        onDonePress: onPressedDone,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    listSlides.add(Slide(
        widgetTitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: hinttext,
                      width: 0.3,
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Basic Ambulance",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: red),
                        ),
                        Image(
                            image: AssetImage("asset/images/ambulancered.png"),height: 85,
                        )
                      ]),
                )
          ],
        ),
        backgroundColor: Colors.transparent));
    listSlides.add(Slide(
        widgetTitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: hinttext,
                  width: 0.3,
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Basic Ambulance",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: red),
                    ),
                    SizedBox(width: 5,),

                    Image(
                      image: AssetImage("asset/images/ambulancered.png"),height: 80,)
                  ]),
            )
          ],
        ),
        backgroundColor: Colors.transparent));
    listSlides.add(Slide(

        widgetTitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: hinttext,
                  width: 0.3,
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Basic Ambulance",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: red),
                    ),
                    Image(
                      image: AssetImage("asset/images/ambulancered.png"),height: 85,)
                  ]),
            )
          ],
        ),
        backgroundColor: Colors.transparent));
  }

  onPressedDone() {}
}
