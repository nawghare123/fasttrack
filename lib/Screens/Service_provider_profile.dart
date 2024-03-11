import 'package:fasttrack/Screens/My_active_booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/doctor_profile_slots_class.dart';
import '../api/reschedule_class.dart';
import '../blocs/application_bloc.dart';
import '../models/doctor_profile_slots_model.dart';
import '../models/reschedule_model.dart';
import '../others/tabs.dart';
import '../style.dart';
import 'Booking Process - Teleconsultancy.dart';
import 'booking_details.dart';

class service_provider_profile extends StatefulWidget {
  service_provider_profile(
      {Key? key, this.user_id, this.old_slot, this.booking_id})
      : super(key: key);

  DateTime datetime = DateTime.now();
  String? user_id;
  List<dynamic>? old_slot;
  int? booking_id;

  @override
  _service_provider_profileState createState() =>
      _service_provider_profileState();
}

class _service_provider_profileState extends State<service_provider_profile>
    with TickerProviderStateMixin {
  TabController? _tabController;
 // GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int? TotalAmount;

  DateTime date = DateTime.now();

  doctor_profile_slots_model? data;

  void initState() {
    super.initState();
    loaddoctor();
  }

  void loaddoctor() async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    await applicationBloc.doctorProfile(widget.user_id!);

    setState(() {
      data = applicationBloc.doctorsProfileSlots;
      print(data!.data!.doctor!.name);
      if(data!.data!.slots!.length>0) {
        date = DateTime.parse(data!.data!.slots![0].date!);
        _tabController =
            TabController(vsync: this, length: data!.data!.slots!.length);
      }
    });
  }
  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
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
          title: Text('Select Time Slot', style: TextBold),
        ),
        body: (data != null)
            ? Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [
                        Container(
                          color: greenlight,
                          //height: MediaQuery.of(context).size.height*10,
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
                                        child:
                                            (data!.data!.doctor!.profilePic !=
                                                    null)
                                                ? Image.network(data!.data!
                                                        .doctor!.profilePic ??
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
                                            data!.data!.doctor!.name ?? "",
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
                                                data!.data!.doctor!
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
                                                data!.data!.doctor!
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
                                                ((data!.data!.doctor!
                                                                .experience ??
                                                            0)
                                                        .toString())
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: hinttext,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          // Row(mainAxisAlignment: MainAxisAlignment.start,
                                          //   children: [
                                          //     Image(image: AssetImage("asset/images/done2.png"),height: 10,),
                                          //     SizedBox(width: 5,),
                                          //     Text ("96%",style: TextStyle(
                                          //       fontSize: 12,
                                          //       color: green,
                                          //     ),),
                                          //     Text(
                                          //       data!.data!.doctor!.bio!,
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
                                //               text: (data!.data!.doctor!.bio ??
                                //                               "")
                                //                           .length >
                                //                       20
                                //                   ? data!.data!.doctor!.bio!
                                //                       .substring(0, 20)
                                //                   : (data!.data!.doctor!.bio ??
                                //                       ""),
                                //               //  (data!.data!.nurse!.bio!.length>20)?
                                //               style: TextStyle(
                                //                   fontSize: 12,
                                //                   color: hinttext),
                                //               children: [
                                //                 ((data!.data!.doctor!.bio ?? '')
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
                                  "Consultation Charge",
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
                                      ((data!.data!.doctor!.consultationFees ??
                                                  0)
                                              .toString())
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
                        SizedBox(height: 10,),
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
                                                                          DateFormat("dd MMM yyyy").format(DateTime.parse(data!
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
                                                                      "(${data!.data!.slots![index].mornings!.length + data!.data!.slots![index].afternoons!.length + data!.data!.slots![index].evenings!.length} Slots Available)",
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
                                                    if (_tabController!.index +
                                                            1 <
                                                        data!.data!.slots!.length) {
                                                      _tabController!.animateTo(
                                                          _tabController!
                                                                  .index +
                                                              1);
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Center(child:Text("No Slots Availble")),
                        for (int i = 0; i < data!.data!.slots!.length; i++)
                          if (DateFormat("yyyy-MM-dd").format(DateTime.parse(
                                  data!.data!.slots![i].date!)) ==
                              DateFormat("yyyy-MM-dd").format(date))
                            Container(
                              width: MediaQuery.of(context).size.width * 100,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    if (data!.data!.slots![i].mornings !=
                                            null &&
                                        data!.data!.slots![i].mornings!.length >
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
                                                ("Mornings").toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                const EdgeInsets.only(top: 5),
                                            child: GridView(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 5,
                                                      mainAxisSpacing: 5,
                                                      mainAxisExtent: 40),
                                              children: [
                                                for (int j = 0;
                                                    j <
                                                        data!.data!.slots![i]!
                                                            .mornings!.length;
                                                    j++)
                                                  OutlinedButton(
                                                      style: OutlinedButton.styleFrom(
                                                          backgroundColor: (data!
                                                                      .data!
                                                                      .slots![i]
                                                                      .mornings![
                                                                          j]
                                                                      .status ==
                                                                  'Available'
                                                              ? blue
                                                              : hinttext),
                                                          side: BorderSide(
                                                              width: 0.5,
                                                              color: border)),
                                                      onPressed: ()   {
                                                        setState(()   async {
                                                          String msg = "";
                                                          SharedPreferences pref =
                                                          await SharedPreferences
                                                              .getInstance();
                                                          if (widget
                                                                  .booking_id !=
                                                              null) {
                                                            Navigator
                                                                .pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) => FutureBuilder<
                                                                              reschedule_model>(
                                                                          future: rescheduleC(
                                                                              widget.booking_id!,
                                                                              data!.data!.slots![i].date ?? "",
                                                                              widget.old_slot!,
                                                                              data!.data!.slots![i].mornings![j].id!),
                                                                          builder: (BuildContext context, snapshot) {
                                                                            if (snapshot.hasData) {
                                                                              final userdata = snapshot.data;
                                                                              if (userdata!.success == true) {
    msg = userdata.message.toString();
    SchedulerBinding.instance.addPostFrameCallback((_) {ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
    content: Text(msg),
    ));
    });
                                                                                return My_active_booking(
                                                                                  id: widget.booking_id,
                                                                                );
                                                                              } else {
    msg = userdata.message.toString();
    SchedulerBinding.instance.addPostFrameCallback((_) {   ScaffoldMessenger.of(
    context)
        .showSnackBar(
    SnackBar(
    content: Text(
    msg)));
    });
                                                                                return service_provider_profile(
                                                                                  booking_id: widget.booking_id,
                                                                                  user_id: widget.user_id,
                                                                                  old_slot: widget.old_slot,
                                                                                );
                                                                              }
                                                                            } else if (snapshot.hasError) {
                                                                              return Text("${snapshot.error}");
                                                                            }

                                                                            return Container(
                                                                                height: MediaQuery.of(context).size.height,
                                                                                color: white,
                                                                                child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                  LinearProgressIndicator(
                                                                                    backgroundColor: buttoncolor,
                                                                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                    minHeight: 5,
                                                                                  )
                                                                                ]));
                                                                          }),
                                                                    ));

                                                          } else {
                                                            if (data!
                                                                    .data!
                                                                    .slots![i]
                                                                    .mornings![
                                                                        j]
                                                                    .status ==
                                                                'Available')
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          booking_process(

                                                                            slot_id:
                                                                                data!.data!.slots![i].mornings![j].id!.toString(),
                                                                            amount:
                                                                                data!.data!.doctor!.consultationFees ?? 0,
                                                                            slotdate:
                                                                                data!.data!.slots![i].date!.toString(),
                                                                            name:
                                                                                data!.data!.doctor!.name ?? "",
                                                                            profile_pic:
                                                                                data!.data!.doctor!.profilePic ?? "",
                                                                            start_time:
                                                                                data!.data!.slots![i].mornings![j].startTime ?? "",
                                                                            qualification:
                                                                                data!.data!.doctor!.qualification ?? "",
                                                                            experience:
                                                                                data!.data!.doctor!.experience.toString() ?? "",
                                                                            specialization:
                                                                                data!.data!.doctor!.specialization ?? "",
                                                                          )));
                                                          }
                                                          FocusScope.of(context).unfocus();
                                                          await Future.delayed(Duration(seconds: 2));
                                                          if (msg != '') {
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                              content: Text(msg),
                                                            ));
                                                          }
                                                        });


                                                      },
                                                      child: Text(
                                                        DateFormat("hh:mm a").format(
                                                                DateTime.parse("2022-07-01T" +
                                                                    data!
                                                                        .data!
                                                                        .slots![
                                                                            i]
                                                                        .mornings![
                                                                            j]
                                                                        .startTime!)) ??
                                                            '',
                                                        style: TextStyle(
                                                            color: (data!
                                                                        .data!
                                                                        .slots![
                                                                            i]
                                                                        .mornings![
                                                                            j]
                                                                        .status ==
                                                                    'Available'
                                                                ? pwhite
                                                                : pwhite)),
                                                      )),
                                              ],
                                              padding: EdgeInsets.all(10),
                                              shrinkWrap: true,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    if (data!.data!.slots![i].afternoons !=
                                            null &&
                                        data!.data!.slots![i].afternoons!
                                                .length >
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
                                                "Afternoons",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                const EdgeInsets.only(top: 5),
                                            child: GridView(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 5,
                                                      mainAxisSpacing: 5,
                                                      mainAxisExtent: 40),
                                              children: [
                                                for (int j = 0;
                                                    j <
                                                        data!.data!.slots![i]
                                                            .afternoons!.length;
                                                    j++)
                                                  OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      backgroundColor: (
                                                          data!.data!.slots![i].afternoons![j].status == 'Available'
                                                          ? blue
                                                          : hinttext),
                                                      side: BorderSide(
                                                          width: 0.5,
                                                          color: border),
                                                    ),
                                                    onPressed: () {
                                                      setState(()  async {
                                                        String msg = "";
                                                        SharedPreferences pref =
                                                            await SharedPreferences
                                                            .getInstance();
                                                        if (widget.booking_id !=
                                                            null) {
                                                          Navigator
                                                              .pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => FutureBuilder<
                                                                            reschedule_model>(
                                                                        future: rescheduleC(
                                                                            widget
                                                                                .booking_id!,
                                                                            data!.data!.slots![i].date ??
                                                                                "",
                                                                            widget.old_slot!,
                                                                            data!.data!.slots![i].afternoons![j].id!),
                                                                        builder: (BuildContext context, snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            final userdata =
                                                                                snapshot.data;
                                                                            if (userdata!.success ==
                                                                                true) {
                                                                              msg =
                                                                                  userdata!
                                                                                      .message
                                                                                      .toString();
                                                                              SchedulerBinding.instance.addPostFrameCallback((_) {       ScaffoldMessenger
                                                                                  .of(
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
                                                                              msg = userdata.message.toString();
                                                                              SchedulerBinding.instance.addPostFrameCallback((_) {ScaffoldMessenger.of(context)
                                                                                  .showSnackBar(SnackBar(
                                                                                content: Text(msg),
                                                                              ));
                                                                              });

                                                                              return service_provider_profile(
                                                                                booking_id: widget.booking_id,
                                                                                user_id: widget.user_id,
                                                                                old_slot: widget.old_slot,
                                                                              );
                                                                            }
                                                                          } else if (snapshot
                                                                              .hasError) {
                                                                            return Text("${snapshot.error}");
                                                                          }

                                                                          return Container(
                                                                              height: MediaQuery.of(context).size.height,
                                                                              color: white,
                                                                              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                LinearProgressIndicator(
                                                                                  backgroundColor: buttoncolor,
                                                                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                  minHeight: 5,
                                                                                )
                                                                              ]));
                                                                        }),

                                                                  ));

                                                        }
                                                        else {
                                                          if (data!
                                                                  .data!
                                                                  .slots![i]
                                                                  .afternoons![
                                                                      j]
                                                                  .status ==
                                                              'Available')
                                                            Navigator
                                                                .pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            booking_process(

                                                                              slot_id: data!.data!.slots![i].afternoons![j].id!.toString(),
                                                                              slotdate: data!.data!.slots![i].date!.toString() ?? "",
                                                                              name: data!.data!.doctor!.name ?? "",
                                                                              profile_pic: data!.data!.doctor!.profilePic ?? '',
                                                                              amount: data!.data!.doctor!.consultationFees ?? 0,
                                                                              start_time: data!.data!.slots![i].afternoons![j].startTime ?? "",
                                                                              qualification: data!.data!.doctor!.qualification ?? "",
                                                                              experience: data!.data!.doctor!.experience.toString()??'',
                                                                              specialization: data!.data!.doctor!.specialization ?? "",
                                                                            ))
                                                            );
                                                        }

                                                        FocusScope.of(context).unfocus();
                                                        await Future.delayed(Duration(seconds: 2));
                                                        if (msg != '') {
                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                            content: Text(msg),
                                                          ));
                                                        }
                                                      });


                                                    },
                                                    child: Text(
                                                      DateFormat("hh:mm a").format(
                                                              DateTime.parse(
                                                                  "2022-07-01T" +
                                                                      data!
                                                                          .data!
                                                                          .slots![
                                                                              i]
                                                                          .afternoons![
                                                                              j]
                                                                          .startTime!)) ??
                                                          "",
                                                      style: TextStyle(
                                                          color: (data!
                                                                      .data!
                                                                      .slots![i]
                                                                      .afternoons![
                                                                          j]
                                                                      .status ==
                                                                  'Available'
                                                              ? pwhite
                                                              : pwhite)),
                                                    ),
                                                  ),
                                              ],
                                              padding: EdgeInsets.all(10),
                                              shrinkWrap: true,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    if (data!.data!.slots![i].evenings !=
                                            null &&
                                        data!.data!.slots![i].evenings!.length >
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
                                                "Evenings",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                const EdgeInsets.only(top: 5),
                                            child: GridView(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 5,
                                                      mainAxisSpacing: 5,
                                                      mainAxisExtent: 40),
                                              children: [
                                                for (int j = 0;
                                                    j <
                                                        data!.data!.slots![i]!
                                                            .evenings!.length;
                                                    j++)


                                                  OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        backgroundColor: (data!
                                                                    .data!
                                                                    .slots![i]
                                                                    .evenings![
                                                                        j]
                                                                    .status ==
                                                                'Available'
                                                            ? blue
                                                            : hinttext),
                                                        side: BorderSide(
                                                            color: border),
                                                      ),
                                                      onPressed: ()   {
                                                        setState(() async {
                                                          String msg = "";
                                                          SharedPreferences pref =
                                                          await SharedPreferences
                                                              .getInstance();
                                                          if (widget
                                                              .booking_id !=
                                                              null) {
                                                            Navigator
                                                                .pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => FutureBuilder<
                                                                      reschedule_model>(
                                                                      future: rescheduleC(
                                                                          widget.booking_id!,
                                                                          data!.data!.slots![i].date ?? "",
                                                                          widget.old_slot!,
                                                                          data!.data!.slots![i].evenings![j].id!),
                                                                      builder: (BuildContext context, snapshot) {
                                                                        if (snapshot.hasData) {
                                                                          final userdata = snapshot.data;
                                                                          if (userdata!.success == true) {
                                                                            msg = userdata.message.toString();
    SchedulerBinding.instance.addPostFrameCallback((_) {  ScaffoldMessenger.of(
                                                                                context)
                                                                                .showSnackBar(
                                                                                SnackBar(
                                                                                    content: Text(
                                                                                        msg)));});
                                                                            return My_active_booking(
                                                                              id: widget.booking_id,
                                                                            );
                                                                          } else {
                                                                            msg = userdata.message.toString();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(
          context)
          .showSnackBar(
          SnackBar(
              content: Text(
                  msg)));
    });
                                                                            return service_provider_profile(
                                                                              booking_id: widget.booking_id,
                                                                              user_id: widget.user_id,
                                                                              old_slot: widget.old_slot,
                                                                            );
                                                                          }
                                                                        } else if (snapshot.hasError) {
                                                                          return Text("${snapshot.error}");
                                                                        }

                                                                        return Container(
                                                                            height: MediaQuery.of(context).size.height,
                                                                            color: white,
                                                                            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                              LinearProgressIndicator(
                                                                                backgroundColor: buttoncolor,
                                                                                valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                minHeight: 5,
                                                                              )
                                                                            ]));
                                                                      }

                                                                  ),


                                                                )
                                                            );


                                                          } else {
                                                            if (data!
                                                                .data!
                                                                .slots![i]
                                                                .evenings![j]
                                                                .status ==
                                                                'Available')
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          booking_process(
                                                                            slot_id:
                                                                            data!.data!.slots![i].evenings![j].id!.toString(),
                                                                            amount:
                                                                            data!.data!.doctor!.consultationFees ?? 0,
                                                                            slotdate:
                                                                            data!.data!.slots![i].date!.toString(),
                                                                            name:
                                                                            data!.data!.doctor!.name ?? "",
                                                                            profile_pic:
                                                                            data!.data!.doctor!.profilePic ?? "",
                                                                            start_time:
                                                                            data!.data!.slots![i].evenings![j].startTime ?? "",
                                                                            qualification:
                                                                            data!.data!.doctor!.qualification ?? "",
                                                                            experience:
                                                                            data!.data!.doctor!.experience.toString() ?? "",
                                                                            specialization:
                                                                            data!.data!.doctor!.specialization ?? "",
                                                                          )));
                                                          }

                                                          FocusScope.of(context).unfocus();
                                                          await Future.delayed(Duration(seconds: 1));
                                                          if (msg != '') {
                                                            ScaffoldMessenger
                                                                .of(context)
                                                                .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                      msg),
                                                                ));
                                                          }

});
                                                        },
                                                            child: Text(
                                                            DateFormat("hh:mm a").format(
                                                            DateTime.parse("2022-07-01T" +
                                                                data!
                                                                    .data!
                                                                    .slots![
                                                                i]
                                                                    .evenings![
                                                                j]
                                                                    .startTime!)) ??
                                                            "",
                                                        style: TextStyle(
                                                        color: (data!
                                                            .data!
                                                            .slots![
                                                        i]
                                                            .evenings![
                                                        j]
                                                            .status ==
                                                        'Available'
                                                        ? pwhite: pwhite)),
                                                      )),

                                                // OutlinedButton(
                                                //     style: OutlinedButton.styleFrom(backgroundColor: fillcolor,
                                                //       side: BorderSide(width: 0.5,color: border1),),
                                                //
                                                //
                                                //
                                                //     onPressed: (){}, child: Text("06:15PM",style: TextStyle(color: blue),)),
                                              ],
                                              padding: EdgeInsets.all(10),
                                              shrinkWrap: true,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                        // if (widget.booking_id != null)
                        //     MaterialButton(
                        //
                        //     elevation: 0,
                        //     padding: EdgeInsets.symmetric(horizontal: 35),
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(5),
                        //         side: BorderSide(
                        //             color: buttoncolor, width: 0.5)),
                        //     child: Text(
                        //       "Reschedule",
                        //       style:
                        //           TextStyle(color: buttoncolor, fontSize: 15),
                        //     ),
                        //     onPressed: () {
                        //
                        //
                        //     }),
                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: MaterialButton(
                        //       color: buttoncolor,
                        //       elevation: 0,
                        //       padding: EdgeInsets.symmetric(
                        //           vertical: 15, horizontal: 20),
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(5),
                        //           side: BorderSide(
                        //               color: buttoncolor, width: 0.5)),
                        //       child: Text(
                        //         "Book",
                        //         style: TextStyle(color: pwhite, fontSize: 16),
                        //       ),
                        //       onPressed: () {})),
                      ]),
                    ],
                  ),
                )
              ])
            : LinearProgressIndicator());
  }
}
