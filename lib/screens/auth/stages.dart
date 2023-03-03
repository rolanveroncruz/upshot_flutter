import 'package:flutter/material.dart';
import 'package:upshot_flutter/screens/auth/signup.dart';

class PreAuth extends StatelessWidget {
  final PageController _controller = PageController();
  final VoidCallback goLogin;
  final VoidCallback goSignUp;
  PreAuth({Key? key, required this.goLogin, required this.goSignUp})
      : super(key: key);

  void skipToEnd() {
    _controller.animateToPage(4,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
  }

  void next() {
    var nextpage = _controller.page?.toInt() ?? 0;
    nextpage += 1;
    _controller.animateToPage(nextpage,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(

        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: _controller,
        children: [
          PageZero(
            skipToEnd: skipToEnd,
            next: next,
            goLogin: goLogin,
            goSignUp: goSignUp,
          ),
          PageOne(
            skipToEnd: skipToEnd,
          ),
          PageTwo(
            skipToEnd: skipToEnd,
          ),
          PageThree(skipToEnd: skipToEnd),
          LastPage(goLogin: goLogin, goSignUp: goSignUp),
        ]);
  }
}

class PageZero extends StatelessWidget {
  VoidCallback next;
  VoidCallback skipToEnd;
  VoidCallback goLogin;
  VoidCallback goSignUp;
  PageZero(
      {Key? key,
      required this.skipToEnd,
      required this.next,
      required this.goLogin,
      required this.goSignUp})
      : super(key: key);
  void signUp() {}
  void login() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                  text: const TextSpan(children: [
                TextSpan(
                    text: "What if you can track your own ",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 37)),
                TextSpan(
                    text: "leadership peformance?",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 37))
              ])),
            ),
            const SizedBox(height: 250),
            ElevatedButton(
                onPressed: next,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(350, 40)),
                child:
                    const Text("Tell Me More", style: TextStyle(fontSize: 20))),
            ElevatedButton(
                onPressed: goSignUp,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(350, 40)),
                child: const Text("Sign Up", style: TextStyle(fontSize: 20))),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                GestureDetector(
                  onTap: goLogin,
                  child: const Text('Login In',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                )
              ],
            )
          ],
        ),
      )),
    ));
  }
}

class PageOne extends StatelessWidget {
  VoidCallback skipToEnd;
  PageOne({Key? key, required this.skipToEnd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const SizedBox(height: 100),
      SizedBox(
        width: double.infinity,
        child: Text(
          "Upshot can help.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.grey.shade800,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 100),
      GestureDetector(
          onTap: skipToEnd,
          child: const Text("Skip",
              style: TextStyle(color: Colors.blue, fontSize: 20)))
    ])));
  }
}

class PageTwo extends StatelessWidget {
  VoidCallback? skipToEnd;
  PageTwo({Key? key, this.skipToEnd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const SizedBox(height: 100),
      SizedBox(
        width: double.infinity,
        child: Text(
          "Act your way to better leadership through guilded practice.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.grey.shade800,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 100),
      GestureDetector(
          onTap: skipToEnd,
          child: const Text("Skip",
              style: TextStyle(color: Colors.blue, fontSize: 20)))
    ])));
  }
}

class PageThree extends StatelessWidget {
  VoidCallback? skipToEnd;
  PageThree({Key? key, required this.skipToEnd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const SizedBox(height: 100),
      SizedBox(
        width: double.infinity,
        child: Text(
          "Sharpen your skills based on real time performance scores.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.grey.shade800,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 100),
      GestureDetector(
          onTap: () => {},
          child: const Text("Skip",
              style: TextStyle(color: Colors.blue, fontSize: 20)))
    ])));
  }
}

class LastPage extends StatelessWidget {
  VoidCallback goLogin;
  VoidCallback goSignUp;
  LastPage({Key? key, required this.goLogin, required this.goSignUp})
      : super(key: key);
  void signUp() {}
  void login() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Welcome to Upshot",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 37)),
            ),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                  'Thanks for giving Upshot a shot! Let\'s get started by creating your account.',
                  style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 250),
            ElevatedButton(
                onPressed: goSignUp,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(350, 40)),
                child: const Text("Sign Up", style: TextStyle(fontSize: 20))),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                GestureDetector(
                  onTap: goLogin,
                  child: const Text('Login In',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                )
              ],
            )
          ],
        ),
      )),
    ));
  }
}
