import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pas_app/Api/NeedWork/portomodel.dart';
import 'package:pas_app/Api/NeedWork/schoolmodel.dart';
import 'package:pas_app/Api/NeedWork/usermodel.dart';
import 'package:pas_app/Api/NeedWork/workexpmodel.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:pas_app/Api/Services/porto_service.dart';
import 'package:pas_app/Api/Services/school_services.dart';
import 'package:pas_app/Api/Services/user_services.dart';
import 'package:pas_app/Api/Services/workexp_services.dart';
import 'package:pas_app/GetStarted/OnBoardingFinal.dart';
import 'package:pas_app/Screen/Profile/EditProfileScreen.dart';
import 'package:pas_app/Screen/Profile/SchoolUser/listschooluser.dart';
import 'package:pas_app/Screen/Profile/WorkExperience/ListWorkExperienceUser.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final transformationController = TransformationController();
  User? user;
  Schooldatauser? schooldatauser;
  Workexpbyuser? workexpbyuser;
  PortofolioModel? portofolioModel;
  bool isload = true;
  File? _imageFile;
  String outputDateupdate = '';

  void getUser() async {
    Apirespose response = await getuserdetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;

        setState(() {
          var inputFormat = DateFormat('yyyy-MM-dd');
          var inputDate = inputFormat.parse(user!.tanggal_lahir ?? '');
          var outputFormat = DateFormat('dd-MM-yyyy');
          var outputDate = outputFormat.format(inputDate);
          outputDateupdate = outputDate;
        });
      });

      Apirespose ress = await getschooluser(user!.id.toString());
      if (response.error == null) {
        setState(() {
          schooldatauser = ress.data as Schooldatauser;
        });
        Apirespose res = await getworkexpbyuser(user!.id.toString());
        if (response.error == null) {
          setState(() {
            workexpbyuser = res.data as Workexpbyuser;
          });
          Apirespose resporto = await getportouser(user!.id.toString());
          if (response.error == null) {
            setState(() {
              portofolioModel = resporto.data as PortofolioModel;
              isload = false;
            });
          }
        }
      }
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isload
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [popupmenu()],
              title: Text(
                "Profile",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 123, 245),
                    fontWeight: FontWeight.bold),
              ),
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: isload
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            header(),
                            personaldata(),
                            workexperience(),
                            education(),
                            getportowidget()
                          ],
                        ),
                      ),
                    ],
                  ));
  }

  Widget popupmenu() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: PopupMenuButton(
          onSelected: (result) {
            if (result == 0) {
              Navigatetoeditprofile(context);
            } else if (result == 3) {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure to logout?"),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No")),
                    TextButton(
                        onPressed: () {
                          logout().then((value) => {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OnBoardingFinal()),
                                    (route) => false)
                              });
                        },
                        child: Text("Yes")),
                  ],
                ),
              );
            }
          },
          child: Icon(
            Icons.more_vert,
            color: Color.fromARGB(255, 0, 123, 245),
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
                            'Edit Profile',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ],
                    )),
                PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.help,
                          color: Colors.black,
                          size: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Pusat Bantuan',
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
                          Icons.settings,
                          color: Colors.black,
                          size: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Settings',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ],
                    )),
                PopupMenuItem(
                    value: 3,
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                          size: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Logout',
                            style: TextStyle(fontSize: 15, color: Colors.red),
                          ),
                        ),
                      ],
                    )),
              ]),
    );
  }

  Widget header() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    content: Center(
                      child: InteractiveViewer(
                        boundaryMargin: EdgeInsets.all(20.0),
                        transformationController: transformationController,
                        minScale: 0.1,
                        maxScale: 1.6,
                        onInteractionEnd: (details) {
                          setState(() {
                            transformationController.toScene(Offset.zero);
                          });
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              user!.image_profile.toString(),
                              fit: BoxFit.fill,
                            )),
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: _imageFile == null
                        ? user!.image_profile != null
                            ? DecorationImage(
                                image: NetworkImage('${user!.image_profile}'),
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: AssetImage(
                                    'Asset/Image/userImage/defaultuser.png'),
                                fit: BoxFit.cover)
                        : DecorationImage(
                            image: FileImage(_imageFile ?? File('')),
                            fit: BoxFit.cover),
                    color: Color.fromARGB(255, 149, 149, 149)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Text(
                user!.name ?? '',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 1),
              alignment: Alignment.center,
              child: Text(
                user!.skill ?? 'Tidak Diketahui',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color.fromARGB(255, 124, 124, 124)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget personaldata() {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        elevation: 5,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 280,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.people),
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(left: 20, right: 100),
                          child: Text("Personal Data",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfileScreen(),
                                  ));
                            },
                            child: Icon(Icons.edit),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 280,
                            child: Column(
                              children: [
                                Container(
                                  width: 280,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Phone',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          ': ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        width: 205,
                                        child: Text(
                                          '+62' + user!.phone_number.toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 280,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Email',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          ': ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        width: 205,
                                        child: Text(
                                          user!.email ?? '',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 280,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Lahir',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          ': ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        width: 205,
                                        child: Text(
                                          user!.tempat_lahir.toString() +
                                              ", " +
                                              outputDateupdate.toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 280,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Alamat',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          ': ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        width: 205,
                                        child: Text(
                                          user!.alamat_lengkap ??
                                              'Alamat Belum Disetel',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 280,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Agama',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          ': ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        width: 205,
                                        child: Text(
                                          user!.agama ?? '',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 280,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Kelamin',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          ': ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Container(
                                        width: 205,
                                        child: Text(
                                          user!.jenis_kelamin ?? '',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget workexperience() {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        elevation: 5,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: 320,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.work_rounded),
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(left: 20, right: 100),
                        child: Text("Work Experience",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigatetolistworkexp(context);
                          },
                          child: Icon(Icons.edit),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 5),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: workexpbyuser!.workexpsuser!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    workexpbyuser!
                                        .workexpsuser![index].namaPekerjaan
                                        .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    workexpbyuser!
                                        .workexpsuser![index].namaPerusahaan
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 124, 124, 124)),
                                  )),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    workexpbyuser!
                                            .workexpsuser![index].tanggalBekerja
                                            .toString() +
                                        " - " +
                                        workexpbyuser!.workexpsuser![index]
                                            .tanggalBerhenti
                                            .toString(),
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 124, 124, 124)),
                                  )),
                              Container(
                                  padding: EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  child: Text(
                                    workexpbyuser!
                                        .workexpsuser![index].description
                                        .toString(),
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 124, 124, 124)),
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget education() {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        elevation: 5,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: 320,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.cast_for_education_rounded),
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(left: 20, right: 100),
                        child: Text("Education",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigatetolistschool(context);
                          },
                          child: Icon(Icons.edit),
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: schooldatauser!.schoolusers!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 5),
                          child: Column(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    schooldatauser!
                                        .schoolusers![index].nameschool
                                        .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    schooldatauser!.schoolusers![index].major
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 124, 124, 124)),
                                  )),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    schooldatauser!
                                        .schoolusers![index].graduationYear
                                        .toString(),
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 124, 124, 124)),
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getportowidget() {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        elevation: 5,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: 320,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.book_sharp),
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(left: 20, right: 100),
                        child: Text("Portofolio",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigatetolistschool(context);
                          },
                          child: Icon(Icons.edit),
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: portofolioModel!.portofolio!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 300,
                          padding: EdgeInsets.only(top: 5),
                          child: Column(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    width: 55,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.black,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                          portofolioModel!
                                              .portofolio![index].image
                                              .toString(),
                                        ))),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                          width: 200,
                                          child: Text(
                                            portofolioModel!
                                                .portofolio![index].judul
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Container(
                                          width: 200,
                                          child: Text(
                                            portofolioModel!
                                                .portofolio![index].deskripsi
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 124, 124, 124)),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> Navigatetolistworkexp(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListWorkExperienceUser()),
    );
    if (!mounted) return;
    setState(() {
      isload = true;
      getUser();
    });
  }

  Future<void> Navigatetolistschool(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListSchooluser()),
    );
    if (!mounted) return;
    setState(() {
      isload = true;
      getUser();
    });
  }

  Future<void> Navigatetoeditprofile(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen()),
    );
    if (!mounted) return;
    setState(() {
      isload = true;
      getUser();
    });
  }
}
