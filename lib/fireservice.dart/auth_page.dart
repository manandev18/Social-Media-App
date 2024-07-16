import 'package:flutter/material.dart';
import 'package:todo/pages/loginpage.dart';
import 'package:todo/pages/registerpage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showloginpage = true;
  void togglescreens() {
    setState(() {
      showloginpage = !showloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginpage) {
      return Loginpage(showregpage: togglescreens);
    } else {
      return Registerpage(showloginpage: togglescreens);
    }
  }
}
