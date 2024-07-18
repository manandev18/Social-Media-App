import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgotpasswordpage extends StatefulWidget {
  const Forgotpasswordpage({super.key});

  @override
  State<Forgotpasswordpage> createState() => _ForgotpasswordpageState();
}

class _ForgotpasswordpageState extends State<Forgotpasswordpage> {
  final _emailcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  Future passwordreset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailcontroller.text.trim());

      // Assuming the email was sent successfully
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Text('Password reset link sent to your email.'));
        },
      );
    } on FirebaseAuthException catch (e) {
      String message;

      // Check specific error code
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else {
        message = e.message ?? 'An unknown error occurred.';
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(message));
        },
      );
      print(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Reset Password',
              style: TextStyle(color: Colors.white, fontSize: 22)),
          elevation: 20,
          shadowColor: Color.fromARGB(248, 128, 159, 236),
          backgroundColor: Color.fromARGB(255, 9, 1, 1),
          foregroundColor: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 50, 48, 48),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                Icon(
                  Icons.lock_open,
                  color: Colors.white,
                  size: 80,
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(248, 128, 159, 236),
                      blurRadius: 6,
                    )
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  'Enter your email to reset password',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    height: 100,
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
                            controller: _emailcontroller,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple)),
                              fillColor: Colors.black,
                              iconColor: Colors.white,
                              hintText: 'abc@xyz.com',
                              hintStyle: GoogleFonts.notoSans(),
                              labelText: 'Email',
                              labelStyle:
                                  GoogleFonts.notoSans(color: Colors.white),
                              icon: Icon(Icons.email),
                            ),
                          ),
                        ])),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: passwordreset,
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
                      'Send Email',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
