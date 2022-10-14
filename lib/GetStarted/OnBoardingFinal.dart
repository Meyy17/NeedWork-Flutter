import 'package:flutter/material.dart';
import 'package:pas_app/GetStarted/LoginPage.dart';
import 'package:pas_app/GetStarted/RegisterPage.dart';

class OnBoardingFinal extends StatefulWidget {
  const OnBoardingFinal({Key? key}) : super(key: key);

  @override
  State<OnBoardingFinal> createState() => _OnBoardingFinalState();
}

class _OnBoardingFinalState extends State<OnBoardingFinal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "Asset/Image/OnBoarding/LogoOBFinal.png",
                    height: 250,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Text(
                "Start looking for a job now",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 0, 123, 245)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 60),
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 110, 181, 253),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Log in",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
            Container(
                margin: EdgeInsets.only(top: 5),
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 0, 123, 245),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Register",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
          ],
        ),
      ),
    );
  }
}
