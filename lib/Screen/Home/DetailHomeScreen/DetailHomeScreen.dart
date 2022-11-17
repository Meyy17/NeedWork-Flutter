import 'package:flutter/material.dart';
import 'package:pas_app/Screen/Home/HomeScreen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../Api/NeedWork/Post.dart';

class DetailHomeScreen extends StatefulWidget {
  DetailHomeScreen({Key? key, required this.data}) : super(key: key);
  Data data;

  @override
  State<DetailHomeScreen> createState() => _DetailHomeScreenState();
}

class _DetailHomeScreenState extends State<DetailHomeScreen> {
  bool onthesave = false;
  var database;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDb();
  }

  //Open Database Local
  Future initDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'saved_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE saved(id INTEGER, companyName TEXT, companyLogo TEXT, companyLocation TEXT, companyDistrictAndProvince TEXT, aboutCompany TEXT, companyGallery TEXT, companyContact TEXT, companyEmail TEXT, poster TEXT, jobType TEXT, jobDescription TEXT, skillRequirements TEXT, salaryEstimate TEXT, advantagesOfJoin TEXT, workSystem TEXT)',
        );
      },
      version: 1,
    );
    onthesave = await read(widget.data.companyName);
    setState(() {});
  }

  //Read
  Future<bool> read(String? companyName) async {
    final Database db = await database;
    final data = await db
        .query('saved', where: "companyName = ?", whereArgs: [companyName]);
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //delete
  Future<void> delete(Data? data) async {
    final db = await database;
    await db.delete(
      'saved',
      where: "companyName = ?",
      whereArgs: [data!.companyName],
    );
    setState(() {
      onthesave = false;
    });
  }

//Insert data dari api ke database
  Future<void> insertApi(Data data) async {
    final db = await database;
    await db.insert(
      'saved',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    setState(() {
      onthesave = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                onthesave ? delete(widget.data) : insertApi(widget.data);
              },
              icon: onthesave
                  ? Icon(
                      Icons.bookmark,
                      color: Color.fromARGB(255, 0, 123, 245),
                    )
                  : Icon(
                      Icons.bookmark_border_rounded,
                      color: Colors.black,
                    )),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 0, 123, 245))),
        title: Text(
          widget.data.companyName.toString(),
          style: TextStyle(
              color: Color.fromARGB(255, 0, 123, 245),
              fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.data.companyGallery.toString(),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 210),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height: 50,
                                      width: 50,
                                      child: Image.network(
                                          widget.data.companyLogo.toString()),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 200,
                                          child: Text(
                                            widget.data.companyName.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          width: 200,
                                          child: Text(
                                            widget
                                                .data.companyDistrictAndProvince
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 144, 144, 144)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: 270,
                                          child: Text(
                                            widget.data.jobDescription
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 20),
                                            width: 270,
                                            child: Text("Estimasi Gaji : " +
                                                widget.data.alaryEstimate
                                                    .toString())),
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            width: 270,
                                            child: Text("Need : " +
                                                widget.data.jobType
                                                    .toString())),
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            width: 270,
                                            child: Text("Location : " +
                                                widget.data.companyLocation
                                                    .toString())),
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            width: 270,
                                            child: Text("Email : " +
                                                widget.data.companyEmail
                                                    .toString())),
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            width: 270,
                                            child: Text("Contact : " +
                                                widget.data.companyContact
                                                    .toString())),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(top: 20),
                                            width: 270,
                                            child: Text(
                                              "Tentang Perusahaan : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            width: 270,
                                            child: Text(widget.data.aboutCompany
                                                .toString())),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(top: 20),
                                            width: 270,
                                            child: Text(
                                              "Skill Yang Dibutuhkan : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            width: 270,
                                            child: Text(widget
                                                .data.skillRequirements
                                                .toString())),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(top: 20),
                                            width: 270,
                                            child: Text(
                                              "Keuntungan Bergabung Dengan Kami : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            width: 270,
                                            child: Text(widget
                                                .data.advantagesOfJoin
                                                .toString())),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(top: 20),
                                            width: 270,
                                            child: Text(
                                              "Sistem Kerja : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            width: 270,
                                            child: Text(widget.data.workSystem
                                                .toString())),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                    Container(
                        width: 200,
                        margin: EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Daftar sekarang"))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
