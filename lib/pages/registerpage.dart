import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/fireservice.dart/signup.dart';

class Registerpage extends StatefulWidget {
  final VoidCallback showloginpage;
  const Registerpage({Key? key, required this.showloginpage}) : super(key: key);

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final _passwordcontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _Confirmpasswordcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _namecontroller.dispose();
    _passwordcontroller.dispose();
    _Confirmpasswordcontroller.dispose();

    super.dispose();
  }

  Future ismatch() async {
    if (_passwordcontroller.text.trim() ==
        _Confirmpasswordcontroller.text.trim()) {
      await signup(_emailcontroller, _passwordcontroller, _namecontroller);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password not matched')));
    }
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
                  height: 40,
                ),
                Icon(
                  Icons.ad_units_rounded,
                  size: 60,
                  color: Colors.white,
                ),
                Text(
                  'Welcome!',
                  style: GoogleFonts.notoSans(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  'Join with Us',
                  style: GoogleFonts.notoSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  height: 300,
                  width: 350,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(248, 128, 159, 236),
                          blurRadius: 9,
                          spreadRadius: 10,
                          blurStyle: BlurStyle.normal)
                    ],
                    color: const Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _namecontroller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple)),
                          hintText: 'Joh Doe',
                          hintStyle: GoogleFonts.notoSans(color: Colors.white),
                          labelText: 'Name',
                          labelStyle: GoogleFonts.notoSans(color: Colors.white),
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _emailcontroller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple)),
                          hintText: 'abc@xyz.com',
                          hintStyle: GoogleFonts.notoSans(color: Colors.white),
                          labelText: 'Email',
                          labelStyle: GoogleFonts.notoSans(color: Colors.white),
                          icon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        controller: _passwordcontroller,
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
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        controller: _Confirmpasswordcontroller,
                        decoration: InputDecoration(
                          // border:OutlineInputBorder(borderSide:BorderSide()),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple)),
                          labelText: 'Confirm Password',
                          labelStyle: GoogleFonts.notoSans(color: Colors.white),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: ismatch,
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
                      'Sign up',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    InkWell(
                      onTap: widget.showloginpage,
                      child: Text(' Sign in',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 48, 121, 247),
                              fontSize: 20,
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
}
