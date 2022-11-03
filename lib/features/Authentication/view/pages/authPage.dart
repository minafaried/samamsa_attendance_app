import 'package:attendance_app/Common/Config/Palette.dart';
import 'package:attendance_app/features/Authentication/view/Widgets/login.dart';
import 'package:attendance_app/features/Authentication/view/Widgets/signup.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  bool _login = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _login ? LogIn() : SignUp(),
            Container(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  _login ? "SignUp" : "LogIn",
                  style: TextStyle(
                    color: Palette.white,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
