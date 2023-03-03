import 'package:flutter/material.dart';
import 'package:upshot_flutter/screens/auth/login.dart';
import 'package:upshot_flutter/screens/auth/signup.dart';
import 'package:upshot_flutter/screens/auth/stages.dart';

enum Page { preauth, signUp, login }

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  Page _page = Page.preauth;

  void goLogin() {
    setState(() {
      _page = Page.login;
    });
  }

  void goSignUp() {
    setState(() {
      _page = Page.signUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_page) {
      case Page.preauth:
        return PreAuth(goLogin: goLogin, goSignUp: goSignUp);
      case Page.login:
        return Login(goSignup: goSignUp);
      case Page.signUp:
        return SignUp(
          goLogin: goLogin,
        );
    }
  }
}
