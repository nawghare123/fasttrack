import 'package:flutter/material.dart';


import 'package:fasttrack/api/booking_process_class.dart';
import 'package:fasttrack/api/payment_create_class.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/application_bloc.dart';
import '../models/booking_process_model.dart';
import '../models/payment_create_model.dart';
import '../style.dart';
import 'Payment.dart';
import 'Teleconsultancy.dart';
import 'medical_his_notes.dart';
class booking_process_homeCareService extends StatefulWidget {
  booking_process_homeCareService({Key? key,

     this.slot_id,
    this.slot_ids,
    this.slotdate,
    this.amount,
    this.name,
    this.profile_pic,
     this.qualification,
    this.specialization,
    this.experience,
    this.start_time}) : super(key: key);
  String? slot_id;
  List<int>? slot_ids;
  String? slotdate ;
  String? profile_pic;
  String? specialization;
  String? qualification;
  String? start_time;
  String? experience;
  int? amount;
  String? name;

  @override
  _booking_process_homeCareServiceState createState() => _booking_process_homeCareServiceState();
}

class _booking_process_homeCareServiceState extends State<booking_process_homeCareService> {
  TextEditingController _controller2 =TextEditingController();
  List<bool> value = [false,false,false,false,false,false,false,false,false,false,false];
  List<String>? history=[];

  TextEditingController _controller =TextEditingController();
  TextEditingController _controller1 =TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int? userid =0;
  String mobile="0";
  String? type="Nurse";
  String? bookedfor="self";
  String? name="";
  String? description="";
  int? paidamount=0;
  String? self="self";
  DateTime date = DateTime.now();

  @override
  void initState() {
    load();
    loaduser();
    super.initState();
  }
  void load() async{
    SharedPreferences pref =
    await SharedPreferences.getInstance();

    setState(() {
      if(pref.getInt("user_id")!=null) userid=pref.getInt("user_id")!;
      if(pref.getString("name")!=null) name=pref.getString("name")!;
      if(pref.getString("mobile")!=null) mobile=pref.getString("mobile")!;
    });

  }
  void loaduser() async {
    final applicationBloc =
    Provider.of<ApplicationBloc>(context, listen: false);
    await applicationBloc.userProfile();

    setState(() {
      _controller.text = applicationBloc.name;
      _controller1.text = applicationBloc.mobile;
      applicationBloc.userid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    int _currentIndex = 0;
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
                Navigator.pop(
                    context);
              }),
        ),
        title: Text(
          'Select Time Slot',
        ),
      ),

      body: SingleChildScrollView(

        child: Column(
          children: [
            Container(color: greenlight,
              height: MediaQuery.of(context).size.height*0.17,
              width: MediaQuery.of(context).size.width*100,
              child: Padding(
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
                            child: (widget.profile_pic!= null && widget.profile_pic!='')?
                            Image.network((widget.profile_pic??"").toString()):Image.asset("asset/images/man12.png"),
                            backgroundColor: Colors.transparent,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                widget.name??"",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: textcolor,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 3,),

                              Row(
                                children: [
                                  Text(
                                    widget.qualification ?? "",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: hinttext,
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    widget.specialization ?? "",
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
                                (widget.experience??0).toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: hinttext,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              // Row(mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     Image(image: AssetImage("asset/images/done2.png"),height: 10,),
                              //     SizedBox(width: 5,),
                              //     Text ("96%",style: TextStyle(
                              //       fontSize: 12,
                              //       color: green,
                              //     ),),
                              //     Text(
                              //       " (935 votes)",
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
                  ],
                ),
              ),
            ),
            Container(
              color: lightcolorblue,
              height: 50,
              width: MediaQuery.of(context).size.width * 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset("asset/images/video.png"),

                  ),
                  Text("Video Consulatation",style: TextStyle(color: hinttext,fontSize: 14),),


                  Padding(
                    padding: const EdgeInsets.only(left: 90,top: 5,bottom: 5,right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                            Text(
                        DateFormat("dd MMM yyyy").format(DateTime.parse((widget.slotdate??'1990-01-01'))) == DateTime.now()
                                  ? "Today,"
                                  :DateFormat("dd MMM yyyy").format(DateTime.parse((widget.slotdate??'1990-01-01'))) == DateTime.now().add(new Duration(days: 1))
                                  ? "Tomorrow,"
                                  : "",
                              style: TextStyle(color: hinttext,fontSize: 16)
                            ),

                               Text(
                                DateFormat("dd MMM yyyy").format(DateTime.parse((widget.slotdate??'1990-01-01'))),
                                style: TextStyle(color: green,fontSize: 14),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              //height: MediaQuery.of(context).size.height*20,
              width: MediaQuery.of(context).size.width*100,
              child:
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Paitent details",style:
                    TextStyle(fontSize: 18,color: text,fontWeight: FontWeight.bold),),
                    SizedBox(height: 15,),
                    Text("This video consultation is for:",style:
                    TextStyle(fontSize: 16,color: text,fontWeight: FontWeight.w500)),
                    SizedBox(height: 15,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.18,
                      width: MediaQuery.of(context).size.width*0.90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: greyc,
                            width: 0.5,
                          )
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          ListTile(
                            title: Text("Self"),
                            leading: Radio(
                                value: "self",
                                activeColor: buttoncolor,


                                groupValue: self,
                                onChanged: (value){
                                  setState(() {
                                    self = value.toString();
                                  }
                                  );
                                }
                            ),
                          ),


                          Divider(
                            thickness: 1,
                            color: hinttext,
                          ),

                          ListTile(
                            title: Text("Other"),
                            leading: Radio(
                                value: "other",

                                activeColor: buttoncolor,
                                groupValue: self,
                                onChanged: (value){
                                  setState(() {
                                    self = value.toString();
                                  });
                                }),
                          ),
                        ],),
                    ),

                    SizedBox(height: 15,),
                    Text("Please provide following information ",style:
                    TextStyle(fontSize: 16,color: text,fontWeight: FontWeight.w500)),
                    SizedBox(height: 15,),

                    Text("Full name*",style: TextStyle(fontSize: 16,color: greyc),),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(

                        hintStyle: TextStyle(color: hinttext,fontSize: 16),
                        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hinttext),
                          borderRadius:BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hinttext),
                          borderRadius:BorderRadius.circular(10),
                        ),),


                    ),
                    SizedBox(height: 15,),

                    Text("Mobile*",style: TextStyle(fontSize: 16,color: greyc),),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _controller1,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLength: 10,
                      decoration: InputDecoration(

                        counterText: '',


                        hintStyle: TextStyle(color: hinttext,fontSize: 16),
                        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hinttext),
                          borderRadius:BorderRadius.circular(10),
                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: hinttext),
                          borderRadius:BorderRadius.circular(10),
                        ),),


                    ),
                    SizedBox(height: 15,),
                    Text(
                      "Medical history",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500, color: text),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Checkbox(
                                side: BorderSide(color: hinttext, width: 1),
                                value: this.value[0],
                                onChanged: (bool? value) {
                                  setState(() {
                                    this.value.removeAt(0);
                                    this.value.insert(0, value!);
                                    if(value){
                                      history!.add('Allergies');
                                    }
                                    else{
                                      history!.remove('Allergies');
                                    }
                                  });
                                },
                              ),
                              //Checkbox

                              Text(
                                "Allergies",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: text),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            child: Row(
                              children: [
                                Checkbox(
                                  side: BorderSide(color: hinttext, width: 1),
                                  value: this.value[1],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.value.removeAt(1);
                                      this.value.insert(1, value!);
                                      if(value){
                                        history!.add('Past medical issue');
                                      }
                                      else{
                                        history!.remove('Past medical issue');
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  "Past medical issue",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: text),
                                ),
                              ],
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Checkbox(
                                side: BorderSide(color: hinttext, width: 1),
                                value: this.value[2],
                                onChanged: (bool? value) {
                                  setState(() {
                                    this.value.removeAt(2);
                                    this.value.insert(2, value!);
                                    if(value){
                                      history!.add('On medication');
                                    }
                                    else{
                                      history!.remove('On medication');
                                    }
                                  });
                                },
                              ),
                              //Checkbox

                              Text(
                                "On medication",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: text),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     SizedBox(
                    //       child: Row(
                    //         children: [
                    //           Checkbox(
                    //             side: BorderSide(color: hinttext, width: 1),
                    //             value: this.value[10],
                    //             onChanged: (bool? value) {
                    //               setState(() {
                    //                 this.value.removeAt(10);
                    //                 this.value.insert(10, value!);
                    //                 if(value){
                    //                   history!.add('other');
                    //                 }
                    //                 else{
                    //                   history!.remove('other');
                    //                 }
                    //               });
                    //             },
                    //           ),
                    //           //Checkbox
                    //
                    //           Text(
                    //             "other",
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.w400,
                    //                 fontSize: 14,
                    //                 color: text),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //
                    //   ],
                    // ),
                    SizedBox(
                      height: 15,
                    ),

                    Text("Remark",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: text),),


                    SizedBox(height: 15,),

                    TextField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: 10,
                        controller: _controller2,
                        decoration: InputDecoration(

                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(

                              borderSide: BorderSide(color: greyc,width:0.1),
                              borderRadius:
                              BorderRadius.all(new Radius.circular(10.0))),
                        )
                    ),

                    SizedBox(height: 20,),


                    Text("Bill details",
                        style: TextStyle(fontSize: 16,color: text,fontWeight: FontWeight.w500)),
                    SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Consultation fee",
                          style: TextStyle(
                              fontSize: 16,
                              color: hinttext,
                              fontWeight: FontWeight.w500),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text("₹"+(widget.amount??"").toString(),style: TextStyle(color: darkgrey,fontSize: 16,
                              fontWeight: FontWeight.w500),),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.5,
                      color: hinttext,
                    ),
                    SizedBox(height: 10,),

                    Text("1.Updates will be sent to "+"91 "+applicationBloc.mobile!,style:
                    TextStyle(color: greyc,fontSize: 14),),

                    Row(children: [
                      Text("2.Fastrack",style: TextStyle(fontSize: 14,
                          color: greyc)),
                      SizedBox(height: 10,),
                      Text("Terms and Conditions.",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,
                          color: buttoncolor),)
                    ],),
                    SizedBox(height: 20,),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:Text("Amount to Pay",style: TextStyle(fontSize: 16,color: text,fontWeight: FontWeight.w500),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 5),
                              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("₹",style: TextStyle(color: darkgrey),),
                                   SizedBox(width: 3,),
                                  Text((widget.amount??"").toString(),style: TextStyle(color: darkgrey,fontSize: 16,
                                      fontWeight: FontWeight.w500),),
                                ],
                              ),
                            )
                          ],
                        ),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(backgroundColor: buttoncolor,
                              side: BorderSide.none,),

                            //padding: EdgeInsets.symmetric( horizontal: 25),
                            child: Text("Amount to Pay",style:
                            TextStyle(color: pwhite,fontSize: 14),),
                            onPressed: () async {

                              String msg = '';

                              SharedPreferences pref =
                              await SharedPreferences.getInstance();
                              List<dynamic> a=[];
                              for(int i=0;i<history!.length;i++) {
                                a.add({
                                  "history_name":history![i]
                                });
                              }
                              var b=[];
                              for(int i=0;i<widget.slot_ids!.length;i++){
                                b.add({"slot_id":(widget.slot_ids![i])});
                              }
                              if (_controller.text== 0) {
                                msg = 'Please enter your name';
                              }
                              else if(a.length<=0){
                                msg = 'Please select disease';
                              }
                              else if (_controller2.text.length<=0) {
                                msg = 'Please write your remark';
                              }
                              else{
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FutureBuilder<booking_process_model>(

                                              future: booking_processC(userid!,
                                                  widget.slotdate!,
                                                  type!,self!,widget.amount!,_controller.text,_controller1.text,'',
                                                  paidamount!,"0",b),

                                              builder:
                                                  (BuildContext context, snapshot) {
                                                if (snapshot.hasData) {
                                                  final userdata = snapshot.data;
                                                  if (userdata?.success == true) {
                                                    pref.setInt("bookingid",
                                                        userdata!.data!.id!);
                                                    return  FutureBuilder<payment_create_model>(
                                                        future: createOrderC(
                                                            widget.amount!.toString(),),
                                                        builder:
                                                            (BuildContext context, snapshot) {
                                                          if (snapshot.hasData) {
                                                            final userdata = snapshot.data;
                                                            if (userdata?.success == true) {
                                                              return Payment(
                                                                  servicetype:type!,
                                                                userID:userid!,

                                                                  oid:userdata!.data!.orderId!,
                                                                  amount:widget.amount!.toString(),
                                                                  txntoken:userdata.data!.transactionToken!
                                                              );
                                                            }
                                                          }

                                                          else if (snapshot.hasError) {
                                                            return Text("${snapshot.error}");
                                                          }
                                                          return Container(
                                                              height: MediaQuery.of(context)
                                                                  .size
                                                                  .height,
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: [
                                                                    Center(child: CircularProgressIndicator())
                                                                  ]));
                                                        });
                                                  }
                                                } else if (snapshot.hasError) {
                                                  return Text("${snapshot.error}");
                                                }
                                                return Container(
                                                    height: MediaQuery.of(context)
                                                        .size
                                                        .height,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: [
                                                          Center(child: CircularProgressIndicator())
                                                        ]));
                                              })),
                                );
                              }
                              await Future.delayed(Duration(seconds: 2));
                              if (msg != '') {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(msg),
                                ));
                              }

                            }
                        )

                      ],),

                  ],),
              ),
            )


          ],),


      ),

    );
  }
}
