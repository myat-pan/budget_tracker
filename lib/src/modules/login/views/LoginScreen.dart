import 'package:budget_tracker/src/modules/home/views/HomeScreen.dart';
import 'package:budget_tracker/src/modules/login/views/RegisterScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail_outline_outlined),
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_open_outlined),
                labelText: "Password",
                //   suffixIcon: Icon(Icons.sh),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          SizedBox(
            height: 24,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => HomeScreen(),
                      ),
                    );
                  },
                  child: Text("Sign In"))),
          SizedBox(
            height: 24,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Don't have an account? Register ",
                style: TextStyle(color: Colors.black)),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => RegisterScreen(),
                    ),
                  );
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
