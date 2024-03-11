import 'package:fasttrack/models/faqmodel.dart';
import 'package:flutter/material.dart';
import '../api/faqclass.dart';
import '../style.dart';

class Faqs extends StatefulWidget {
  const Faqs({Key? key}) : super(key: key);

  @override
  _FaqsState createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
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
        title: Text('FAQs', style: TextBold),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<faqmodel>(
                future: faq(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    final userdata = snapshot.data;
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data?.data?.length,
                              itemBuilder: (BuildContext context, index) {
                                return Column(children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 0.0),
                                    child: ExpansionTile(
                                      iconColor: hinttext,
                                      collapsedIconColor: hinttext,
                                      backgroundColor: lightcolorblue,
                                      title: Text(
                                        userdata!.data![index].question!,
                                        style: TextStyle(
                                          color: buttoncolor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                            userdata!.data![index].answer!,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: text,
                                                fontWeight: FontWeight.w400),
                                            maxLines: 3,
                                            softWrap: true,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                ]);
                              }),
                        ]));
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: CircularProgressIndicator());
                }),


          ],
        ),
      ),
    );
  }
}
