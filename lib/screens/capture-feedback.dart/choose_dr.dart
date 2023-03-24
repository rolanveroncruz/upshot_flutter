import 'package:flutter/material.dart';
import 'package:upshot_flutter/data/feedback_journey.dart';

import '../../data/manager_data.dart';

class ChooseDR extends StatefulWidget {
  const ChooseDR({super.key});

  @override
  State<ChooseDR> createState() => _ChooseDRState();
}

class _ChooseDRState extends State<ChooseDR> {
  List<DropdownMenuItem<DirectReport>>? items;
  DirectReport? selectedValue;

  @override
  void initState() {
    super.initState();

    ManagerDataService mds = ManagerDataService();
    mds.getAllDirectReports().then((value) => setDRList(value));
  }

  void setDRList(List<DirectReport> value) {
    List<DropdownMenuItem<DirectReport>> theList = [];
    for (var i = 0; i < value.length; i++) {
      DirectReport dr = value[i];
      var splitDRName = dr.name.split(' ');
      var drAvatar = splitDRName[0][0] + splitDRName[splitDRName.length - 1][0];
      DropdownMenuItem<DirectReport> item = DropdownMenuItem(
          value: dr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                  backgroundColor: Colors.blueAccent, child: Text(drAvatar)),
              Text(dr.name)
            ],
          ));
      theList.add(item);
    }

    setState(() => items = theList);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          alignment: Alignment.center,
          child: const Text(
            "Who do you want to give feedback to?",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        DropdownButton(
          items: items,
          hint: const Text("Choose a direct report"),
          onChanged: onChangeDR,
          value: selectedValue,
          //isExpanded: true,
        ),
        const SizedBox(height: 100),
        putContinue(),
      ]),
    );
  }

  Widget putContinue() {
    if (selectedValue != null) {
      return ElevatedButton(onPressed: next, child: const Text("Continue"));
    } else {
      return const SizedBox(height: 10);
    }
  }

  void next() {}

  void onChangeDR(DirectReport? dr) {
    setState(() => selectedValue = dr);
    print("${selectedValue?.name} was selected.");
  }
}
