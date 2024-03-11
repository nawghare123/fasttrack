import 'package:fasttrack/Screens/Booking_process_profile_home%20care.dart';
import 'package:fasttrack/models/search_nurse_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/application_bloc.dart';
import '../style.dart';



class Home_care_provider_list extends StatefulWidget {
   Home_care_provider_list({Key? key, required search_value, required  userid}) : super(key: key);
  String? userid;
  String? search_value;


  @override
  _Home_care_provider_listState createState() => _Home_care_provider_listState();
}

class _Home_care_provider_listState extends State<Home_care_provider_list> {
  TextEditingController _controller =TextEditingController();


  String location = "Female";

  //int _currentIndex = 0;

  List<String> list1 = ["Today", "Yesterday", "Tomorrow"];
  String location1 = "Today";



  Search_Nurse_Model? data;
  @override
  void initState() {
    load(widget.search_value??'');
    super.initState();
  }
  void load(String s) async{
    final applicationBloc =
    Provider.of<ApplicationBloc>(context, listen: false);
    await applicationBloc.searchNurse(s);
    setState(() {
      data=applicationBloc.searchNurseModel;
    });

  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
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
          'Select Nurses',style:TextBold
        ),
      ),
      body: (data!=null && data!.data!=null)?
Stack( children:[
      SingleChildScrollView(child: Column(
        children: [

          Container(
            height: MediaQuery.of(context).size.height * 0.15 ,
            width: MediaQuery.of(context).size.width * 100,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      //filled: true,
                      // fillColor: pwhite,
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: hinttext,
                      ),
                      hintText: "Speciality/disease",
                      hintStyle: TextStyle(
                          color: hinttext,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5, color: hinttext),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5, color: hinttext),
                    borderRadius: BorderRadius.circular(10),
                  ),
                    ),


                    onChanged: (value) {
                      if (value.length > 2) {
                        load(value);
                        widget.search_value;
                      }
                      else{
                        load("");
                      }
                    },
                    onTap: () {
                      applicationBloc.clearSelectedLocation();
                      _controller.text = "";
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 30.0),
                  //       child: SizedBox(
                  //         width: 100,
                  //         child: DropdownButtonFormField<String>(
                  //           value: location,
                  //           iconSize: 0.0,
                  //           style: new TextStyle(
                  //               color: Colors.white, fontSize: 14),
                  //           decoration: InputDecoration(
                  //             fillColor: buttoncolor,
                  //             filled: true,
                  //             contentPadding:
                  //             EdgeInsets.only(top: 2, bottom: 2, left: 5),
                  //             enabledBorder: OutlineInputBorder(
                  //               borderSide:
                  //               BorderSide(width: 0.5, color: hinttext),
                  //               borderRadius: BorderRadius.only(
                  //                 topRight: Radius.circular(10),
                  //                 topLeft: Radius.circular(10),
                  //                 bottomLeft: Radius.circular(10),
                  //                 bottomRight: Radius.circular(10),
                  //               ),
                  //             ),
                  //
                  //             suffixIcon: Icon(
                  //               Icons.arrow_drop_down_sharp,
                  //               color: pwhite,
                  //             ),
                  //             // border: InputBorder.none,
                  //             //focusedBorder: InputBorder.none,
                  //           ),
                  //           // hint: Text('Please choose account type'),
                  //           items: list.map<DropdownMenuItem<String>>(
                  //                   (String value) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: value,
                  //                   child: new Text(value),
                  //                 );
                  //               }).toList(),
                  //           onChanged: (String? value) {
                  //             setState(() {
                  //               location = value!;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 30.0),
                  //       child: SizedBox(
                  //         width: 110,
                  //         child: DropdownButtonFormField<String>(
                  //           value: location1,
                  //           iconSize: 0.0,
                  //           style: new TextStyle(
                  //               color: Colors.white, fontSize: 13),
                  //           decoration: InputDecoration(
                  //             fillColor: buttoncolor,
                  //             filled: true,
                  //             contentPadding:
                  //             EdgeInsets.only(top: 2, bottom: 2, left: 2),
                  //             enabledBorder: OutlineInputBorder(
                  //               borderSide:
                  //               BorderSide(width: 0.5, color: hinttext),
                  //               borderRadius: BorderRadius.only(
                  //                 topRight: Radius.circular(10),
                  //                 topLeft: Radius.circular(10),
                  //                 bottomLeft: Radius.circular(10),
                  //                 bottomRight: Radius.circular(10),
                  //               ),
                  //             ),
                  //
                  //             suffixIcon: Icon(
                  //               Icons.arrow_drop_down_sharp,
                  //               color: pwhite,
                  //             ),
                  //             // border: InputBorder.none,
                  //             //focusedBorder: InputBorder.none,
                  //           ),
                  //           // hint: Text('Please choose account type'),
                  //           items: list1.map<DropdownMenuItem<String>>(
                  //                   (String value) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: value,
                  //                   child: new Text(value),
                  //                 );
                  //               }).toList(),
                  //           onChanged: (String? value) {
                  //             setState(() {
                  //               location = value!;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 30.0),
                  //       child: SizedBox(
                  //         width: 100,
                  //         child: DropdownButtonFormField<String>(
                  //           value: location,
                  //           iconSize: 0.0,
                  //           style: new TextStyle(
                  //               color: Colors.white, fontSize: 14),
                  //           decoration: InputDecoration(
                  //             fillColor: buttoncolor,
                  //             filled: true,
                  //             contentPadding:
                  //             EdgeInsets.only(top: 5, bottom: 5, left: 5),
                  //             enabledBorder: OutlineInputBorder(
                  //               borderSide:
                  //               BorderSide(width: 0.5, color: hinttext),
                  //               borderRadius: BorderRadius.only(
                  //                 topRight: Radius.circular(10),
                  //                 topLeft: Radius.circular(10),
                  //                 bottomLeft: Radius.circular(10),
                  //                 bottomRight: Radius.circular(10),
                  //               ),
                  //             ),
                  //
                  //             suffixIcon: Icon(
                  //               Icons.arrow_drop_down_sharp,
                  //               color: pwhite,
                  //             ),
                  //             // border: InputBorder.none,
                  //             //focusedBorder: InputBorder.none,
                  //           ),
                  //           // hint: Text('Please choose account type'),
                  //           items: list.map<DropdownMenuItem<String>>(
                  //                   (String value) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: value,
                  //                   child: new Text(value),
                  //                 );
                  //               }).toList(),
                  //           onChanged: (String? value) {
                  //             setState(() {
                  //               location = value!;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          Container(
            color: lightcolorblue,
            height: 50,
            width: MediaQuery.of(context).size.width * 100,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "${data!.data!.length} Nurses are available ",
                style: TextStyle(
                    fontSize: 15,
                    color: textcolor,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          for(int i=0;i<data!.data!.length;i++)
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width * 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              radius: 35,
                              child:
                              (data!.data![i].profilePic!=null && data!.data![i].profilePic!='')?
                              Image.network(data!.data![i].profilePic??""):
                              Image.asset("asset/images/man12.png"),
                              backgroundColor: Colors.transparent,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                 data!.data![i].name??"",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: textcolor,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 3,),

                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data!.data![i].qualification??"",

                                      style: TextStyle(
                                        fontSize: 12,
                                        color: hinttext,
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      data!.data![i].specialization??"",

                                      style: TextStyle(
                                        fontSize: 12,
                                        color: hinttext,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3,),
                                Row(
                                  children: [
                                    Image(image: AssetImage("asset/images/right.png"),height: 10,),
                                    SizedBox(width: 5,),
                                    Text(
                                      (data!.data![i].experience??0).toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: hinttext,
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 5,),
                                // Row(mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     Image(image: AssetImage("asset/images/done.png")),
                                //     SizedBox(width: 5,),
                                //     Text(
                                //       "750 paitents served",
                                //       style: TextStyle(
                                //         fontSize: 12,
                                //         color: hinttext,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30,top: 10),
                        child: Divider(
                          thickness: 0.2,
                          endIndent: 9,
                          indent: 19,
                          height: 25,
                          color: hinttext,
                        ),
                      ),

                      SizedBox(height: 5,),

                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(image: AssetImage("asset/images/book1.png",),),
                                    SizedBox(width: 5,),
                                    Text("Available today",style: TextStyle(fontSize: 10,color: green),)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15,top: 5),
                                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("₹",style: TextStyle(color: darkgrey),),
                                    SizedBox(width: 3,),
                                    Text((data!.data![i].consultationFees??0).toString(),style: TextStyle(color: darkgrey,fontSize: 16,
                                        fontWeight: FontWeight.w500),),
                                    SizedBox(width: 3,),
                                    Text("Consultation fee",style: TextStyle(fontSize: 12,color: hinttext),)

                                  ],
                                ),
                              )
                            ],
                          ),


                          OutlinedButton(
                              style: OutlinedButton.styleFrom(backgroundColor: buttoncolor,
                                side: BorderSide.none,),
                              child: Text("Book Visit",style:
                              TextStyle(color: pwhite,fontSize: 14),),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (

                                    context)=>Booking_process_profile_home_care(
                                    userid: data!.data![i].id!.toString()
                                )
                                ));
                              })


                        ],),



                    ],
                  ),

                ),
                Divider(
                  thickness: 0.5,
                  color: hinttext,
                ),
              ],
            ),


          ),









      ],),),
  // if (applicationBloc.searchNurseModel != null &&
  //     applicationBloc.searchNurseModel!.data!.length != 0 &&
  //     _controller.text.length > 0)
  //   Padding(
  //       padding: EdgeInsets.only(left: 20, right: 15, top: 0),
  //       child: Container(
  //         height: 300.0,
  //         margin: EdgeInsets.only(
  //             top: MediaQuery.of(context).size.height * 0.18),
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey,
  //               blurRadius: 5.0,
  //             ),
  //           ],
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: ListView.builder(
  //             itemCount: applicationBloc.searchNurseModel!.data!.length,
  //             itemBuilder: (context, index) {
  //               return Ink(
  //                   color: Colors.lightGreen,
  //                   child: ListTile(
  //                     title: Text(
  //                       applicationBloc
  //                           .searchNurseModel!.data![index].name??"",
  //                       style: TextStyle(color: Colors.black),
  //                     ),
  //                     onTap: () {
  //                       FocusScope.of(context).unfocus();
  //                       setState(() {});
  //                     },
  //                   ));
  //             }),
  //       )),

]):LinearProgressIndicator(),
    );
  }
}
