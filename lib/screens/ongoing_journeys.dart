import 'package:flutter/material.dart';

class OngoingJourneys extends StatefulWidget {
  const OngoingJourneys({super.key});

  @override
  State<OngoingJourneys> createState() => _OngoingJourneysState();
}

class _OngoingJourneysState extends State<OngoingJourneys> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text("Ongoing Journeys",
            style: TextStyle(fontStyle: FontStyle.italic)));
  }
}
