import 'package:budget_tracker/src/modules/home/views/HomeScreen.dart';
import 'package:budget_tracker/src/modules/login/components/text_form_field_widget.dart';
import 'package:budget_tracker/src/modules/login/views/RegisterScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:budget_tracker/src/res/dimens.dart' as dimens;

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _loginSection() {
    return Container(
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: _emailController,
            icon: Icons.mail_outline_outlined,
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
            height: 60,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              height: dimens.buttonHeight,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(dimens.borderRadius))),
                  onPressed: () {
                    Get.offAll(HomeScreen(), transition: Transition.downToUp);
                  },
                  child: Text("Sign In"))),
          SizedBox(
            height: 24,
          ),
          RichText(
              textScaleFactor: 1.1,
              text: TextSpan(children: [
                TextSpan(
                    text: "Don't have an account? Register ",
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.offAll(RegisterScreen(),
                          transition: Transition.downToUp);
                    },
                  text: "here",
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                )
              ]))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                  padding: EdgeInsets.only(bottom: 60),
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(
                        color: Colors.black, fontSize: 28, letterSpacing: 4),
                  )),
              _loginSection()
            ]),
          ),
        ),
      ),
    );
  }
}
