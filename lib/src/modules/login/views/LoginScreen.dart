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
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_open_outlined),
                labelText: "Email",
                //   suffixIcon: Icon(Icons.sh),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          ElevatedButton(onPressed: () {}, child: Text("Sign In")),
          RichText(
              text: TextSpan(children: [
            TextSpan(text: "Don't have an account? Register"),
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = () {},
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
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(children: [_loginSection()]),
          ),
        ),
      ),
    );
  }
}
