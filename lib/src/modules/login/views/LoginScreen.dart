import 'package:budget_tracker/src/modules/home/views/HomeScreen.dart';
import 'package:budget_tracker/src/modules/login/views/RegisterScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    prefixIcon: Icon(
                      Icons.mail_outline_outlined,
                      color: Colors.black.withOpacity(0.7),
                    ),
                    labelText: "Email",
                    border: InputBorder.none
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10),

                    // )
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
                    border: InputBorder.none
                    //   suffixIcon: Icon(Icons.sh),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // )
                    ),
              )),
          SizedBox(
            height: 24,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(HomeScreen(), transition: Transition.downToUp);
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute<void>(
                    //     builder: (BuildContext context) => HomeScreen(),
                    //   ),
                    // );
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
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute<void>(
                      //     builder: (BuildContext context) => RegisterScreen(),
                      //   ),
                      // );
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
