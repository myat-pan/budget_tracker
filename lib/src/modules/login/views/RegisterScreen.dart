// ignore_for_file: prefer_const_constructors

import 'package:budget_tracker/src/modules/login/views/LoginScreen.dart';
import 'package:budget_tracker/src/widgets/custom_icons.dart';
import 'package:flutter/cupertino.dart';
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
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 1;
  var _passwordVisible;

  @override
  void initState() {
    setState(() {
      _passwordVisible = true;
    });

    super.initState();
  }

  _textfieldSection() {
    return Container(
      // margin: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFormFieldWidget(
            controller: _nameController,
            icon: CupertinoIcons.person,
            iconSize: 20,
            labelText: "Name",
            showSuffix: false,
            obsecureText: true,
          ),
          SizedBox(
            height: 12,
          ),
          TextFormFieldWidget(
            controller: _emailController,
            icon: CustomIcons.mail,
            iconSize: 16,
            labelText: "Email",
            obsecureText: true,
            showSuffix: false,
          ),
          SizedBox(
            height: 12,
          ),
          TextFormFieldWidget(
            controller: _passwordController,
            icon: CupertinoIcons.lock,
            iconSize: 20,
            labelText: "Password",
            showSuffix: true,
            obsecureText: _passwordVisible,
          ),
          SizedBox(
            height: 12,
          ),
          TextFormFieldWidget(
            controller: _retypePasswordController,
            icon: CupertinoIcons.lock,
            iconSize: 20,
            labelText: "Retype Password",
            showSuffix: true,
            obsecureText: _passwordVisible,
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

  _radioButtonSection() {
    return Row(
      children: [
        SizedBox(
          width: 8,
        ),
        Text(
          "Gender:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Radio(
            value: 1,
            groupValue: id,
            onChanged: (val) {
              setState(() {
                radioButtonItem = "Male";
                id = 1;
              });
            }),
        Text("Male"),
        Radio(
            value: 2,
            groupValue: id,
            onChanged: (val) {
              setState(() {
                radioButtonItem = "Female";
                id = 2;
              });
            }),
        Text("Female"),
        Radio(
            value: 3,
            groupValue: id,
            onChanged: (val) {
              setState(() {
                radioButtonItem = "Others";
                id = 3;
              });
            }),
        Text("Others")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: SingleChildScrollView(
        child: Container(
            // padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(left: 18, right: 18),
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
                  height: 18,
                ),
                _radioButtonSection(),
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
