import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/NeedWork/Post.dart';
import 'package:http/http.dart' as http;
import 'package:pas_app/Screen/Home/DetailHomeScreen/DetailHomeScreen.dart';

class Popular extends StatefulWidget {
  const Popular({Key? key}) : super(key: key);

  @override
  State<Popular> createState() => _JobVacancyState();
}

class _JobVacancyState extends State<Popular> {
  Post? post;
  bool isloaded = true;
  void PostWork() async {
    final res = await http.get(
      Uri.parse(baseUrl + "/api/needworkdata"),
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
    PostWork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloaded
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
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
                                          post!.data![index].alaryEstimate
                                              .toString()),
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        width: 270,
                                        child: Text("Need : ")),
                                    Container(
                                        width: 270,
                                        child: Text(post!.data![index].jobType
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
