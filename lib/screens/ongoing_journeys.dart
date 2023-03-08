import 'package:flutter/material.dart';
import 'package:upshot_flutter/data/feedback_journey.dart';
import 'package:upshot_flutter/data/frontliner_data.dart';
import 'package:upshot_flutter/data/manager_data.dart';
import 'package:upshot_flutter/data/user_login.dart';
import 'package:upshot_flutter/shared/sp_helper.dart';
import 'package:emojis/emojis.dart';

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
            // if roleId is FLEM, then two lists are created.
            // else, just one.
            child: roleId == UserRoles.FLEM.index
                ? _twoListColumn()
                : _oneListColumn()));
  }

  Widget _oneListColumn() {
    // The _oneListColumn generates just one long list eihter for an
    // EM only role or FL only role.
    listOneCount = roleId == UserRoles.EM.index
        ? allFeedbackGiven.length
        : allFlReceivedFb.length;
    var headerString = roleId == UserRoles.EM.index
        ? "FEEDBACK CREATED ($listOneCount)"
        : "FEEDBACK RECEIVED ($listOneCount)";
    return Column(children: [
      // One List: Header
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: GestureDetector(
            onTap: () => setState(() {
                  listOneCollapsed = !listOneCollapsed;
                }),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(headerString,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Icon(listOneCollapsed ? Icons.expand_less : Icons.expand_more)
            ])),
      ),
      //One List: list
      Expanded(
          child: listOneCollapsed
              ? const Center(child: Text(" "))
              : _buildOneList())
    ]);
  }

  Widget _twoListColumn() {
    // _twoListColumn is exclusively for FLEMs: the top list will always
    // be a list of created by EM feedback, and the second will always be
    // received by FL feedback.
    listOneCount = allFeedbackGiven.length;
    listTwoCount = allFlReceivedFb.length;
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
              : _buildListViewOneOfTwo()),

      const SizedBox(height: 30),
      // List Two Header
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: GestureDetector(
            onTap: () => setState(() {
                  listTwoCollapsed = !listTwoCollapsed;
                }),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("FEEDBACK RECEIVED($listTwoCount)",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Icon(listTwoCollapsed ? Icons.expand_less : Icons.expand_more)
            ])),
      ),
      //List Two List
      Expanded(
          child: SizedBox(
              height: 300,
              child: listTwoCollapsed
                  ? const Center(child: Text(" "))
                  : _buildListViewTwoOfTwo())),
    ]);
  }

  Widget _buildListViewOneOfTwo() {
    // _buldListViewOneOfTWo is for building the top list in a two-list ongoing-journeys page.
    // two-list page only happens when the user has UserRoles.FLEM.
    // The top role is always an EM list.
    return ListView.builder(
      itemCount: allFeedbackGiven.length,
      itemBuilder: emItemBuilder,
    );
  }

  Widget _buildListViewTwoOfTwo() {
    return ListView.builder(
      itemCount: allFlReceivedFb.length,
      itemBuilder: flItemBuilder,
    );
  }

  Widget? emItemBuilder(BuildContext context, dynamic index) {
    EMFeedbackJourney journey = allFeedbackGiven[index];
    var splitEMname = journey.frontlinerName.split(' ');
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
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(journey.frontlinerName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(children: [
          Text(
              journey.feedbackType == "Positive"
                  ? "${Emojis.greenHeart} ${journey.feedbackType} "
                  : "${Emojis.fountainPen} ${journey.feedbackType}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: journey.feedbackType == "Positive"
                      ? Colors.green
                      : Colors.red)),
          Text(journey.requiresFace2Face ? " .  1-on-1" : " . Async",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ]),
        Text(
            "${journey.generalTopic} ${Emojis.backhandIndexPointingRight} ${journey.subTopic}"),
      ]),
      trailing: const Icon(Icons.chevron_right_outlined),
    ));
  }

  Widget? flItemBuilder(BuildContext context, dynamic index) {
    FLFeedbackJourney journey = allFlReceivedFb[index];
    var splitEMname = journey.emName.split(' ');
    var emAvatar = splitEMname[0][0] + splitEMname[splitEMname.length - 1][0];
    return Card(
        child: ListTile(
      leading: CircleAvatar(
          backgroundColor: Colors.blueAccent, child: Text(emAvatar)),
      title: const Text("VIEW FEEDBACK",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontSize: 13)),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(journey.emName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(children: [
          Text(
              journey.feedbackType == "Positive"
                  ? "${Emojis.greenHeart} ${journey.feedbackType} "
                  : "${Emojis.fountainPen} ${journey.feedbackType}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: journey.feedbackType == "Positive"
                      ? Colors.green
                      : Colors.red)),
          Text(journey.requiresFaceToFace ? " .  1-on-1" : " . Async",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ]),
        Text(
            "${journey.generalTopic} ${Emojis.backhandIndexPointingRight} ${journey.subTopic}"),
      ]),
      trailing: const Icon(Icons.chevron_right_outlined),
    ));
  }

  Widget _buildOneList() {
    if (roleId == UserRoles.FL.index) {
      return ListView.builder(
        itemCount: allFlReceivedFb.length,
        itemBuilder: flItemBuilder,
      );
    } else {
      return ListView.builder(
        itemCount: allFeedbackGiven.length,
        itemBuilder: emItemBuilder,
      );
    }
  }
}
