
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/notification_all_readclass.dart';
import '../api/notificationclass.dart';
import '../api/notificationreadclass.dart';
import '../models/notification_all_readmodel.dart';
import '../models/notificationmodel.dart';
import '../models/notificationreadmodel.dart';
import '../style.dart';

class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
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
        title: Text(
            'Notification',style:TextBold
        ),
      ),

      body: SingleChildScrollView(child:

      FutureBuilder<notificationmodel>(
          future:notificationC(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              final userdata = snapshot.data;
              return Column(crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                InkWell(onTap: ()
                async {

                String msg = '';

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FutureBuilder<Notification_all_read_model>(

                              future: notification_all_readC(),
                              builder:
                                  (BuildContext context, snapshot) {
                                if (snapshot.hasData) {
                                  final userdata = snapshot.data;
                                  if (userdata?.success == true) {
                                    // pref.setString( "issuse", _controller.text);
                                    return notification();
                                  }
                                  else{
                                    return notification();
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


                await Future.delayed(Duration(seconds: 2));
                if (msg != '') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(msg),
                  ));
                }

              },

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Read All",
                        style: TextStyle(color: hinttext, fontSize: 14),
                      ),
                    ),
                   ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.data?.length,
                    itemBuilder: (BuildContext context, index) {
                      return      Column(
                        children: [
                          SizedBox(height: 10,),



                      InkWell(onTap: ()async {

                        String msg = '';



                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FutureBuilder<notificationreadmodel>(

                                        future: notificationread(userdata!.data![index]!.id!),
                                        builder:
                                            (BuildContext context, snapshot) {
                                          if (snapshot.hasData) {
                                            final userdata = snapshot.data;
                                            if (userdata?.success == true) {
                                              // pref.setString( "issuse", _controller.text);
                                              return notification();
                                            }
                                            else{
                                              return notification();
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


                        await Future.delayed(Duration(seconds: 2));
                        if (msg != '') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(msg),
                          ));
                        }

                      }


                      ,child: Container(

                      height: MediaQuery.of(context).size.height*0.20,
                      width: MediaQuery.of(context).size.width*100,
                      color: userdata!.data![index]!.isRead == 0
                      ? lightcolorblue : arrowlight ,


                      child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                      Text(userdata!.data![index]!.title!,style:
                      TextStyle(fontSize: 14,color: buttoncolor,fontWeight: FontWeight.w500),),

                      SizedBox(height: 15,),

                      Text(
                        DateFormat("dd MMM, yyyy")
                          .format(DateTime
                          .parse(userdata!.data![index]!.createdAt!)),style:
                      TextStyle(fontSize: 12,color: hinttext,fontWeight: FontWeight.w400), ),

                      SizedBox(height: 15,),

                      Text(userdata!.data![index]!.description!,style:
                      TextStyle(fontSize: 12,color: text,fontWeight: FontWeight.w400), ),



                      ],),
                      ),

                      ),



                      )],
                      );

                    }),
              ]);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          }),










      ),
    );
  }
}
