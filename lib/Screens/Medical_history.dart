import 'package:fasttrack/Screens/profile.dart';
import 'package:fasttrack/others/Inner_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/medical_hisclass.dart';
import '../blocs/application_bloc.dart';
import '../models/medical_hismodel.dart';
import '../style.dart';



class medical_history extends StatefulWidget {
  const medical_history({Key? key}) : super(key: key);

  @override
  _medical_historyState createState() => _medical_historyState();
}

class _medical_historyState extends State<medical_history> {

  TextEditingController _controller =TextEditingController();
 TextEditingController _controller1 =TextEditingController();
  TextEditingController _controller2 =TextEditingController();
  List<bool> value = [false,false,false,false,false,false,false,false,false,false,false];
  List<String>? history=[];

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(

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
        title:
        Text(
          //  'Pranit Singh',
            applicationBloc.name.toString(),
            style:TextBold
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: lightcolorblue,
            child:    TabBar(


              indicatorColor: buttoncolor,
            tabs: [

              Tab(


              child:  Text("Profile",style: TextStyle(fontSize: 14,color: text),)
                  

              ),
              Tab(
                child: Text("Medical history",style: TextStyle(fontSize: 14,color: buttoncolor),)
              )

            ],





          ),),
          
          Expanded(
            child: TabBarView(
                children: [
                 Inner_profile(),//profile
                  Column(
          children: [

         //   Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>

            FutureBuilder<medical_hismodel>(
                future: medical_historyC(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    final userdata = snapshot.data;
                    return Column(children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.data?.length,
                          itemBuilder: (BuildContext context, index) {
                            return   Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                //  mainAxisAlignment: MainAxisAlignment.start,
                                children: [


                                  SizedBox(
                                    child: Row(
                                      children: [



                                // Checkbox(
                                //             side: BorderSide(color: hinttext, width: 1),
                                //             value: this.value[10],
                                //             onChanged: (bool? value) {
                                //               setState(() {
                                //                 this.value.removeAt(10);
                                //                 this.value.insert(10, value!);
                                //                 if(value){
                                //                   history!.add(userdata!.data![index]!.historyName!);
                                //                 }
                                //                 else{
                                //                   history!.remove(userdata!.data![index]!.historyName!);
                                //                 }
                                //               });
                                //             },
                                //           ),

                                        Text(
                                          userdata!.data![index]!.historyName!,
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
                            );
                          }),
                    ]);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: CircularProgressIndicator());
                }),






          ],
        ),
              //medical history
            ]),
          )
        ],
      ),
      ));
  }
}
