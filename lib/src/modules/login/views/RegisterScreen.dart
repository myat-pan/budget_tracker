// ignore_for_file: prefer_const_constructors

import 'package:budget_tracker/src/modules/login/views/LoginScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:budget_tracker/src/res/dimens.dart' as dimens;

import '../components/text_form_field_widget.dart';

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
          TextFormFieldWidget(
            controller: _nameController,
            icon: Icons.person,
            labelText: "Name",
          ),
          SizedBox(
            height: 12,
          ),
          TextFormFieldWidget(
            controller: _emailController,
            icon: Icons.mail,
            labelText: "Email",
          ),
          SizedBox(
            height: 12,
          ),
          TextFormFieldWidget(
            controller: _passwordController,
            icon: Icons.lock_open_outlined,
            labelText: "Password",
          ),
          SizedBox(
            height: 12,
          ),
          TextFormFieldWidget(
            controller: _passwordController,
            icon: Icons.lock_open_outlined,
            labelText: "Password",
          ),
          SizedBox(
            height: 24,
          ),
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
                    height: dimens.buttonHeight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    dimens.borderRadius))),
                        onPressed: () {},
                        child: Text("Sign Up"))),
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
