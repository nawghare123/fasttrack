
import 'package:fasttrack/others/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import '../blocs/application_bloc.dart';
import '../others/silder_ambulance.dart';
import '../style.dart';
import 'Ambulance_list.dart';

class ambulance_services extends StatefulWidget {
  const ambulance_services({Key? key}) : super(key: key);

  @override
  _ambulance_servicesState createState() => _ambulance_servicesState();
}

class _ambulance_servicesState extends State<ambulance_services> {
  TextEditingController _controller =TextEditingController();
  TextEditingController _controller1 =TextEditingController();
  TextEditingController _controller2 =TextEditingController();
  int _currentIndex = 0;

  String selectlist ="Select";
  List<String> list =[
    "Select",
    "BLS",
    "ALS",
    "PTS"
  ];

  @override
  Widget build(BuildContext context) {
    final applicationBloc =
    Provider.of<ApplicationBloc>(context, listen: false);
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
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => bottomnavvar(index: 0,)));
              }),
        ),
        title: Text(
          'Select Ambulance',style:TextBold
        ),
        ),

      body: SingleChildScrollView(child:
      Padding(
        padding: const EdgeInsets.only(top: 0,right: 10,left: 10,bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.35,
              width: MediaQuery.of(context).size.width*0.95,
              child:  Padding(
                padding: const EdgeInsets.all(5.0),
                child: silderIntro(),
              ),

            ),



            SizedBox(height: 15,),



Column(children:[
Row(mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Column(
      children: [
        SizedBox(height: 20,),
        Image.asset("asset/images/map.png",height: 340,),



      ],
    ),
    SizedBox(width: 20,),
    Container(height: MediaQuery.of(context).size.height*0.60,
      width: MediaQuery.of(context).size.width*0.75,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Text("Ambulance type",style: Textnormal,),
          SizedBox(height: 10,),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.70,
            height:  MediaQuery.of(context).size.height*0.1,
            child: DropdownButtonFormField<String>(
              value: selectlist,
              iconSize: 0.0,
              style: new TextStyle(
                  color: text,
                  fontSize: 14),
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.arrow_drop_down_sharp,
                    color: hinttext,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: hinttext,width: 0.5),
                    borderRadius:BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: hinttext,width: 0.5),
                    borderRadius:BorderRadius.circular(10),
                  )
              ),
              // hint: Text('Please choose account type'),
              items: list.map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectlist = value!;
                }
                );
              },



              onTap: () {
                applicationBloc.clearSelectedLocation();

              },
            ),
          ),

          Text("Pick-up Address",style: Textnormal,),
          SizedBox(height: 10,),
          SizedBox(child:
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.location_on_outlined,color: hinttext,size: 20,),


              contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: hinttext,width: 0.5),
                borderRadius:BorderRadius.circular(10),
              ),
            focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(color: hinttext,width: 0.5),
            borderRadius:BorderRadius.circular(10),
          )),

          ),height:  MediaQuery.of(context).size.height*0.1,
            width: MediaQuery.of(context).size.width*0.70 ,),

          Text("Delivery Address",style: Textnormal,),
          SizedBox(height: 10,),
          SizedBox(
            height:  MediaQuery.of(context).size.height*0.1,
            width: MediaQuery.of(context).size.width*0.70,
            child: TextFormField(
              controller: _controller1,
              decoration: InputDecoration(

                hintStyle: TextStyle(color: hinttext,fontSize: 16),
                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: hinttext,width: 0.5),
                  borderRadius:BorderRadius.circular(10),
                ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: hinttext,width: 0.5),
              borderRadius:BorderRadius.circular(10),
            ),),

            ),
          ),

          Text("Date & Time",style: Textnormal,),
          SizedBox(height: 10,),
          SizedBox(child:
          TextFormField(
            controller: _controller2,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.calendar_today_outlined,size: 20,color: hinttext,),


                contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: hinttext,width: 0.5),
                  borderRadius:BorderRadius.circular(10),
                ),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: hinttext,width: 0.5),
                  borderRadius:BorderRadius.circular(10),
                )),


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
                DateFormat('dd-MM-yyyy').format(pickedDate);
                print(
                    formattedDate);
                setState(() {
                  _controller2.text =
                      formattedDate;
                });
              } else {}
            },

          ),height:  MediaQuery.of(context).size.height*0.1,
            width: MediaQuery.of(context).size.width*0.70)

        ],),
    ),
  ],
),


  ]),

            Material(color: buttoncolor,
              borderRadius: BorderRadius.circular(15.0),
              elevation: 0,


              child: MaterialButton(minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  child: Text("Continue",style: TextStyle(color: pwhite,
                      fontWeight: FontWeight.w500,fontSize: 16),),
                  onPressed: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Ambulance_provider_list(
                        city: _controller.text,
                      type:selectlist

                    )));
                  }),),

            SizedBox(height: 30,)



        ],),
      ),),


    );
  }
}
