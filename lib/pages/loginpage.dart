import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/fireservice.dart/signin.dart';
import 'package:todo/pages/Forgotpass.dart';

class Loginpage extends StatefulWidget {
  final VoidCallback showregpage;
  const Loginpage({Key? key, required this.showregpage}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 50, 48, 48),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Icon(
                  Icons.laptop,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        color: Color.fromARGB(248, 128, 159, 236),
                        blurRadius: 6)
                  ],
                  size: 80,
                ),
                Text(
                  'Welcome!',
                  style: GoogleFonts.notoSans(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 15),
                Text(
                  'Glad to see you again',
                  style:
                      GoogleFonts.notoSans(fontSize: 16, color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  height: 200,
                  width: 350,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(248, 128, 159, 236),
                          blurRadius: 6,
                          spreadRadius: 6,
                          blurStyle: BlurStyle.normal)
                    ],
                    color: Color.fromARGB(255, 9, 1, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        style: TextStyle(color: Colors.white),
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple)),
                          fillColor: Colors.black,
                          iconColor: Colors.white,
                          hintText: 'abc@xyz.com',
                          hintStyle: GoogleFonts.notoSans(),
                          labelText: 'Email',
                          labelStyle: GoogleFonts.notoSans(color: Colors.white),
                          icon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        controller: passwordcontroller,
                        decoration: InputDecoration(
                          // border:OutlineInputBorder(borderSide:BorderSide()),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple)),
                          labelText: 'Password',
                          labelStyle: GoogleFonts.notoSans(color: Colors.white),
                          icon: Icon(
                            Icons.password,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Forgotpasswordpage();
                          }));
                        },
                        child: Text(
                          'Forgot password',
                          style: TextStyle(
                              color: Color.fromARGB(255, 131, 79, 219),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () =>
                        signin(emailcontroller, passwordcontroller, context),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 12)
                          ]),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ?",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    InkWell(
                      onTap: widget.showregpage,
                      child: Text(' Sign up',
                          style: TextStyle(
                              color: Color.fromARGB(255, 3, 89, 239),
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   emailcontroller.dispose();
  //   passwordcontroller.dispose();
  //   super.dispose();
  // }
}
