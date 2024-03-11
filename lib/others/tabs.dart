import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../style.dart';

class NewEntryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewEntryPageState();
}

class NewEntryPageState extends State<NewEntryPage>
    with SingleTickerProviderStateMixin {


  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height*0.30,
          //margin: EdgeInsets.symmetric(vertical: 20.0),
          padding: const EdgeInsets.only(left: 15,right: 15),
          //color: Colors.white,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios,color: arrow,),
                      onPressed: () {
                        if (_tabController.index > 0) {
                          _tabController.animateTo(_tabController.index - 1);
                        }
                      },
                    ),
                    Expanded(
                      child: TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        labelStyle: TextStyle(color: tabs),
                        unselectedLabelColor: tabs,
                        labelColor: Colors.transparent,
                        tabs: List.generate(5,
                              (index) {
                            return Tab(height: 80,
                              child: Container(
                              height: MediaQuery.of(context).size.height*0.20,
                              width: 150,
                                decoration: BoxDecoration(color: lightb,
                                  borderRadius: BorderRadius.circular(10),

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                          index==0?"Today, ":index==1?"Tomorrow, ":"",style: TextStyle(fontSize: 12,color: text,fontWeight: FontWeight.w500),
                                          ),
                                    Text(
                                      DateFormat("dd MMMM").format(
                                    new DateTime.now().add(new Duration(days: index))),
                                          style: TextStyle(fontSize: 12,color: text,fontWeight: FontWeight.w500),),

                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Text("0 Slots Available",style: TextStyle(fontSize: 12,color: green,fontWeight: FontWeight.w500),)
                                  ],),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios,color: arrow,),
                      onPressed: () {
                        if (_tabController.index + 1 < 50) {
                          _tabController.animateTo(_tabController.index + 1);
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Can't move forward"),
                          ));
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
    );
  }
}
