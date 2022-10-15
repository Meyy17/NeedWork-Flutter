import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pas_app/Api/NeedWork/Post.dart';
import 'package:http/http.dart' as http;
import 'package:pas_app/Screen/Home/DetailHomeScreen/DetailHomeScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Post? post;
  bool isloaded = true;
  void PostWork() async {
    setState(() {
      isloaded = false;
    });
    final res = await http.get(
      Uri.parse("http://10.0.2.2:8000/api/needworkdata"),
    );
    print("status code " + res.statusCode.toString());
    post = Post.fromJson(json.decode(res.body.toString()));
    setState(() {
      isloaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PostWork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        title: Text(
          "Explore",
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
        child: Center(
          child: isloaded == true
              ? ListView.builder(
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
                        elevation: 5,
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
                                      child: Image.network(post!
                                          .data![index].companyLogo
                                          .toString()),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 200,
                                          child: Text(
                                            post!.data![index].companyName
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          width: 200,
                                          child: Text(
                                            post!.data![index]
                                                .companyDistrictAndProvince
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
                                          child: Text("Estimasi Gaji : " +
                                              post!.data![index].salaryEstimate
                                                  .toString()),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            width: 270,
                                            child: Text("Need : ")),
                                        Container(
                                            width: 270,
                                            child: Text(post!
                                                .data![index].jobType
                                                .toString())),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ),
                    );
                  })
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
