
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'auth/main_page.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  FlutterNativeSplash.remove();
  runApp(const AcheevMain());
}

class AcheevMain extends StatelessWidget {
  const AcheevMain({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acheev',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      // login: const MyHomePage(title: 'Acheev'),
      home: const MainPage(),
    );
  }
}