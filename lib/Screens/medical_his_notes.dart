import 'package:fasttrack/others/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/medical_his_notes_class.dart';
import '../api/medical_hisclass.dart';
import '../models/medical_his_notes_model.dart';
import '../models/medical_hismodel.dart';
import '../style.dart';

class medical_h extends StatefulWidget {
  medical_h({Key? key,this.bookingid}) : super(key: key);
  int? bookingid;
  @override
  _medical_hState createState() => _medical_hState();
}

class _medical_hState extends State<medical_h> {
  TextEditingController _controller =TextEditingController();
  List<bool> value = [false,false,false,false,false,false,false,false,false,false,false];
  List<String>? history=[];

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
        title: Text('Add Medical History & Notes ', style: TextBold),
      ),
      body: SingleChildScrollView(
        child:  Column(
          children: [

            Container(

              child: Center(child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 0,
                      ),
                      Text(
                        "Medical history",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500, color: text),
                      ),
                      SizedBox(
                        height: 30,
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
                                          history!.add('Post medical issues');
                                        }
                                        else{
                                          history!.remove('Post medical issues');
                                        }
                                      });
                                    },
                                  ),
                                  Text(
                                    "Diabetes",
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
                        height: 20,
                      ),

                     Text("Remark",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: text),),


                      SizedBox(height: 20,),

                      TextField(
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 1,
                          maxLines: 10,
                          controller: _controller,

                          decoration: InputDecoration(

                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(

                                borderSide: BorderSide(color: greyc,width:0.1),
                                borderRadius:
                                BorderRadius.all(new Radius.circular(10.0))),
                          )
                      ),

                      SizedBox(height: 40,),


                      MaterialButton(
                          color: buttoncolor,
                          elevation: 0,

                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 13),

                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: pwhite, fontWeight: FontWeight.w500, fontSize: 15),
                          ),
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
                              if(a.length<=0){
                                msg = 'Please select disease';
                              }
                              else if (_controller.text.length<=0) {
                                msg = 'Please write your notes';
                              }
                              else{
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FutureBuilder<medical_his_notes_deletemodel>(

                                              future: medical_his_notesC(a,widget.bookingid!,_controller.text),
                                              builder:
                                                  (BuildContext context, snapshot) {
                                                if (snapshot.hasData) {
                                                  final userdata = snapshot.data;
                                                  if (userdata?.success == true) {
                                                    // pref.setString( "issuse", _controller.text);
                                                    return bottomnavvar(index: 0,);
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
              ),),
            )




          ],
        ),
      ),
    );
  }
}
