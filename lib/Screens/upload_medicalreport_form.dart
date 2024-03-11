import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/add_medical_report_class.dart';
import '../api/upload_medicalreport_class.dart';
import '../models/add_medical_report_model.dart';
import '../models/upload_medicalreport_model.dart';
import '../others/bottomnavbar.dart';
import '../style.dart';
import 'Medical_reports.dart';


class medicalreport_form extends StatefulWidget {
  const medicalreport_form({Key? key}) : super(key: key);

  @override
  _medicalreport_formState createState() => _medicalreport_formState();
}



class _medicalreport_formState extends State<medicalreport_form> {
  File? file;
  String networkurl = '';
  String tap = '';

  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  String filepath = '';
  String filename = '';
  DateTime selectedDate = DateTime.now();
  String type = "";
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime picked = await
  //   showDatePicker(
  //   context: context,
  //   initialDate: DateTime.now(),
  //   firstDate: DateTime(2019, 1),
  //   lastDate: DateTime(2029, 12),
  // ).then((pickedDate) {
  //   //do whatever you want
  //     });
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //     });
  // }
  @override
  void initState() {
    loaddata();
    dateInput.text = "";
    super.initState();
  }






  void loaddata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      if (pref.getString("profilepic") != null) {
        networkurl = pref.getString("profilepic")!;
        print('demo $file');
      }
      if (pref.getString("filepath") != null) {
        filepath = pref.getString("filepath")!;
      }


    });
  }

  Future getImageGallery() async {
    var image = await ImagePicker.platform
        .getImage(source: ImageSource.gallery, imageQuality: 25);

    setState(() {
      filename = image!.name;
      file = File(image!.path);
      print('Image Path $file');
    });
  }

  Future getImageCamera() async {
    var image = await ImagePicker.platform
        .getImage(source: ImageSource.camera, imageQuality: 25);

    setState(() {
      filename = image!.name;
      file = File(image!.path);
      print('Image Path $file');
    });
  }

  Future openCameraPopup(BuildContext context) async {
    showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.bottomCenter,
          insetPadding: EdgeInsets.all(0),
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
              height: 150,
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: border,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  FloatingActionButton(
                                    backgroundColor: Colors.black,
                                    onPressed: () async {
                                      await getImageGallery();
                                      Navigator.pop(context);
                                    },
                                    tooltip: "Pick Image form gallery",
                                    child: Icon(Icons.photo),
                                  ),
                                  SizedBox(height: 5),
                                  Text('Gallery',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              Column(
                                children: [
                                  FloatingActionButton(
                                    backgroundColor: Colors.black,
                                    onPressed: () async {
                                      await getImageCamera();
                                      Navigator.pop(context);

                                      await Future.delayed(
                                          Duration(seconds: 2));
                                    },
                                    tooltip: "Pick Image from camera",
                                    child: Icon(Icons.camera_alt),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Camera',
                                    style:
                                    TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ))
                ],
              )),
        );
      },
    );
  }
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
        title: Text('Medical Report', style: TextBold),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Upload your medical report",style: TextStyle(fontSize: 16, color: text,fontWeight: FontWeight.w500),),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[

                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Date",
                            style: TextStyle(color: text, fontSize: 14),
                          ),

                          SizedBox(
                            height: 5,
                          ),
                    TextField(
                        controller: dateInput,

                        decoration: InputDecoration(


                              contentPadding: EdgeInsets.all(15),
                              suffixIcon:   Icon(Icons.calendar_today,size: 14,),

                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greyc, width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: greyc, width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1970),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            print(
                                pickedDate);
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate);
                            setState(() {
                              dateInput.text =
                                  formattedDate;
                            });
                          } else {}
                        },
                    ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Doctor name",
                            style: TextStyle(color: text, fontSize: 14),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          TextField(
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              controller: _controller1,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: greyc, width: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: greyc, width: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),


                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Specialization",
                            style: TextStyle(color: text, fontSize: 14),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          TextField(
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              controller: _controller2,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: greyc, width: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: greyc, width: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),

                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Report name",
                            style: TextStyle(color: text, fontSize: 14),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          TextField(
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              controller: _controller3,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: greyc, width: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: greyc, width: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),

                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Details",
                            style: TextStyle(color: text, fontSize: 14),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          TextField(
                              keyboardType: TextInputType.multiline,
                               textInputAction: TextInputAction.newline,
                              minLines: 1,
                                maxLines: 10,
                              controller: _controller4,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: greyc, width: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: greyc, width: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),



                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              MaterialButton(
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 17, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                          color: buttoncolor, width: 0.8)),
                                  child: Text(
                                    "Choose file",
                                    style: TextStyle(
                                        color: buttoncolor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onPressed: () {
                                    openCameraPopup(context);
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width: 170,
                                  child: Text(
                                    filename,
                                  )),
                            ],
                          ),

                          SizedBox(
                            height: 40,
                          ),

                          Row(mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(
                                  color: buttoncolor,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: pwhite,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    String msg = '';
                                    SharedPreferences pref =
                                    await SharedPreferences.getInstance();

                                    if (dateInput.text.length <= 0) {
                                      msg = 'Please enter date';
                                    }
                                    else if(_controller1.text.length<=0){
                                      msg ='Please enter doctor name';
                                    }
                                    else if(_controller2.text.length<=0){
                                      msg ='Please enter specialization';
                                    }
                                    else if(_controller3.text.length<=0){
                                      msg ='Please enter report name';
                                    }
                                    else if(_controller4.text.length<=0){
                                      msg ='Please enter details';
                                    }
                                   else if (file==null || file!.path == null || file!.path == '') {
                                      msg ='Please select medical report';
                                    }
                                    else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FutureBuilder<
                                                  Upload_medicalreport>(
                                                  future: Upload(
                                                      file!.path, "medical_report"),
                                                  builder: (BuildContext context,
                                                      snapshot) {
                                                    if (snapshot.hasData) {
                                                      final userdata =
                                                          snapshot.data;

                                                      if (userdata!.success ==
                                                          true) {
                                                        msg = userdata!.message
                                                            .toString();
                                                        return FutureBuilder<                                                           AddMedicalReportModel>(
                                                            future: AddMedicalReportC(
                                                                 dateInput.text,
                                                                 _controller1.text
                                                                ,_controller2.text,
                                                                 _controller3.text,
                                                                 _controller4.text,
                                                                 userdata.data!.filePath!
                                                                ),
                                                            builder: (BuildContext
                                                            context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                final userdata =
                                                                    snapshot.data;
                                                                if (userdata
                                                                    ?.success ==
                                                                    true) {
                                                                  msg = userdata!
                                                                      .message
                                                                      .toString();
                                                                  return medical_reports();
                                                                } else {
                                                                  msg = userdata!
                                                                      .message
                                                                      .toString();
                                                                  return medicalreport_form();
                                                                }
                                                              } else if (snapshot
                                                                  .hasError) {
                                                                return Text(
                                                                    "${snapshot.error}");
                                                              }
                                                              return Container(
                                                                  height:
                                                                  MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height,
                                                                  // color: white,
                                                                  child: Column(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.center,
                                                                      children: [
                                                                        Center(
                                                                            child:
                                                                            CircularProgressIndicator())
                                                                      ]));
                                                            });
                                                      } else {
                                                        msg = userdata.message
                                                            .toString();
                                                        return medicalreport_form();
                                                      }
                                                    }
                                                    else if (snapshot.hasError) {
                                                      return Text(
                                                          "${snapshot.error}");
                                                    }
                                                    return Container(
                                                        height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                        color: white,
                                                        child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              LinearProgressIndicator(
                                                                backgroundColor:
                                                                buttoncolor,
                                                                valueColor:
                                                                AlwaysStoppedAnimation(
                                                                    white),
                                                                minHeight: 5,
                                                              )
                                                            ]));
                                                  })),
                                        );


                                    }

                                    await Future.delayed(Duration(seconds: 1));
                                    if (msg != '') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(msg),
                                      ));
                                    }
                                  }

                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
                              ),
                              SizedBox(width: 10,),

                              MaterialButton(
                               //   color: buttoncolor,
                                  elevation: 0,
                                  padding:
                                  EdgeInsets
                                      .symmetric(
                                      horizontal:
                                      15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          5),
                                      side: BorderSide(
                                          color:
                                          buttoncolor,
                                          width: 0.5)),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: buttoncolor,
                                        fontSize: 15),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    medical_reports()));
                                  }),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),

                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
