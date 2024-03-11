import 'package:fasttrack/models/help_supportmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/help_supportclass.dart';
import '../style.dart';


class Help_support extends StatefulWidget {
  const Help_support({Key? key}) : super(key: key);

  @override
  _Help_supportState createState() => _Help_supportState();
}

class _Help_supportState extends State<Help_support> {
  TextEditingController _controller = TextEditingController();
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
        title: Text('Help & support', style: TextBold),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


             SizedBox(height: 20,),

              InkWell(onTap: ()=>launch("tel://+91 9756157794"),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(image: AssetImage("asset/images/callG.png")),

                    SizedBox(width: 20,),
                    Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pick-up a phone calls us:",style: Textsmall,),
                        SizedBox(height:5 ,),

                        Text("+91 9756157794",style: TextStyle(color: buttoncolor,fontSize: 12),)

                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 25,),

              InkWell(onTap: ()=>launch("mailto://Support@fastrack.com"),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(image: AssetImage("asset/images/mail.png")),

                    SizedBox(width: 20,),
                    Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Send an Email:",style: Textsmall,),
                        SizedBox(height:5 ,),

                        Text("Support@fastrack.com",style: TextStyle(color: buttoncolor,fontSize: 12),)

                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 25,),
  
              Text("Report an issues",style: TextStyle(fontSize: 14,color: text),),

              SizedBox(height: 25,),

               TextFormField(
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 1,
                  maxLines: 10,
                  controller: _controller,
                   decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: greyc,width:0.3),
                        borderRadius:
                        BorderRadius.all(new Radius.circular(10.0))),
                )
                ),

               SizedBox(height: 30,),


               MaterialButton(
                  color: buttoncolor,
                  elevation: 0,

                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 12),

                  child: Text(
                    "Continue",
                    style: TextStyle(
                        color: pwhite, fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  onPressed: ()
                  async {
                      String msg = '';
                      SharedPreferences pref =
                      await SharedPreferences.getInstance();
                      if (_controller.text.length <= 0) {
                        msg = 'Please write your issues';
                      }
                      else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FutureBuilder<help_supportmodel>(

                                      future: help_supportC(_controller.text),
                                  builder:
                                      (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      final userdata = snapshot.data;
                                      if (userdata?.success == true) {
                                        msg = userdata!.message.toString();

                                        print(userdata.message.toString());
                                        return Help_support();
                                      }
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return Container(
                                        height: MediaQuery.of(context)
                                            .size
                                            .height,
                                        // color: white,
                                        child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Center(child: CircularProgressIndicator())
                                            ]));
                                  })),
                        );
                      }

                      FocusScope.of(context).unfocus();
                      await Future.delayed(Duration(seconds: 1));
                      if (msg != '') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(msg),
                        ));
                      }

                    }


                  ),




            ],
          ),
        ),
      ),
    );
  }
}
