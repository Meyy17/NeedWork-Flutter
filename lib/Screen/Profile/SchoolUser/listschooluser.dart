import 'package:flutter/material.dart';
import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/NeedWork/school.dart';
import 'package:pas_app/Api/NeedWork/user.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:pas_app/Api/Services/school_services.dart';
import 'package:pas_app/Api/Services/user_services.dart';
import 'package:pas_app/GetStarted/LoginPage.dart';
import 'package:pas_app/Screen/Profile/SchoolUser/EditWorkExp.dart';
import 'package:pas_app/Screen/Profile/SchoolUser/PostSchoolUser.dart';
import 'package:pas_app/Screen/Profile/WorkExperience/PostListWorkExperienceUser.dart';

class ListSchooluser extends StatefulWidget {
  ListSchooluser({Key? key}) : super(key: key);

  @override
  State<ListSchooluser> createState() => _ListSchooluserState();
}

class _ListSchooluserState extends State<ListSchooluser> {
  User? user;
  Schooldatauser? schooldatauser;
  bool isload = true;

  // get user detail
  void getdata() async {
    Apirespose response = await getuserdetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
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

    Apirespose res = await getschooluser(user!.id.toString());
    if (response.error == null) {
      setState(() {
        schooldatauser = res.data as Schooldatauser;
        isload = false;
      });
    }
  }

  void deleteschooldatauser(String id) async {
    Apirespose response = await deleteschooluser(id);
    if (response.error == null) {
      Navigator.pop(context);
      setState(() {
        isload = true;
        getdata();
        if (response.error == null) {
          setState(() {
            isload = false;
          });
        }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigatetopostschooluser(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Education",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.blue)),
      ),
      body: isload
          ? Center(child: CircularProgressIndicator())
          : Container(margin: EdgeInsets.all(20), child: getlistworkexp()),
    );
  }

  Widget getlistworkexp() {
    if (schooldatauser!.schoolusers!.length > 0) {
      return ListView.builder(
        itemCount: schooldatauser!.schoolusers!.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Card(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            width: 230,
                            child: Text(
                              schooldatauser!.schoolusers![index].nameschool
                                  .toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        getpopupmenuschool(index)
                      ],
                    ),
                    Container(
                        width: double.infinity,
                        child: Text(
                          schooldatauser!.schoolusers![index].major.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 124, 124, 124)),
                        )),
                    Container(
                        width: double.infinity,
                        child: Text(
                          schooldatauser!.schoolusers![index].graduationYear
                              .toString(),
                          style: TextStyle(
                              color: Color.fromARGB(255, 124, 124, 124)),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 100, bottom: 30),
                width: 200,
                height: 200,
                child: Image.asset("Asset/Image/anim/penjelas.png")),
            Text(
              "Ayo isi riwayat sekolah kamu!, dengan riwayat sekolah kamu akan membuat perusahaan tertarik kepadamu!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  }

  Widget getpopupmenuschool(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: PopupMenuButton(
          onSelected: (result) {
            if (result == 1) {
              Navigatetoeditschooluser(context, index);
            } else if (result == 2) {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Hapus " +
                      schooldatauser!.schoolusers![index].nameschool
                          .toString()),
                  content: Text("Apa kamu yakin ingin menghapus? " +
                      schooldatauser!.schoolusers![index].nameschool
                          .toString() +
                      " dari riwayat pekerjaan kamu?"),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No")),
                    TextButton(
                        onPressed: () {
                          deleteschooldatauser(schooldatauser!
                              .schoolusers![index].id
                              .toString());
                        },
                        child: Text("Yes")),
                  ],
                ),
              );
            }
          },
          child: Icon(
            Icons.more_vert,
          ),
          itemBuilder: (context) => [
                PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Edit',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ],
                    )),
                PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.black,
                          size: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Delete',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ],
                    )),
              ]),
    );
  }

  Future<void> Navigatetopostschooluser(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostSchollUser()),
    );
    if (!mounted) return;
    setState(() {
      isload = true;
      getdata();
    });
  }

  Future<void> Navigatetoeditschooluser(BuildContext context, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditSchooluser(
                schoolusers: schooldatauser!.schoolusers![index],
              )),
    );
    if (!mounted) return;
    setState(() {
      isload = true;
      getdata();
    });
  }
}
