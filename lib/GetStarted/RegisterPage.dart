import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:pas_app/GetStarted/LoginPage.dart';
import 'package:pas_app/GetStarted/inputdatauserScreen.dart';
import 'package:pas_app/NavBotBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/NeedWork/usermodel.dart';
import '../Api/Response/responseapi.dart';
import '../Api/Services/user_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void _registeruser() async {
    Apirespose response = await registerUser(
        _email.text, _pass.text, _name.text, _tanggal_lahir.text);
    if (response.error == null) {
      _register(response.data as User);
    } else {
      setState(() {
        islogin = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _register(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => InputDataUserScreen()),
        (route) => false);
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _tanggal_lahir = TextEditingController();
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
                "Register",
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
                          "Create Account",
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
                        controller: _name,
                        validator: (val) =>
                            val!.isEmpty ? 'Invalid name' : null,
                        decoration: InputDecoration(
                            icon: Icon(Icons.people),
                            hintText: 'Enter your name',
                            labelText: 'Name'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
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
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Invalid your birth' : null,
                      controller: _tanggal_lahir,
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "Enter Date"),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(3000));

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate);

                          setState(() {
                            _tanggal_lahir.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 125),
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  _registeruser();
                                  islogin = true;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 0, 123, 245),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text(
                              "Register",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already an account?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                            },
                            child: Text("Login Now",
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
