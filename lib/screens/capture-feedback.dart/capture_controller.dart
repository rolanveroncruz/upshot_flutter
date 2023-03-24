import 'package:flutter/material.dart';
import 'package:upshot_flutter/screens/capture-feedback.dart/choose_dr.dart';

class CaptureController extends StatelessWidget {
  final PageController _controller = PageController();

  CaptureController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Give Feedback"),
          actions: <Widget>[
            TextButton(
                onPressed: () => closetoSave(context),
                child:
                    const Text("Cancel", style: TextStyle(color: Colors.white)))
          ],
        ),
        body: SafeArea(
            child: PageView(
          controller: _controller,
          children: const [ChooseDR()],
        )));
  }

  void closetoSave(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 300,
              color: Colors.white,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Modal BottomSheet'),
                  ElevatedButton(
                    child: const Text('Close BottomSheet'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )));
        });
  }
}
