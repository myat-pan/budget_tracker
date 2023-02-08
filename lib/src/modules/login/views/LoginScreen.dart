// ignore_for_file: prefer_const_constructors

import 'package:budget_tracker/src/modules/home/views/HomeScreen.dart';
import 'package:budget_tracker/src/modules/login/components/text_form_field_widget.dart';
import 'package:budget_tracker/src/modules/login/views/RegisterScreen.dart';
import 'package:budget_tracker/src/services/bloc/auth_bloc.dart';
import 'package:budget_tracker/src/services/bloc/auth_event.dart';
import 'package:budget_tracker/src/services/bloc/auth_state.dart';
import 'package:budget_tracker/src/widgets/custom_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart' as trans;
import 'package:budget_tracker/src/res/dimens.dart' as dimens;
import 'package:http/http.dart' as http;

// class LoginScreen extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: ((context) => AuthBloc(httpClient: http.Client())..add(Login)),
//     );
//   }
// }
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  _loginButtonPressed() {
    BlocProvider.of<AuthBloc>(context)
        .add(Login(_emailController.text, _passwordController.text));
  }

  _loginSection() {
    return Container(
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: _emailController,
            icon: CustomIcons.mail,
            labelText: "Email",
            iconSize: 16,
          ),
          SizedBox(
            height: 12,
          ),
          TextFormFieldWidget(
            controller: _passwordController,
            icon: Icons.lock_open_outlined,
            iconSize: 20,
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
                    _loginButtonPressed();
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
                          transition: trans.Transition.downToUp);
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
    return BlocListener<AuthBloc, AuthState>(listener: (_context, state) {
      if (state is FetchLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.blueGrey,
          ),
        );
      }
    },
        // ignore: missing_return
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is LoginLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is AuthLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is Unautheticated) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is LoginFailure) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is LoginSuccess) {
        if (state.status == true) {
          Get.offAll(HomeScreen());
        }
      }

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
    }));
  }
}
