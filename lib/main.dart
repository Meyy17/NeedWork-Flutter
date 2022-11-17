import 'package:flutter/material.dart';
import 'package:pas_app/Api/Services/user_services.dart';
import 'package:pas_app/GetStarted/CheckLogin.dart';
import 'package:pas_app/GetStarted/LoginPage.dart';
import 'package:pas_app/GetStarted/OnBoardingScreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        primaryColor: Color.fromARGB(255, 0, 123, 245),
      ),
      home: CheckLogin(),
    );
  }
}
