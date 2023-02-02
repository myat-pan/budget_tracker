// ignore_for_file: prefer_const_constructors

import 'package:budget_tracker/src/modules/login/views/LoginScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();

  _textfieldSection() {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  labelText: "Name",
                  border: InputBorder.none,
                  /*   border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ) */
                ),
              )),
          SizedBox(
            height: 12,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  labelText: "Email",
                  //   suffixIcon: Icon(Icons.sh),
                  border: InputBorder.none,
                  /*    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ) */
                ),
              )),
          SizedBox(
            height: 12,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_open_outlined,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  labelText: "Password",
                  //   suffixIcon: Icon(Icons.sh),
                  border: InputBorder.none,
                  /*  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ) */
                ),
              )),
          SizedBox(
            height: 12,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: _retypePasswordController,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_open_outlined,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  labelText: "Confirm Password",
                  //   suffixIcon: Icon(Icons.sh),
                  border: InputBorder.none,
                  /*   border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ) */
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Welcome To Budget",
                      style: TextStyle(
                          color: Colors.black, fontSize: 28, letterSpacing: 4),
                    )),
                SizedBox(
                  height: 60,
                ),
                _textfieldSection(),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1,
                    child: ElevatedButton(
                        onPressed: () {}, child: Text("Sign Up"))),
                SizedBox(
                  height: 24,
                ),
                RichText(
                    textScaleFactor: 1.1,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Already have an account? Sign in ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offAll(LoginScreen(),
                                transition: Transition.downToUp);
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) => LoginScreen(),
                            //   ),
                            // );
                          },
                        text: "here",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      )
                    ]))
              ],
            )),
      ),
    )));
  }
}
