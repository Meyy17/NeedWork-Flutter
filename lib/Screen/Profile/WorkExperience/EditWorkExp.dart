import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/NeedWork/user.dart';
import 'package:pas_app/Api/NeedWork/workexp.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:pas_app/Api/Services/user_services.dart';
import 'package:pas_app/Api/Services/workexp_services.dart';
import 'package:pas_app/GetStarted/LoginPage.dart';
import 'package:pas_app/NavBotBar.dart';
import 'package:pas_app/Screen/Profile/WorkExperience/ListWorkExperienceUser.dart';

class EditWorkExp extends StatefulWidget {
  EditWorkExp({Key? key, required this.workexpsuser}) : super(key: key);
  Workexpsuser workexpsuser;
  @override
  State<EditWorkExp> createState() => _EditWorkExpState();
}

class _EditWorkExpState extends State<EditWorkExp> {
  User? user;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isload = true;

  void getUser() async {
    Apirespose response = await getuserdetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;

        setState(() {
          Nama_pekerjaan.text = widget.workexpsuser.namaPekerjaan.toString();
          Nama_perusahaan.text = widget.workexpsuser.namaPerusahaan.toString();
          Tanggal_Berhenti.text =
              widget.workexpsuser.tanggalBerhenti.toString();
          Tanggal_bekerja.text = widget.workexpsuser.tanggalBekerja.toString();
          Description.text = widget.workexpsuser.description.toString();
          isload = false;
        });
      });
    }
  }

  void updateexp() async {
    Apirespose response = await updateworkexp(
        widget.workexpsuser.id.toString(),
        Nama_pekerjaan.text,
        Nama_perusahaan.text,
        Description.text,
        Tanggal_bekerja.text,
        Tanggal_Berhenti.text);
    if (response.error == null) {
      setState(() {
        isload = false;
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavBotBar(),
          ));
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

  TextEditingController Nama_pekerjaan = TextEditingController();
  TextEditingController Nama_perusahaan = TextEditingController();
  TextEditingController Description = TextEditingController();
  TextEditingController Tanggal_bekerja = TextEditingController();
  TextEditingController Tanggal_Berhenti = TextEditingController();

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
            child: getformupdate(),
          ),
        ],
      ),
    );
  }

  Widget getformupdate() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (val) =>
                val!.isEmpty ? 'Mohon isi jenis pekerjaan' : null,
            controller: Nama_pekerjaan,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                icon: Icon(Icons.work),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: "Jenis Pekerjaan",
                labelStyle: new TextStyle(color: Colors.black)),
          ),
          TextFormField(
            validator: (val) =>
                val!.isEmpty ? 'Mohon isi nama perusahaan' : null,
            controller: Nama_perusahaan,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                icon: Icon(Icons.local_post_office),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: "Nama Perusahaan",
                labelStyle: new TextStyle(color: Colors.black)),
          ),
          TextFormField(
            validator: (val) => val!.isEmpty ? 'Mohon isi deskripsi' : null,
            controller: Description,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                icon: Icon(Icons.description),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: "Deskripsi",
                labelStyle: new TextStyle(color: Colors.black)),
          ),
          TextFormField(
            validator: (val) =>
                val!.isEmpty ? 'Mohon isi kapan anda mulai bekerja' : null,
            controller: Tanggal_bekerja,
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Kapan Anda Mulai Bekerja?"),
            readOnly: true,
            onTap: () async {
              DateTime? Tanggal_bekerjapick = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1000),
                  lastDate: DateTime(3000));

              if (Tanggal_bekerjapick != null) {
                print(Tanggal_bekerjapick);
                String outputtanggalbekerja =
                    DateFormat('yyyy-MM-dd').format(Tanggal_bekerjapick);
                print(outputtanggalbekerja);

                setState(() {
                  Tanggal_bekerja.text = outputtanggalbekerja;
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
          TextFormField(
            validator: (val) =>
                val!.isEmpty ? 'Mohon isi kapan anda berhenti bekerja' : null,
            controller: Tanggal_Berhenti,
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Kapan Anda Berhenti Bekerja?"),
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
                  Tanggal_Berhenti.text = formattedDate;
                });
              } else {
                print("Date is not selected");
              }
            },
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
                    updateexp();
                  }
                },
                child: Text("Submit")),
          )
        ],
      ),
    );
  }
}
