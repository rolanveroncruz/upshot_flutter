import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final VoidCallback goLogin;
  const SignUp({Key? key, required this.goLogin}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  String errorMessage = "";

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
                    'Sign up',
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
                        doSignup();
                      },
                      child: const Text('Sign Up'))),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(fontSize: 15, color: Colors.red),
                  )),
              Row(
                children: <Widget>[
                  const Text('Already have an account?'),
                  TextButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: widget.goLogin,
                  )
                ],
              )
            ])));
  }

  void doSignup() {}
}
