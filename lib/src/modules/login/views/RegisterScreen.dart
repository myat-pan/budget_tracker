// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail_outline),
                labelText: "Email",
                //   suffixIcon: Icon(Icons.sh),
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
                labelText: "Password",
                //   suffixIcon: Icon(Icons.sh),
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
                labelText: "Confirm Password",
                //   suffixIcon: Icon(Icons.sh),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
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
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Text("Welcome To Budget"),
            _textfieldSection(),
            ElevatedButton(onPressed: () {}, child: Text("Sign Up")),
            RichText(
                text: TextSpan(children: [
              TextSpan(text: "Already have an account? Sign in"),
              TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () {},
                text: "here",
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
              )
            ]))
          ],
        )),
      ),
    ));
  }
}
