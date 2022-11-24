import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:pas_app/Api/Constant/constant.dart';
import 'package:pas_app/Api/NeedWork/Postmodel.dart';
import 'package:http/http.dart' as http;
import 'package:pas_app/Screen/Home/DetailHomeScreen/DetailHomeScreen.dart';

class JobVacancy extends StatefulWidget {
  const JobVacancy({Key? key}) : super(key: key);

  @override
  State<JobVacancy> createState() => _JobVacancyState();
}

class _JobVacancyState extends State<JobVacancy> {
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
      backgroundColor: Colors.white,
      body: isloaded
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
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
                  child: Container(
                    width: 155,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: Image.network(
                                post!.data![index].logoPerusahaan.toString()),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2, bottom: 5),
                            width: 200,
                            child: Text(
                              post!.data![index].contactPerusahaan.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              post!.data![index].dibutuhkan.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 144, 144, 144)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              post!.data![index].lokasiPerusahaan.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 144, 144, 144)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
