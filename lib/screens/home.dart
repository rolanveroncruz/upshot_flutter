// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:upshot_flutter/data/frontliner_data.dart';
import 'package:upshot_flutter/data/manager_data.dart';
import 'package:upshot_flutter/shared/bottom_nav.dart';
import 'package:upshot_flutter/shared/sp_helper.dart';
import 'package:intl/intl.dart';
import '../data/feedback_journey.dart';
import '../shared/user_login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SPHelper helper = SPHelper();
  late UserLogin? ul;
  int? roleId = 0;
  late String greeting = " ";
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('EEE, LLL d');
  String? formattedDate;
  List<FLFeedbackJourney> allFlReceivedFb = [];
  List<EMFeedbackJourney> allFeedbackGiven = [];
  int totalJourneys = 0;

  _HomeScreenState() {
    formattedDate = formatter.format(now);
  }
  @override
  void initState() {
    helper.init();
    ul = helper.readUserLogin();
    greeting = "${getGoodGreet()}, ${ul?.name}";
    super.initState();
    roleId = ul?.roleId;
    if (roleId == 1 || roleId == 3) {
      FLDataService flds = FLDataService();
      flds
          .getAllSubmittedJourneys()
          .then((value) => completedReceivingFLData(value));
      if (roleId == 2 || roleId == 3) {
        ManagerDataService mds = ManagerDataService();
        mds
            .getAllFeedbackGiven()
            .then((value) => completedReceivingAllFeedbackGiven(value));
      }
    }
  }

  void completedReceivingFLData(List<FLFeedbackJourney> value) {
    allFlReceivedFb = value;
    setState(() => totalJourneys += allFlReceivedFb.length);
    print("All Feedback Received Length is: ${allFlReceivedFb.length}");
    print("Total Journeys is: $totalJourneys");
  }

  void completedReceivingAllFeedbackGiven(List<EMFeedbackJourney> value) {
    allFeedbackGiven = value;
    setState(() => {totalJourneys += allFeedbackGiven.length});
    print("All Feedback Given is: ${allFeedbackGiven.length}");
    print("Total Journeys is: $totalJourneys");
  }

  String getGoodGreet() {
    if (now.hour > 18) {
      return "Good Evening";
    } else if (now.hour > 12) {
      return "Good Afternoon";
    } else {
      return "Good Morning";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(greeting), automaticallyImplyLeading: false),
        body: Column(children: [
          Container(
              padding: const EdgeInsets.only(top: 20),
              child:
                  Text(formattedDate!, style: const TextStyle(fontSize: 20))),
          Container(
              padding: const EdgeInsets.all(30.0),
              child: const Text("Hello there! Ready to start the day?",
                  style: TextStyle(fontSize: 32))),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: ElevatedButton(
                      onPressed: () => gotoOngoingJourneys(),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                      child: Text(" Ongoing Journeys: $totalJourneys"))),
            ],
          )
        ]),
        bottomNavigationBar: const UpshotBottomNav(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ));
  }

  void gotoOngoingJourneys() {
    Navigator.pushNamed(context, '/ongoing');
  }
}
