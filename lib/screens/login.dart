import 'package:flutter/material.dart';
import 'package:upshot_flutter/data/api.dart';
import '../shared/sp_helper.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  final SPHelper helper = SPHelper();
  final API api = API();
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    helper.init().then((value) {
      var userlogin = helper.readUserLogin();
      var userlogstr = json.encode(userlogin);
      // ignore: avoid_print
      print('userlogin is $userlogstr');
      if (userlogin != null) {
        Navigator.pushNamed(context, '/home');
      }
      api.init();
    });
  }

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
                    'Sign in',
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
                  child: ElevatedButton(
                      onPressed: () {
                        doLogin();
                      },
                      child: const Text('Log in'))),
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
                children: <Widget>[
                  const Text('Does not have an account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      helper.clearUserLogin();
                    },
                  )
                ],
              )
            ])));
  }

  void doLogin() {
    var email = nameController.text;
    var password = passwordController.text;
    api.login(email, password).then((value) => {
          if (value.item1 == 0)
            {print("Login successful"), Navigator.pushNamed(context, '/home')}
          else
            {
              setState(() => {errorMessage = value.item2!})
            }
        });
  }
}
