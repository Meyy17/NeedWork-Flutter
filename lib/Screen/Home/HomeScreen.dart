import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/NeedWork/Postmodel.dart';
import 'package:http/http.dart' as http;
import 'package:pas_app/Api/NeedWork/alluser.dart';
import 'package:pas_app/Api/NeedWork/usermodel.dart';
import 'package:pas_app/Api/Response/responseapi.dart';
import 'package:pas_app/Api/Services/user_services.dart';
import 'package:pas_app/Screen/Home/DetailHomeScreen/DetailHomeScreen.dart';
import 'package:pas_app/Screen/Home/jobvacancy.dart';
import 'package:pas_app/Screen/Search/Search.dart';
import 'package:pas_app/Shimer/shimer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Post? post;
  User? user;
  Alluser? alluser;
  bool isloaded = true;
  String outputDateupdate = '';

  void getApi() async {
    Apirespose response = await getuserdetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
      });
    }

    final res = await http.get(
      Uri.parse(baseUrl + "/api/companyall"),
    );
    print("status code " + res.statusCode.toString());
    post = Post.fromJson(json.decode(res.body.toString()));

    setState(() {
      isloaded = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ));
              },
              icon: Icon(
                Icons.search,
                color: Color.fromARGB(255, 0, 123, 245),
              ))
        ],
        title: Text(
          "Eksplorasi",
          style: TextStyle(
              color: Color.fromARGB(255, 0, 123, 245),
              fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: isloaded
            ? ListView(
                children: [
                  ShimerWelcome(),
                  Shimerlistdata(),
                ],
              )
            : ListView(
                children: [welcome(), listdata()],
              ),
      ),
    );
  }

  Widget ShimerWelcome() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 16,
                          width: 50,
                          child: ShimmerWidget(height: 16, width: 50),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 16,
                          width: 200,
                          child: ShimmerWidget(height: 16, width: 1),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 4,
                ),
                Container(
                  width: 280,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: 150,
                        child: ShimmerWidget(height: 16, width: 150),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        height: 16,
                        width: 150,
                        child: ShimmerWidget(height: 16, width: 150),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 280,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 30,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: ShimmerWidget(height: 10, width: 120))),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget welcome() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 280,
                  child: Text(
                    "Haloo👋 \n" + user!.name.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Container(
                  width: 280,
                  child: Text(
                    "ayo cari pekerjaan sesuai dengan yang kamu minati sekarang yuk😊",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                Container(
                  width: 280,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 30,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchPage(),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 255, 102, 0)),
                            child: Row(
                              children: [
                                Text(
                                  'Explore Now',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.send, size: 12),
                              ],
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget Shimerlistdata() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailHomeScreen(
                        data: post!.data![index],
                      ),
                    ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                height: 50,
                                width: 50,
                                child: ShimmerWidget(height: 50, width: 50)),
                            SizedBox(
                              height: 4,
                            ),
                            Column(
                              children: [
                                Container(
                                    width: 200,
                                    child:
                                        ShimmerWidget(height: 10, width: 200)),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                    width: 200,
                                    child:
                                        ShimmerWidget(height: 10, width: 200)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 270,
                                  child: ShimmerWidget(height: 10, width: 200),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    width: 270,
                                    child:
                                        ShimmerWidget(height: 10, width: 200)),
                                Container(
                                  width: 270,
                                  child: ShimmerWidget(height: 10, width: 200),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            );
          }),
    );
  }

  Widget listdata() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: post!.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailHomeScreen(
                        data: post!.data![index],
                      ),
                    ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Container(
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
                                  post!.data![index].logoPerusahaan.toString()),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 200,
                                  child: Text(
                                    post!.data![index].contactPerusahaan
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  child: Text(
                                    post!.data![index].lokasiPerusahaan
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 144, 144, 144)),
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
                                  child: Text("Estimasi Gaji : " +
                                      post!.data![index].rangeGaji.toString()),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    width: 270,
                                    child: Text("Need : ")),
                                Container(
                                    width: 270,
                                    child: Text(post!.data![index].dibutuhkan
                                        .toString())),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            );
          }),
    );
  }
}
