import 'package:flutter/material.dart';
import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/NeedWork/usermodel.dart';
import 'package:pas_app/Api/NeedWork/workexpmodel.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:pas_app/Api/Services/user_services.dart';
import 'package:pas_app/Api/Services/workexp_services.dart';
import 'package:pas_app/GetStarted/LoginPage.dart';
import 'package:pas_app/Screen/Profile/WorkExperience/EditWorkExp.dart';
import 'package:pas_app/Screen/Profile/WorkExperience/PostListWorkExperienceUser.dart';

class ListWorkExperienceUser extends StatefulWidget {
  ListWorkExperienceUser({Key? key}) : super(key: key);

  @override
  State<ListWorkExperienceUser> createState() => _ListWorkExperienceUserState();
}

class _ListWorkExperienceUserState extends State<ListWorkExperienceUser> {
  User? user;
  Workexpbyuser? workexpbyuser;
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

    Apirespose res = await getworkexpbyuser(user!.id.toString());
    if (response.error == null) {
      setState(() {
        workexpbyuser = res.data as Workexpbyuser;
        isload = false;
      });
    }
  }

  void deletedata(String id) async {
    Apirespose response = await deletePost(id);
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
          Navigatetopostworkexp(context);
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
          "Work Expreience",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, 'Berhasil Update');
            },
            icon: Icon(Icons.arrow_back, color: Colors.blue)),
      ),
      body: isload
          ? Center(child: CircularProgressIndicator())
          : Container(margin: EdgeInsets.all(20), child: getlistworkexp()),
    );
  }

  Widget getlistworkexp() {
    if (workexpbyuser!.workexpsuser!.length > 0) {
      return ListView.builder(
        itemCount: workexpbyuser!.workexpsuser!.length,
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
                              workexpbyuser!.workexpsuser![index].namaPekerjaan
                                  .toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        getpopupmenuworkexp(index)
                      ],
                    ),
                    Container(
                        width: double.infinity,
                        child: Text(
                          workexpbyuser!.workexpsuser![index].namaPerusahaan
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 124, 124, 124)),
                        )),
                    Container(
                        width: double.infinity,
                        child: Text(
                          workexpbyuser!.workexpsuser![index].tanggalBekerja
                                  .toString() +
                              " - " +
                              workexpbyuser!
                                  .workexpsuser![index].tanggalBerhenti
                                  .toString(),
                          style: TextStyle(
                              color: Color.fromARGB(255, 124, 124, 124)),
                        )),
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        child: Text(
                          workexpbyuser!.workexpsuser![index].description
                              .toString(),
                          style: TextStyle(
                              color: Color.fromARGB(255, 124, 124, 124)),
                        ))
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
                child: Image.asset("Asset/Image/anim/ajakan.png")),
            Text(
              "Ayo isi pengalaman kerja kamu!, agar perusahaan lebih tertarik untuk merkrutmu",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  }

  Widget getpopupmenuworkexp(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: PopupMenuButton(
          onSelected: (result) {
            if (result == 0) {
              Navigatetoediteworkexp(context, index);
            } else if (result == 2) {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Hapus " +
                      workexpbyuser!.workexpsuser![index].namaPekerjaan
                          .toString()),
                  content: Text("Apa kamu yakin ingin menghapus? " +
                      workexpbyuser!.workexpsuser![index].namaPekerjaan
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
                          deletedata(workexpbyuser!.workexpsuser![index].id
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
                    value: 0,
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

  Future<void> Navigatetoediteworkexp(BuildContext context, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              EditWorkExp(workexpsuser: workexpbyuser!.workexpsuser![index])),
    );
    if (!mounted) return;
    setState(() {
      isload = true;
      getdata();
    });
  }

  Future<void> Navigatetopostworkexp(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostListWorkExperienceUser()),
    );
    if (!mounted) return;
    setState(() {
      isload = true;
      getdata();
    });
  }
}
