import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/NeedWork/user.dart';
import 'package:pas_app/Api/NeedWork/workexp.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:pas_app/Api/Services/school_services.dart';
import 'package:pas_app/Api/Services/user_services.dart';
import 'package:pas_app/Api/Services/workexp_services.dart';
import 'package:pas_app/GetStarted/LoginPage.dart';
import 'package:pas_app/NavBotBar.dart';
import 'package:pas_app/Screen/Profile/WorkExperience/ListWorkExperienceUser.dart';

class PostSchollUser extends StatefulWidget {
  PostSchollUser({Key? key}) : super(key: key);

  @override
  State<PostSchollUser> createState() => _PostSchollUserState();
}

class _PostSchollUserState extends State<PostSchollUser> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isload = false;

  void postschool() async {
    Apirespose response =
        await postschooluser(nameschool.text, major.text, graduation_year.text);
    if (response.error == null) {
      setState(() {
        isload = false;
      });
      Navigator.pop(context);
    } else if (response.error == unauthroized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  TextEditingController nameschool = TextEditingController();
  TextEditingController major = TextEditingController();
  TextEditingController graduation_year = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Post Work Experience",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.blue)),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: getform(),
          ),
        ],
      ),
    );
  }

  Widget getform() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (val) => val!.isEmpty ? 'Mohon isi nama Sekolah' : null,
            controller: nameschool,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                icon: Icon(Icons.school),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: "Nama Sekolah",
                labelStyle: new TextStyle(color: Colors.black)),
          ),
          TextFormField(
            validator: (val) => val!.isEmpty ? 'Mohon isi jurusan anda' : null,
            controller: major,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                icon: Icon(Icons.stacked_line_chart_outlined),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: "Jurusan",
                labelStyle: new TextStyle(color: Colors.black)),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (val) =>
                val!.isEmpty ? 'Mohon isi tahun lulus anda' : null,
            controller: graduation_year,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                icon: Icon(Icons.date_range),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: "Tahun Lulus",
                labelStyle: new TextStyle(color: Colors.black)),
          ),
          Container(
            width: 300,
            padding: EdgeInsets.only(top: 100),
            child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isload = true;
                    });
                    postschool();
                  }
                },
                child: Text("Submit")),
          )
        ],
      ),
    );
  }
}
