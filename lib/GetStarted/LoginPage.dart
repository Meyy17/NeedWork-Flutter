import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pas_app/GetStarted/RegisterPage.dart';
import 'package:pas_app/NavBotBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavBotBar(),
                          ));
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
