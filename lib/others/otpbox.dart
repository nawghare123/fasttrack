import 'package:fasttrack/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// Name - Ruchika Nawghare
// Start Date - 14-06-2022
// Modify Date -
// Reason to work on page -

class otpBox extends StatelessWidget {
  //const  otpBoxBuilder({Key? key}) : super(key: key);

  TextEditingController initVal;

  bool first, last;

  otpBox({required this.initVal,required this.first,required this.last});

  @override
  Widget build(BuildContext context) {
    return Container(

      alignment: Alignment.center,
      height: 50,
      width: 50,
      child: TextField(


        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.length == 0 && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        controller: initVal,
        maxLength: 1,
        autofocus: true,
        readOnly: false,
        obscureText: true,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        textAlign: TextAlign.center,
        //maxLength: 1,
        style: TextStyle(color: Color(0xff111111)),

        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: hinttext)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: hinttext)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: hinttext))

        ),
      ),

    );
  }
}
