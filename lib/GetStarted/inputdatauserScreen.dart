import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/NeedWork/user.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:pas_app/Api/Services/user_services.dart';
import 'package:pas_app/GetStarted/LoginPage.dart';
import 'package:pas_app/NavBotBar.dart';

class InputDataUserScreen extends StatefulWidget {
  const InputDataUserScreen({Key? key}) : super(key: key);

  @override
  State<InputDataUserScreen> createState() => _InputDataUserScreenState();
}

class _InputDataUserScreenState extends State<InputDataUserScreen> {
  User? user;
  bool loading = true;
  File? _imageFile;
  final _picker = ImagePicker();
  String imgg = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String gender = '';

  void getUser() async {
    Apirespose response = await getuserdetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
        loading = false;
        _tanggal_lahir.text = user!.tanggal_lahir ?? '';
        _name.text = user!.name ?? '';
      });
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

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        imgg = getStringImage(_imageFile).toString();
      });
    }
  }

  //update profile
  void updateimgfun() async {
    Apirespose response = await updateimg(
        imgg,
        _name.text,
        _tempatlahir.text,
        _tanggal_lahir.text,
        gender,
        _phonenumber.text,
        _agama.text,
        _alamatlengkap.text,
        _skill.text);
    setState(() {
      loading = false;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavBotBar(),
          ));
    });
    if (response.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.data}')));
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

  //update profile
  void updateuserfun() async {
    Apirespose response = await updateuser(
        _name.text,
        _tempatlahir.text,
        _tanggal_lahir.text,
        gender,
        _phonenumber.text,
        _agama.text,
        _alamatlengkap.text,
        _skill.text);
    setState(() {
      loading = false;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavBotBar(),
          ));
    });
    if (response.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.data}')));
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

  //Texteditingcontroller
  TextEditingController _tanggal_lahir = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _tempatlahir = TextEditingController();
  TextEditingController _phonenumber = TextEditingController();
  TextEditingController _agama = TextEditingController();
  TextEditingController _alamatlengkap = TextEditingController();
  TextEditingController _skill = TextEditingController();
  //close

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Lengkapi Data Anda",
            style: TextStyle(
                color: Color.fromARGB(255, 0, 123, 245),
                fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: loading
              ? Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: _imageFile == null
                                      ? user!.image_profile != null
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  '${user!.image_profile}'),
                                              fit: BoxFit.cover)
                                          : DecorationImage(
                                              image: AssetImage(
                                                  'Asset/Image/userImage/defaultuser.png'),
                                              fit: BoxFit.cover)
                                      : DecorationImage(
                                          image:
                                              FileImage(_imageFile ?? File('')),
                                          fit: BoxFit.cover),
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white),
                                child: IconButton(
                                    onPressed: () {
                                      getImage();
                                    },
                                    icon: Icon(
                                      Icons.camera_alt_rounded,
                                      size: 30,
                                      color: Color.fromARGB(255, 120, 120, 120),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          //Nama
                          TextFormField(
                            controller: _name,
                            validator: (val) =>
                                val!.isEmpty ? 'Invalid Name' : null,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelText: "Nama",
                                labelStyle: new TextStyle(color: Colors.black)),
                          ),

                          //TempatLahir
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Invalid Place of birth' : null,
                            controller: _tempatlahir,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelText: "Tempat Lahir",
                                labelStyle: new TextStyle(color: Colors.black)),
                          ),
                          //TanggalLahir
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
                          Column(
                            children: [
                              RadioListTile(
                                title: Text("Laki - Laki"),
                                value: "Laki - Laki",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                title: Text("Perempuan"),
                                value: "Perempuan",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                            ],
                          ),

                          TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'Invalid your phone number'
                                : null,
                            controller: _phonenumber,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                icon: Text("+62"),
                                hintText: 'Enter your phone number',
                                labelText: 'Phone Number'),
                          ),
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Invalid your religion' : null,
                            controller: _agama,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelText: "Agama",
                                labelStyle: new TextStyle(color: Colors.black)),
                          ),
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Invalid your adderss' : null,
                            controller: _alamatlengkap,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelText: "Alamat Lengkap",
                                labelStyle: new TextStyle(color: Colors.black)),
                          ),
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Invalid your skill' : null,
                            controller: _skill,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelText: "Skill",
                                labelStyle: new TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (gender == '') {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Peringatan!"),
                                  content: const Text("Pilih Gender Anda"),
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
                              if (imgg == '') {
                                setState(() {
                                  loading = true;
                                });
                                updateuserfun();
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                updateimgfun();
                              }
                            }
                          }
                        },
                        child: Text("Next"))
                  ],
                ),
        ));
  }
}
