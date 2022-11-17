import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:pas_app/Api/Services/user_services.dart';
import 'package:pas_app/GetStarted/RegisterPage.dart';
import 'package:pas_app/NavBotBar.dart';
import 'package:pas_app/Api/NeedWork/user.dart';
import 'package:http/http.dart' as http;
import 'package:pas_app/Screen/Home/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _loginuser() async {
    Apirespose response = await login(_email.text, _pass.text);
    if (response.error == null) {
      _login(response.data as User);
    } else {
      setState(() {
        islogin = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _login(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => NavBotBar()), (route) => false);
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool islogin = false;
  bool showpw = false;

  @override
  Widget build(BuildContext context) {
    return islogin
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,
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
              child: Form(
                key: formkey,
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
                        keyboardType: TextInputType.emailAddress,
                        controller: _email,
                        validator: (val) =>
                            val!.isEmpty ? 'Invalid email adderss' : null,
                        decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'Enter your email',
                            labelText: 'Email'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: _pass,
                        validator: (val) => val!.length < 6
                            ? 'Required at least 6 chars'
                            : null,
                        obscureText: !showpw,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          hintText: 'Enter your Password',
                          labelText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                showpw = !showpw;
                              });
                            },
                            child: Icon(showpw
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 123, 245)),
                            ))
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 170),
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  _loginuser();
                                  islogin = true;
                                });
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
            ),
          );
  }
}
