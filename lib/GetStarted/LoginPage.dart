import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pas_app/GetStarted/RegisterPage.dart';
import 'package:pas_app/NavBotBar.dart';
import 'package:pas_app/Api/NeedWork/user.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "kobo@gmail.com";
  String pass = "ItsOkyyy";
  String Username = "Kobokan aer";

  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: Color.fromARGB(255, 0, 123, 245))),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Login",
          style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 0, 123, 245),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 0, 123, 245),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                  controller: _pass,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color.fromARGB(255, 0, 123, 245)),
                    ))
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 170),
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (ctx) => AlertDialog(
                      //     content: Column(
                      //       children: [Text(_email.text)],
                      //     ),
                      //     title: Text("Email " + _email.text),
                      //     actions: <Widget>[
                      //       TextButton(
                      //           onPressed: () {
                      //             Navigator.pop(context);
                      //           },
                      //           child: Text("No")),
                      //       TextButton(
                      //           onPressed: () {
                      //             Navigator.pop(context);
                      //           },
                      //           child: Text("Yes")),
                      //     ],
                      //   ),
                      // );

                      if (_email.text == email && _pass.text == pass) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavBotBar(),
                            ));
                      } else if (_email.text != email) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("Email Kamu Masukkan Salah Y DECK"),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Oke")),
                            ],
                          ),
                        );
                      } else if (_pass.text != pass) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(
                                "Password Yang Kamu Masukkan Salah Y DECK"),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Oke")),
                            ],
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(
                                "Email Dan Password Yang Kamu Masukkan Salah"),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Oke")),
                            ],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 0, 123, 245),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Log in",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ));
                    },
                    child: Text("Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 123, 245))))
              ],
            )
          ],
        ),
      ),
    );
  }
}
