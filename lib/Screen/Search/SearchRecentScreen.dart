import 'package:flutter/material.dart';
import 'package:pas_app/Screen/Search/Search.dart';

class RecentSearchScreen extends StatefulWidget {
  const RecentSearchScreen({Key? key}) : super(key: key);

  @override
  State<RecentSearchScreen> createState() => _RecentSearchScreenState();
}

class _RecentSearchScreenState extends State<RecentSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 45),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ));
              },
              child: Container(
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[400],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                  child: Row(
                    children: [Icon(Icons.search), Text("Search")],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
