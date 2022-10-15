import 'package:flutter/material.dart';
import 'package:pas_app/Api/NeedWork/Post.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Post? post;
  void PostWork() async {
    final res = await http.get(
      Uri.parse("http://10.0.2.2:8000/api/needworkdata"),
    );
    print("status code " + res.statusCode.toString());
    post = Post.fromJson(json.decode(res.body.toString()));
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
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
                SizedBox(
                  height: 45,
                  width: 270,
                  child: TextField(
                    decoration: InputDecoration(
                        hoverColor: Colors.black,
                        filled: true,
                        fillColor: Colors.grey[400],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: "Search.....",
                        prefixIcon: Icon(
                          Icons.search,
                        )),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Center(
              child: ListView.builder(
                itemCount: post!.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Text(post!.data![index].companyName.toString()),
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
