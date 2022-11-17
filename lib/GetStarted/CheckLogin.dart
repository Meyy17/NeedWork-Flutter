import 'package:flutter/material.dart';
import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:pas_app/Api/Services/user_services.dart';
import 'package:pas_app/GetStarted/OnBoardingFinal.dart';
import 'package:pas_app/GetStarted/OnBoardingScreen.dart';
import 'package:pas_app/NavBotBar.dart';

class CheckLogin extends StatefulWidget {
  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => OnBoardingScreen()),
          (route) => false);
    } else {
      Apirespose response = await getuserdetail();
      if (response.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => NavBotBar()),
            (route) => false);
      } else if (response.error == unauthroized) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => OnBoardingScreen()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    }
  }

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator()),
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
    );
  }
}
