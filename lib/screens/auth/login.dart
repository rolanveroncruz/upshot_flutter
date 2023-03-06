import 'package:flutter/material.dart';
import 'package:upshot_flutter/data/api.dart';
import '../../shared/sp_helper.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';

class Login extends StatefulWidget {
  final VoidCallback goSignup;
  const Login({Key? key, required this.goSignup}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late FirebaseMessaging messaging;
  bool _passwordVisible = false;
  final SPHelper helper = SPHelper();
  final API api = API();
  String errorMessage = "";
  bool _isPasswordLongEnough = false;
  String? fcmToken;

  @override
  void initState() {
    super.initState();
    helper.init().then((value) {
      var userlogin = helper.readUserLogin();
      var userlogstr = json.encode(userlogin);
      // ignore: avoid_print
      print('In Login.initStte(), userlogin is $userlogstr');
      if (userlogin != null) {
        Navigator.pushNamed(context, '/home');
      }
      api.init();
    });
    // Firebase messaging stuff
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      fcmToken = value;
    });
  } // end of initState

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Upshot',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      obscureText: !_passwordVisible,
                      controller: passwordController,
                      onChanged: (theText) {
                        if (theText.length > 7) {
                          setState(() {
                            _isPasswordLongEnough = true;
                          });
                        } else {
                          setState(() {
                            _isPasswordLongEnough = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(_passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          )))),
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: _buildLoginButton()),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(fontSize: 15, color: Colors.red),
                  )),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password',
                ),
              ),
              Row(
                children: [
                  const Text('Does not have an account?'),
                  TextButton(
                      onPressed: widget.goSignup,
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              )
            ])));
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
        onPressed: checkIfAbleToLogin(), child: const Text('Log in'));
  }

  VoidCallback? checkIfAbleToLogin() {
    if (!_isPasswordLongEnough) {
      return null;
    } else {
      return doLogin;
    }
  }

  void doLogin() {
    var email = nameController.text;
    var password = passwordController.text;
    var fbaseToken = fcmToken;
    api.login(email, password, fbaseToken).then((value) => {
          if (value.item1 == 0)
            {Navigator.pushNamed(context, '/home')}
          else
            {
              setState(() => {errorMessage = value.item2!})
            }
        });
  }
}
