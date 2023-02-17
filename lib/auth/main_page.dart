// import 'package:acheev/pages/login_page.dart';
// import 'package:acheev/models/task.dart';
import 'package:acheev/pages/login_page.dart';
// import 'package:acheev/pages/tasks_page.dart';
// import 'package:acheev/pages/tasks_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (countex, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
