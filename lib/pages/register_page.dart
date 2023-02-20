import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Declare
  final _passveriController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _passwordVeriVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passveriController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
    _passwordVeriVisible = true;
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      addUserDetails(_emailController.text.trim());
    }
  }

  // ignore: non_constant_identifier_names
  Future addUserDetails(String Email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'email': Email, 'lastidalarm': 1});
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() == _passveriController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height - 35,
          padding: const EdgeInsets.only(top: 80, bottom: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Image.asset(
                        'assets/Welcome.png',
                      ),
                    ]),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Sign Up',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 26,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text('Email',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ))
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 20, right: 20, bottom: 15),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(187, 187, 187, 0.35)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(187, 187, 187, 1)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              hintText: 'Enter Email',
                              hintStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromRGBO(187, 187, 187, 1),
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true),
                        )),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text('Password',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ))
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 20, right: 20, bottom: 15),
                        child: TextField(
                          obscureText: _passwordVisible,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                }),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(187, 187, 187, 0.35)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(187, 187, 187, 1)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: 'Enter Password',
                            hintStyle: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color.fromRGBO(187, 187, 187, 1),
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        )),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text('Verification Password',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ))
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 20, right: 20),
                        child: TextField(
                          obscureText: _passwordVeriVisible,
                          controller: _passveriController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVeriVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVeriVisible =
                                        !_passwordVeriVisible;
                                  });
                                }),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(187, 187, 187, 0.35)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(187, 187, 187, 1)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: 'Enter Verification Password',
                            hintStyle: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color.fromRGBO(187, 187, 187, 1),
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 51,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Color.fromRGBO(254, 140, 0, 1),
                            Color.fromRGBO(248, 54, 0, 1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text('Sign Up',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            )),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ]),
    );
  }
}
