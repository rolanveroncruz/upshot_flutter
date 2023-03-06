import 'package:flutter/material.dart';
import 'package:upshot_flutter/data/feedback_journey.dart';
import 'package:upshot_flutter/data/frontliner_data.dart';
import 'package:upshot_flutter/data/manager_data.dart';
import 'package:upshot_flutter/data/user_login.dart';
import 'package:upshot_flutter/shared/sp_helper.dart';

class OngoingJourneys extends StatefulWidget {
  const OngoingJourneys({super.key});

  @override
  State<OngoingJourneys> createState() => _OngoingJourneysState();
}

class _OngoingJourneysState extends State<OngoingJourneys> {
  final SPHelper helper = SPHelper();
  late UserLogin? ul;
  int? roleId = 0;
  List<FLFeedbackJourney> allFlReceivedFb = [];
  List<EMFeedbackJourney> allFeedbackGiven = [];
  int listOneCount = 0;
  int listTwoCount = 0;
  bool listOneCollapsed = false;
  bool listTwoCollapsed = false;

  @override
  void initState() {
    helper.init();
    ul = helper.readUserLogin();
    super.initState();
    roleId = ul?.roleId;

    FLDataService flds = FLDataService();
    flds
        .getAllSubmittedJourneys()
        .then((value) => gotAllListFLReceivedFB(value));

    ManagerDataService mds = ManagerDataService();
    mds.getAllFeedbackGiven().then((value) => gotAllListEMGivenFB(value));
  }

  void gotAllListFLReceivedFB(value) {
    setState(() {
      allFlReceivedFb = value;
    });
  }

  void gotAllListEMGivenFB(value) {
    setState(() {
      allFeedbackGiven = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Ongoing Journeys")),
        body: SafeArea(
            child: roleId == UserRoles.FLEM.index
                ? _twoListColumn()
                : oneListColumn()));
  }

  Widget oneListColumn() {
    return Column(children: [
      // List One: Header
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: GestureDetector(
            onTap: () => setState(() {
                  listOneCollapsed = !listOneCollapsed;
                }),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("FEEDBACK CREATED ($listOneCount)",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Icon(listOneCollapsed ? Icons.expand_less : Icons.expand_more)
            ])),
      ),
      //List One: list
      Expanded(
          child: listOneCollapsed
              ? const Center(child: Text(" "))
              : _buildListOne())
    ]);
  }

  Widget _twoListColumn() {
    return Column(children: [
      // List One: Header
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: GestureDetector(
            onTap: () => setState(() {
                  listOneCollapsed = !listOneCollapsed;
                }),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("FEEDBACK CREATED ($listOneCount)",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Icon(listOneCollapsed ? Icons.expand_less : Icons.expand_more)
            ])),
      ),
      //List One: list
      Expanded(
          child: listOneCollapsed
              ? const Center(child: Text(" "))
              : _buildListOne()),

      const SizedBox(height: 30),
      // List Two Header
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: GestureDetector(
            onTap: () => setState(() {
                  listTwoCollapsed = !listTwoCollapsed;
                }),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("FEEDBACK RECEIVED($listOneCount)",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Icon(listTwoCollapsed ? Icons.expand_less : Icons.expand_more)
            ])),
      ),
      //List Two List
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: Expanded(
            child: SizedBox(
                height: 300,
                child: listTwoCollapsed
                    ? const Center(child: Text(" "))
                    : _buildListTwo())),
      ),
    ]);
  }

  Widget _buildListOne() {
    if (roleId == UserRoles.FL.index) {}
    return ListView.builder(
      itemCount: allFlReceivedFb.length,
      itemBuilder: flItemBuilder,
    );
  }

  Widget? flItemBuilder(BuildContext context, dynamic index) {
    FLFeedbackJourney journey = allFlReceivedFb[index];
    var splitEMname = journey.emName.split(' ');
    var emAvatar = splitEMname[0][0] + splitEMname[splitEMname.length - 1][0];
    return Card(
        child: ListTile(
      leading: CircleAvatar(
          backgroundColor: Colors.blueAccent, child: Text(emAvatar)),
      title: const Text("SENT FEEDBACK",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontSize: 13)),
      subtitle: Text(journey.emName,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.chevron_right_outlined),
    ));
  }

  Widget _buildListTwo() {
    return ListView.builder(
      itemCount: allFlReceivedFb.length,
      itemBuilder: emItemBuilder,
    );
  }

  Widget? emItemBuilder(BuildContext context, dynamic index) {
    FLFeedbackJourney journey = allFlReceivedFb[index];
    var splitEMname = journey.emName.split(' ');
    var emAvatar = splitEMname[0][0] + splitEMname[splitEMname.length - 1][0];
    return Card(
        child: ListTile(
      title: const Text("VIEW FEEDBACK",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.blueAccent)),
      leading: CircleAvatar(
          backgroundColor: Colors.blueAccent, child: Text(emAvatar)),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(journey.emName, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(" \u2764 \u1F49 ${journey.feedbackType} ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: journey.feedbackType == "Positive"
                    ? Colors.green
                    : Colors.red)),
        Text(journey.generalTopic)
      ]),
      trailing: const Icon(Icons.chevron_right_outlined),
    ));
  }
}
