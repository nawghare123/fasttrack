import 'package:fasttrack/models/Nurses_profile_slots_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/Nurses_profile_slots_class.dart';
import '../api/reschedule_class.dart';
import '../blocs/application_bloc.dart';
import '../models/reschedule_model.dart';
import '../others/tabs.dart';
import '../style.dart';
import 'Booking Process -HomeCare.dart';
import 'My_active_booking.dart';

class Booking_process_profile_home_care extends StatefulWidget {
  Booking_process_profile_home_care(
      {Key? key,
      this.userid,
      this.booking_id,
      this.slotdate,
      this.slotsId,
      this.name,
      this.old_slot})
      : super(key: key);
  String? userid;
  int? booking_id;
  String? name;
  String? slotdate;
  String? slotsId;
  List<dynamic>? old_slot;

  DateTime datetime = DateTime.now();

  @override
  _Booking_process_profile_home_careState createState() =>
      _Booking_process_profile_home_careState();
}

class _Booking_process_profile_home_careState
    extends State<Booking_process_profile_home_care>
    with TickerProviderStateMixin {
  TabController? _tabController;
  DateTime date = DateTime.now();
  List<int> slotids = [];
  String? slotdate;
  String? totalAmount;
  int? item = 0;
  Nurses_profile_slots_model? data;
  String? bookingid;


  @override
  void initState() {
    super.initState();
    loadnurse();
   // Details();

  }

  void loadnurse() async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    await applicationBloc.nurseProfile(widget.userid!);
    setState(() {
      data = applicationBloc.nursesProfileSlots;
      print(data!.data!.nurse!.name);
      if(data!.data!.slots!.length>0) {
        date = DateTime.parse(data!.data!.slots![0].date!);
        _tabController =
            TabController(vsync: this, length: data!.data!.slots!.length);
      }

    });
  }
  // void Details() async {
  //   final applicationBloc =
  //   Provider.of<ApplicationBloc>(context, listen: false);
  //
  //   await applicationBloc.nurseProfile(widget.userid!);
  //   setState(() {
  //     allbBokingDetails=applicationBloc.bookingDetails!.toString();
  //   });
  // }

  String location = "Select";
  List<String> list1 = ["Select", "baby care", "elder care", "cancer care"];
  String location1 = "Time slots";
  List<String> list2 = [
    "Time slots",
    "Full day"
  ];

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
        title: Text('Select Time Slot', style: TextBold),
      ),
      body: (data != null)
          ? Stack(children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          color: greenlight,
                          width: MediaQuery.of(context).size.width * 100,
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
                                        child: (data!.data!.nurse!.profilePic !=
                                                null)
                                            ? Image.network(
                                                data!.data!.nurse!.profilePic ??
                                                    "")
                                            : Image.asset(
                                                "asset/images/man12.png"),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            data!.data!.nurse!.name ?? "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: textcolor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),

                                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data!.data!.nurse!
                                                        .qualification ??
                                                    "",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: hinttext,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                data!.data!.nurse!
                                                        .specialization ??
                                                    "",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: hinttext,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    "asset/images/right.png"),
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                (data!.data!.nurse!
                                                            .experience ??
                                                        0)
                                                    .toString(),
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
                                // Padding(
                                //   padding: const EdgeInsets.all(10),
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       RichText(
                                //           overflow: TextOverflow.ellipsis,
                                //           maxLines: 3,
                                //           textAlign: TextAlign.start,
                                //           text: TextSpan(
                                //               text: (data!.data!.nurse!.bio ??
                                //                               "")
                                //                           .length >
                                //                       20
                                //                   ? (data!.data!.nurse!.bio ??
                                //                           "")
                                //                       .substring(0, 20)
                                //                   : (data!.data!.nurse!.bio ??
                                //                       ""),
                                //               //  (data!.data!.nurse!.bio!.length>20)?
                                //               style: TextStyle(
                                //                   fontSize: 12,
                                //                   color: hinttext),
                                //               children: [
                                //                 ((data!.data!.nurse!.bio ?? '')
                                //                             .length >
                                //                         20)
                                //                     ? TextSpan(
                                //                         text: " more..",
                                //                         style: TextStyle(
                                //                             fontSize: 12,
                                //                             color: buttoncolor),
                                //                       )
                                //                     : TextSpan()
                                //               ])),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: lightcolorblue,
                          height: 50,
                          width: MediaQuery.of(context).size.width * 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "Visiting Charge",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: hinttext,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "₹" +
                                      (data!.data!.nurse!.consultationFees ?? 0)
                                          .toString(),
                                  style: TextStyle(
                                      color: darkgrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height:10),
                        (_tabController != null && _tabController!.length > 0)
                            ? Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      //color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.arrow_back_ios,
                                                    color: arrow,
                                                  ),
                                                  onPressed: () {
                                                    if (_tabController!.index >
                                                        0) {
                                                      _tabController!.animateTo(
                                                          _tabController!
                                                                  .index -
                                                              1);
                                                    }
                                                  },
                                                ),
                                                Expanded(
                                                  child: TabBar(
                                                    isScrollable: true,
                                                    controller: _tabController,
                                                    labelStyle:
                                                        TextStyle(color: tabs),
                                                    unselectedLabelColor: tabs,
                                                    labelColor:
                                                        Colors.transparent,
                                                    tabs: List.generate(
                                                      data!.data!.slots!.length,
                                                      (index) {
                                                        return Tab(
                                                          height: 80,
                                                          child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                slotids = [];
                                                                item = index;
                                                                date = DateTime
                                                                    .parse(data!
                                                                        .data!
                                                                        .slots![
                                                                            index]
                                                                        .date!);
                                                                _tabController!
                                                                    .animateTo(
                                                                        index);
                                                                print(date);
                                                              });
                                                            },
                                                            child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.20,
                                                              width: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: lightb,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(15),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          DateTime.parse(data!.data!.slots![index].date!) == DateTime.now()
                                                                              ? "Today, "
                                                                              : DateTime.parse(data!.data!.slots![index].date!) == DateTime.now().add(new Duration(days: 1))
                                                                                  ? "Tomorrow, "
                                                                                  : "",
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: text,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                        Text(
                                                                          DateFormat("dd MMMM yyyy").format(DateTime.parse(data!
                                                                              .data!
                                                                              .slots![index]
                                                                              .date!)),
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: text,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      "(${data!.data!.slots![index].mornings!.length + data!.data!.slots![index].afternoons!.length + data!.data!.slots![index]!.evenings!.length} Slots )",
                                                                      //Available
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              green,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: arrow,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (_tabController!
                                                                  .index +
                                                              1 <
                                                          50) {
                                                        _tabController!
                                                            .animateTo(
                                                                _tabController!
                                                                        .index +
                                                                    1);
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    "Can't move forward")));
                                                      }
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // NewEntryPage(),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       left: 10),
                                              //   child: SizedBox(
                                              //     width: 150,
                                              //     child:
                                              //         DropdownButtonFormField<
                                              //             String>(
                                              //       value: location,
                                              //       iconSize: 0.0,
                                              //       style: new TextStyle(
                                              //           color: Colors.black,
                                              //           fontSize: 14),
                                              //       decoration: InputDecoration(
                                              //         fillColor: lightb,
                                              //         filled: true,
                                              //         contentPadding:
                                              //             EdgeInsets.symmetric(
                                              //                 horizontal: 12),
                                              //         enabledBorder:
                                              //             OutlineInputBorder(
                                              //           borderSide: BorderSide(
                                              //               width: 0.5,
                                              //               color: hinttext),
                                              //           borderRadius:
                                              //               BorderRadius.only(
                                              //             topRight:
                                              //                 Radius.circular(
                                              //                     10),
                                              //             topLeft:
                                              //                 Radius.circular(
                                              //                     10),
                                              //             bottomLeft:
                                              //                 Radius.circular(
                                              //                     10),
                                              //             bottomRight:
                                              //                 Radius.circular(
                                              //                     10),
                                              //           ),
                                              //         ),
                                              //         focusedBorder:
                                              //             OutlineInputBorder(
                                              //           borderSide: BorderSide(
                                              //               width: 0.5,
                                              //               color: hinttext),
                                              //           borderRadius:
                                              //               BorderRadius.only(
                                              //             topRight:
                                              //                 Radius.circular(
                                              //                     10),
                                              //             topLeft:
                                              //                 Radius.circular(
                                              //                     10),
                                              //             bottomLeft:
                                              //                 Radius.circular(
                                              //                     10),
                                              //             bottomRight:
                                              //                 Radius.circular(
                                              //                     10),
                                              //           ),
                                              //         ),
                                              //         suffixIcon: Icon(
                                              //           Icons
                                              //               .arrow_drop_down_sharp,
                                              //           color: Colors.black,
                                              //         ),
                                              //       ),
                                              //       items: list1.map<
                                              //               DropdownMenuItem<
                                              //                   String>>(
                                              //           (String value) {
                                              //         return DropdownMenuItem<
                                              //             String>(
                                              //           value: value,
                                              //           child: new Text(value),
                                              //         );
                                              //       }).toList(),
                                              //       onChanged: (String? value) {
                                              //         setState(() {
                                              //           (location = value!);
                                              //         });
                                              //       },
                                              //     ),
                                              //   ),
                                              // ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: SizedBox(
                                                  width: 150,
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value: location1,
                                                    iconSize: 0.0,
                                                    style: new TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13),
                                                    decoration: InputDecoration(
                                                      fillColor: lightb,
                                                      filled: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.5,
                                                            color: hinttext),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.5,
                                                            color: hinttext),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      suffixIcon: Icon(
                                                        Icons
                                                            .arrow_drop_down_sharp,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    items: list2.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: new Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        location1 = value!;

                                                        if (value ==
                                                            "Full day") {
                                                          if (data!
                                                                  .data!
                                                                  .slots![item!]
                                                                  .mornings!
                                                                  .length >
                                                              0)
                                                            for (int i = 0;
                                                                i <
                                                                    data!
                                                                        .data!
                                                                        .slots![
                                                                            item!]
                                                                        .mornings!
                                                                        .length;
                                                                i++) {
                                                              if (data!
                                                                      .data!
                                                                      .slots![item!]
                                                                      .mornings![
                                                                          i]
                                                                      .status ==
                                                                  'Available')
                                                                slotids.add(data!
                                                                    .data!
                                                                    .slots![
                                                                        item!]
                                                                    .mornings![
                                                                        i]
                                                                    .id!);
                                                            }
                                                          if (data!
                                                                  .data!
                                                                  .slots![item!]
                                                                  .afternoons!
                                                                  .length >
                                                              0)
                                                            for (int i = 0;
                                                                i <
                                                                    data!
                                                                        .data!
                                                                        .slots![
                                                                            item!]
                                                                        .afternoons!
                                                                        .length;
                                                                i++) {
                                                              if (data!
                                                                      .data!
                                                                      .slots![item!]
                                                                      .afternoons![
                                                                          i]
                                                                      .status ==
                                                                  'Available')
                                                                slotids.add(data!
                                                                    .data!
                                                                    .slots![
                                                                        item!]
                                                                    .afternoons![
                                                                        i]
                                                                    .id!);
                                                            }
                                                          if (data!
                                                                  .data!
                                                                  .slots![item!]
                                                                  .evenings!
                                                                  .length >
                                                              0)
                                                            for (int i = 0;
                                                                i <
                                                                    data!
                                                                        .data!
                                                                        .slots![
                                                                            item!]
                                                                        .evenings!
                                                                        .length;
                                                                i++) {
                                                              if (data!
                                                                      .data!
                                                                      .slots![item!]
                                                                      .evenings![
                                                                          i]
                                                                      .status ==
                                                                  'Available')
                                                                slotids.add(data!
                                                                    .data!
                                                                    .slots![
                                                                        item!]
                                                                    .evenings![
                                                                        i]
                                                                    .id!);
                                                            }
                                                         // slotids.clear();
                                                        }
                                                        if (value ==
                                                            "Time slots") {
                                                          slotids.clear();
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                            height: 25,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Center(child:Text('No Slots Availble')),
                        for (int i = 0; i < data!.data!.slots!.length; i++)
                          if ((DateFormat("yyyy-MM-dd").format(DateTime.parse(
                                  data!.data!.slots![i].date!)) ==
                              DateFormat("yyyy-MM-dd").format(date)))
                            (location1 == "Time slots")
                                ? Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              if (data!.data!.slots![i]
                                                          .mornings !=
                                                      null &&
                                                  data!.data!.slots![i]
                                                          .mornings!.length >
                                                      0)
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Morning",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          "(${data!.data!.slots![i].mornings!.length} Slots)",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: hinttext),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: GridView(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    3,
                                                                crossAxisSpacing:
                                                                    5,
                                                                mainAxisSpacing:
                                                                    5,
                                                                mainAxisExtent:
                                                                    40),
                                                        children: [
                                                          for (int j = 0;
                                                              j <
                                                                  data!
                                                                      .data!
                                                                      .slots![i]
                                                                      .mornings!
                                                                      .length;
                                                              j++)
                                                            OutlinedButton(
                                                                style: OutlinedButton.styleFrom(
                                                                    backgroundColor: ((data!.data!.slots![i].mornings![j].status != 'Available')
                                                                        ? hinttext
                                                                        : slotids.contains(data!.data!.slots![i].mornings![j].id!)
                                                                            ? blue
                                                                            : fillcolor),
                                                                    side: BorderSide(width: 0.5, color: (data!.data!.slots![i].mornings![j].status != 'Available') ? border : blue)),
                                                                onPressed: () {
                                                                  // String msg =
                                                                  //     "";
                                                                  // if (widget
                                                                  //         .booking_id !=
                                                                  //     null) {
                                                                  //   Navigator.pushReplacement(
                                                                  //       context,
                                                                  //       MaterialPageRoute(
                                                                  //         builder: (context) => FutureBuilder<reschedule_model>(
                                                                  //             future: rescheduleC(widget.booking_id!, data!.data!.slots![i].date ?? "",
                                                                  //                 widget.old_slot!, data!.data!.slots![i].mornings![j].id!),
                                                                  //             builder: (BuildContext context, snapshot) {
                                                                  //               if (snapshot.hasData) {
                                                                  //                 final userdata = snapshot.data;
                                                                  //                 if (userdata!.success == true) {
                                                                  //                   return My_active_booking(
                                                                  //                     id: widget.booking_id,
                                                                  //                   );
                                                                  //                 } else {
                                                                  //                   msg = userdata.message!;
                                                                  //                   return Booking_process_profile_home_care(
                                                                  //                     booking_id: widget.booking_id,
                                                                  //                     userid: widget.userid,
                                                                  //                     old_slot: widget.old_slot,
                                                                  //                   );
                                                                  //                 }
                                                                  //               } else if (snapshot.hasError) {
                                                                  //                 return Text("${snapshot.error}");
                                                                  //               }
                                                                  //
                                                                  //               return Container(
                                                                  //                   height: MediaQuery.of(context).size.height,
                                                                  //                   color: white,
                                                                  //                   child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                  //                     LinearProgressIndicator(
                                                                  //                       backgroundColor: buttoncolor,
                                                                  //                       valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                  //                       minHeight: 5,
                                                                  //                     )
                                                                  //                   ]));
                                                                  //             }),
                                                                  //       ));
                                                                  // } else {

                                                                  if (!slotids.contains(data!
                                                                      .data!
                                                                      .slots![i]
                                                                      .mornings![
                                                                          j]
                                                                      .id!)) {
                                                                    setState(
                                                                        () {
                                                                      if (data!
                                                                              .data!
                                                                              .slots![i]
                                                                              .mornings![j]
                                                                              .status ==
                                                                          'Available') {
                                                                        slotdate = data!
                                                                            .data!
                                                                            .slots![i]
                                                                            .mornings![j]
                                                                            .date!;
                                                                        slotids.add(data!
                                                                            .data!
                                                                            .slots![i]
                                                                            .mornings![j]
                                                                            .id!);
                                                                      }
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      slotdate =
                                                                          "";
                                                                      slotids.remove(data!
                                                                          .data!
                                                                          .slots![
                                                                              i]
                                                                          .mornings![
                                                                              j]
                                                                          .id!);
                                                                    });
                                                                  }
                                                                },
                                                                child: Text(
                                                                  DateFormat("hh:mm a").format(DateTime.parse("2022-01-01T" +
                                                                          data!
                                                                              .data!
                                                                              .slots![i]
                                                                              .mornings![j]
                                                                              .startTime!)) ??
                                                                      '',
                                                                  style:
                                                                      TextStyle(
                                                                    color: (data!.data!.slots![i].mornings![j].status !=
                                                                            'Available'
                                                                        ? pwhite
                                                                        : slotids.contains(data!.data!.slots![i].mornings![j].id!)
                                                                            ? pwhite
                                                                            : blue),
                                                                  ),
                                                                )),
                                                        ],
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        shrinkWrap: true,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                  ],
                                                ),
                                              if (data!.data!.slots![i]
                                                          .afternoons !=
                                                      null &&
                                                  data!.data!.slots![i]
                                                          .afternoons!.length >
                                                      0)
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Afternoon ",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          "(${data!.data!.slots![i].afternoons!.length} Slots)",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: hinttext),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: GridView(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    3,
                                                                crossAxisSpacing:
                                                                    5,
                                                                mainAxisSpacing:
                                                                    5,
                                                                mainAxisExtent:
                                                                    40),
                                                        children: [
                                                          for (int j = 0;
                                                              j <
                                                                  data!
                                                                      .data!
                                                                      .slots![i]
                                                                      .afternoons!
                                                                      .length;
                                                              j++)
                                                            OutlinedButton(
                                                                style: OutlinedButton.styleFrom(
                                                                    backgroundColor: ((data!.data!.slots![i].afternoons![j].status != 'Available')
                                                                        ? hinttext
                                                                        : slotids.contains(data!.data!.slots![i].afternoons![j].id!)
                                                                            ? blue
                                                                            : fillcolor),
                                                                    side: BorderSide(width: 0.5, color: (data!.data!.slots![i].afternoons![j].status != 'Available') ? border : blue)),
                                                                onPressed: () {
                                                                  // if (widget
                                                                  //         .booking_id !=
                                                                  //     null) {
                                                                  //   Navigator.pushReplacement(
                                                                  //       context,
                                                                  //       MaterialPageRoute(
                                                                  //         builder: (context) => FutureBuilder<reschedule_model>(
                                                                  //             future: rescheduleC(widget.booking_id!, data!.data!.slots![i].date ?? "",
                                                                  //                 widget.old_slot!, data!.data!.slots![i].afternoons![j].id!),
                                                                  //             builder: (BuildContext context, snapshot) {
                                                                  //               if (snapshot.hasData) {
                                                                  //                 final userdata = snapshot.data;
                                                                  //                 if (userdata!.success == true) {
                                                                  //                   return My_active_booking(
                                                                  //                     id: widget.booking_id,
                                                                  //                   );
                                                                  //                 } else {
                                                                  //                   msg = userdata.message!;
                                                                  //                   return Booking_process_profile_home_care(
                                                                  //                     booking_id: widget.booking_id,
                                                                  //                     userid: widget.userid,
                                                                  //                     old_slot: widget.old_slot,
                                                                  //                   );
                                                                  //                 }
                                                                  //               } else if (snapshot.hasError) {
                                                                  //                 return Text("${snapshot.error}");
                                                                  //               }
                                                                  //
                                                                  //               return Container(
                                                                  //                   height: MediaQuery.of(context).size.height,
                                                                  //                   color: white,
                                                                  //                   child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                  //                     LinearProgressIndicator(
                                                                  //                       backgroundColor: buttoncolor,
                                                                  //                       valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                  //                       minHeight: 5,
                                                                  //                     )
                                                                  //                   ]));
                                                                  //             }),
                                                                  //       ));
                                                                  // } else {

                                                                  if (!slotids.contains(data!
                                                                      .data!
                                                                      .slots![i]
                                                                      .afternoons![
                                                                          j]
                                                                      .id!)) {
                                                                    setState(
                                                                        () {
                                                                      if (data!
                                                                              .data!
                                                                              .slots![i]
                                                                              .afternoons![j]
                                                                              .status ==
                                                                          'Available') {
                                                                        slotdate = data!
                                                                            .data!
                                                                            .slots![i]
                                                                            .afternoons![j]
                                                                            .date!;
                                                                        slotids.add(data!
                                                                            .data!
                                                                            .slots![i]
                                                                            .afternoons![j]
                                                                            .id!);
                                                                      }
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      slotdate =
                                                                          "";
                                                                      slotids.remove(data!
                                                                          .data!
                                                                          .slots![
                                                                              i]
                                                                          .afternoons![
                                                                              j]
                                                                          .id!);
                                                                    });
                                                                  }
                                                                },
                                                                child: Text(
                                                                  DateFormat("hh:mm a").format(DateTime.parse("2022-01-01T" +
                                                                          data!
                                                                              .data!
                                                                              .slots![i]
                                                                              .afternoons![j]
                                                                              .startTime!)) ??
                                                                      "",
                                                                  style:
                                                                      TextStyle(
                                                                    color: (data!.data!.slots![i].afternoons![j].status !=
                                                                            'Available'
                                                                        ? pwhite
                                                                        : slotids.contains(data!.data!.slots![i].afternoons![j].id!)
                                                                            ? pwhite
                                                                            : blue),
                                                                  ),
                                                                )),
                                                        ],
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        shrinkWrap: true,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                  ],
                                                ),
                                              if (data!.data!.slots![i]
                                                          .evenings !=
                                                      null &&
                                                  data!.data!.slots![i]
                                                          .evenings!.length >
                                                      0)
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Evening ",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          "(${data!.data!.slots![i].evenings!.length} Slots)",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: hinttext),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GridView(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    3,
                                                                crossAxisSpacing:
                                                                    5,
                                                                mainAxisSpacing:
                                                                    5,
                                                                mainAxisExtent:
                                                                    40),
                                                        children: [
                                                          for (int j = 0;
                                                              j <
                                                                  data!
                                                                      .data!
                                                                      .slots![i]
                                                                      .evenings!
                                                                      .length;
                                                              j++)
                                                            OutlinedButton(
                                                                style: OutlinedButton.styleFrom(
                                                                    backgroundColor: ((data!.data!.slots![i].evenings![j].status != 'Available')
                                                                        ? hinttext
                                                                        : slotids.contains(data!.data!.slots![i].evenings![j].id!)
                                                                            ? blue
                                                                            : fillcolor),
                                                                    side: BorderSide(width: 0.5, color: (data!.data!.slots![i].evenings![j].status != 'Available') ? border : blue)),
                                                                onPressed: () {
                                                                  if (!slotids.contains(data!
                                                                      .data!
                                                                      .slots![i]
                                                                      .evenings![
                                                                          j]
                                                                      .id!)) {
                                                                    setState(
                                                                        () {
                                                                      if (data!
                                                                              .data!
                                                                              .slots![i]
                                                                              .evenings![j]
                                                                              .status ==
                                                                          'Available') {
                                                                        slotdate = data!
                                                                            .data!
                                                                            .slots![i]
                                                                            .evenings![j]
                                                                            .date!;
                                                                        slotids.add(data!
                                                                            .data!
                                                                            .slots![i]
                                                                            .evenings![j]
                                                                            .id!);
                                                                      }
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      slotdate =
                                                                          "";
                                                                      slotids.remove(data!
                                                                          .data!
                                                                          .slots![
                                                                              i]
                                                                          .evenings![
                                                                              j]
                                                                          .id!);
                                                                    });
                                                                  }
                                                                },
                                                                child: Text(
                                                                  DateFormat("hh:mm a").format(DateTime.parse("2022-07-01T" +
                                                                          data!
                                                                              .data!
                                                                              .slots![i]
                                                                              .evenings![j]
                                                                              .startTime!)) ??
                                                                      '',
                                                                  style:
                                                                      TextStyle(
                                                                    color: (data!.data!.slots![i].evenings![j].status !=
                                                                            'Available'
                                                                        ? pwhite
                                                                        : slotids.contains(data!.data!.slots![i].evenings![j].id!)
                                                                            ? pwhite
                                                                            : blue),
                                                                  ),
                                                                )),
                                                        ],
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        shrinkWrap: true,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "₹" +
                                                  ((data!.data!.nurse!
                                                                  .consultationFees ??
                                                              0) *
                                                          (slotids.length))
                                                      .toString(),
                                              //(TotalAmount!.toStringAsFixed(0)),
                                              style: TextStyle(
                                                  color: darkgrey,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: MaterialButton(
                                                  color: buttoncolor,
                                                  elevation: 0,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 20),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      side: BorderSide(
                                                          color: buttoncolor,
                                                          width: 0.5)),
                                                  child: Text(
                                                    "Book",
                                                    style: TextStyle(
                                                        color: pwhite,
                                                        fontSize: 16),
                                                  ),
                                                  onPressed: () async {
                                                    String msg = '';
                                                    SharedPreferences pref =
                                                        await SharedPreferences
                                                            .getInstance();

                                                    if (slotids.length <= 0) {
    msg = 'Please select a slots';
    SchedulerBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(
    context)
        .showSnackBar(
    SnackBar(
    content: Text(
    msg)));
    });

                                                    }
                                                    else if (
                                                    widget.booking_id != null) {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => FutureBuilder<
                                                                    reschedule_model>(
                                                                future: rescheduleC(
                                                                    widget
                                                                        .booking_id!,
                                                                    data!
                                                                            .data!
                                                                            .slots![
                                                                                i]
                                                                            .date ??
                                                                        "",
                                                                    widget
                                                                        .old_slot!,
                                                                    slotids[0]),
                                                                builder: (BuildContext
                                                                        context,
                                                                    snapshot) {
                                                                  if (snapshot
                                                                      .hasData) {
                                                                    final userdata =
                                                                        snapshot
                                                                            .data;
                                                                    if (userdata!.success == true) {
                                                                      SchedulerBinding
                                                                          .instance!
                                                                          .addPostFrameCallback(
                                                                              (_) {
                                                                            ScaffoldMessenger
                                                                                .of(
                                                                                context)
                                                                                .showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(
                                                                                      userdata
                                                                                          .message!),
                                                                                ));
                                                                          });
                                                                      msg = userdata
                                                                          .message!;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(
          context)
          .showSnackBar(
          SnackBar(
              content: Text(
                  msg)));
    });
                                                                      return My_active_booking(
                                                                        id: widget.booking_id,
                                                                      );
                                                                    } else {
    msg = userdata!.message.toString();
    SchedulerBinding.instance.addPostFrameCallback((_) {ScaffoldMessenger.of(
    context)
        .showSnackBar(
    SnackBar(
    content: Text(
    msg)));
    });
                                                                      return Booking_process_profile_home_care(
                                                                        booking_id:
                                                                            widget.booking_id,
                                                                        userid:
                                                                            widget.userid,
                                                                        old_slot:
                                                                            widget.old_slot,
                                                                      );
                                                                    }
                                                                  } else if (snapshot
                                                                      .hasError) {
                                                                    return Text(
                                                                        "${snapshot.error}");
                                                                  }
                                                                  return Container(
                                                                      height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height,
                                                                      color:
                                                                          white,
                                                                      child: Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            LinearProgressIndicator(
                                                                              backgroundColor: buttoncolor,
                                                                              valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                              minHeight: 5,
                                                                            )
                                                                          ]));
                                                                }),
                                                          ));
                                                      FocusScope.of(context).unfocus();
                                                      await Future.delayed(Duration(seconds: 2));
                                                      if (msg != '') {
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                          content: Text(msg),
                                                        ));
                                                      }
                                                    }
                                                    else {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  booking_process_homeCareService(
                                                                   // servicetype: data!.data!,

                                                                    slot_ids:
                                                                        slotids,
                                                                    slotdate:
                                                                        slotdate,
                                                                    amount: (data!.data!.nurse!.consultationFees ??
                                                                            0) *
                                                                        (slotids
                                                                            .length),
                                                                    name: data!
                                                                            .data!
                                                                            .nurse!
                                                                            .name ??
                                                                        "",
                                                                    profile_pic: data!
                                                                            .data!
                                                                            .nurse!
                                                                            .profilePic ??
                                                                        "",
                                                                    qualification: data!
                                                                            .data!
                                                                            .nurse!
                                                                            .qualification ??
                                                                        "",
                                                                    experience: data!
                                                                            .data!
                                                                            .nurse!
                                                                            .experience
                                                                            .toString() ??
                                                                        "",
                                                                    specialization: data!
                                                                            .data!
                                                                            .nurse!
                                                                            .specialization ??
                                                                        "",
                                                                  )));
                                                    }

                                                    // await Future.delayed(Duration(seconds: 2));
                                                    // if (msg != '') {
                                                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                    //     content: Text(msg),
                                                    //   ));
                                                    // }

                                                  }),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "₹" +
                                              ((data!.data!.nurse!
                                                              .consultationFees??0) *
                                                      (slotids.length))
                                                  .toString(),
                                          style: TextStyle(
                                              color: darkgrey,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: MaterialButton(
                                              color: buttoncolor,
                                              elevation: 0,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 20),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  side: BorderSide(
                                                      color: buttoncolor,
                                                      width: 0.5)),
                                              child: Text(
                                                "Book",
                                                style: TextStyle(
                                                    color: pwhite,
                                                    fontSize: 16),
                                              ),
                                              onPressed: () async {
                                                String msg = '';
                                                SharedPreferences pref =
                                                    await SharedPreferences
                                                        .getInstance();

                                                if (location1 == "Full day" &&
                                                    slotids.length <= 0) {
                                                  msg = 'Slot not available';
                                                 SchedulerBinding.instance.addPostFrameCallback((_) {
                                                    ScaffoldMessenger.of(
                                                      context)
                                                      .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              msg)));
                                                 });
                                                } else if (widget.booking_id !=
                                                    null) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => FutureBuilder<
                                                                reschedule_model>(
                                                            future: rescheduleC(
                                                                widget
                                                                    .booking_id!,
                                                                data!
                                                                        .data!
                                                                        .slots![
                                                                            i]
                                                                        .date ??
                                                                    "",
                                                                widget
                                                                    .old_slot!,
                                                                slotids[0]),
                                                            builder:
                                                                (BuildContext
                                                                        context,
                                                                    snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                final userdata =
                                                                    snapshot
                                                                        .data;
                                                                if (userdata!
                                                                        .success == true) {
                                                                  msg ="Reschedule successfully";
                                                                  SchedulerBinding.instance.addPostFrameCallback((_) {
                                                                    ScaffoldMessenger
                                                                        .of(
                                                                        context)
                                                                        .showSnackBar(
                                                                        SnackBar(
                                                                            content: Text(
                                                                                msg)));
                                                                  });
                                                                  return My_active_booking(
                                                                    id: widget
                                                                        .booking_id,
                                                                  );
                                                                } else {
                                                                  msg = userdata
                                                                      .message!;
                                                                  SchedulerBinding.instance.addPostFrameCallback((_) {
                                                                    ScaffoldMessenger
                                                                        .of(
                                                                        context)
                                                                        .showSnackBar(
                                                                        SnackBar(
                                                                            content: Text(
                                                                                msg)));
                                                                  });
                                                                  return Booking_process_profile_home_care(
                                                                    booking_id:
                                                                        widget
                                                                            .booking_id,
                                                                    userid: widget
                                                                        .userid,
                                                                    old_slot: widget
                                                                        .old_slot,
                                                                  );
                                                                }
                                                              } else if (snapshot
                                                                  .hasError) {
                                                                return Text(
                                                                    "${snapshot.error}");
                                                              }
                                                              return Container(
                                                                  height: MediaQuery.of(
                                                                          context)
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
                                                                              AlwaysStoppedAnimation(Colors.white),
                                                                          minHeight:
                                                                              5,
                                                                        )
                                                                      ]));
                                                            }),
                                                      ));
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              booking_process_homeCareService(
                                                                slot_ids:
                                                                    slotids,
                                                                slotdate:
                                                                    slotdate,
                                                                amount: data!
                                                                        .data!
                                                                        .nurse!
                                                                        .consultationFees ??
                                                                    0,
                                                                name: data!
                                                                        .data!
                                                                        .nurse!
                                                                        .name ??
                                                                    "",
                                                                profile_pic: data!
                                                                        .data!
                                                                        .nurse!
                                                                        .profilePic ??
                                                                    "",
                                                                qualification: data!
                                                                        .data!
                                                                        .nurse!
                                                                        .qualification ??
                                                                    "",
                                                                experience: data!
                                                                        .data!
                                                                        .nurse!
                                                                        .experience
                                                                        .toString() ??
                                                                    "",
                                                                specialization: data!
                                                                        .data!
                                                                        .nurse!
                                                                        .specialization ??
                                                                    "",
                                                              )));
                                                }


                                                FocusScope.of(context).unfocus();
                                                await Future.delayed(Duration(seconds: 1));
                                                if (msg != '') {
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                    content: Text(msg),
                                                  ));
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ])
          : LinearProgressIndicator(),
    );
  }
}
