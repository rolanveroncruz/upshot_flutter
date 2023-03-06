import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final VoidCallback goLogin;
  const SignUp({Key? key, required this.goLogin}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  String errorMessage = "";
  // ignore: prefer_final_fields
  bool _isPasswordLongEnough = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              // Upshot Text or Logo
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
              // Sign Up Text
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  )),
              // Name Field
              Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  )),
              // Email Field
              Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
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
                  child: _buildSignupButton()),
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
                    onPressed: widget.goLogin,
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              )
            ])));
  }

  Widget _buildSignupButton() {
    return ElevatedButton(
        onPressed: checkIfAbleToLogin(), child: const Text('Sign Up'));
  }

  VoidCallback? checkIfAbleToLogin() {
    if (!_isPasswordLongEnough) {
      return null;
    } else {
      return doSignup;
    }
  }

  void doSignup() {}
  // TODO implement doSignup
}
