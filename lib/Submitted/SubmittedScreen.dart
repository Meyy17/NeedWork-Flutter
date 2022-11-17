import 'package:flutter/material.dart';

class SubmittedScreen extends StatefulWidget {
  const SubmittedScreen({Key? key}) : super(key: key);

  @override
  State<SubmittedScreen> createState() => _SubmittedScreenState();
}

class _SubmittedScreenState extends State<SubmittedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Submitted",
          style: TextStyle(
              color: Color.fromARGB(255, 0, 123, 245),
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'Asset/Image/SubmittedAsset/Submitted.png',
                  height: 200,
                ),
                Container(
                  width: 300,
                  child: Text(
                    "Kamu belum mengajukan pekerjaan satupun",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 320,
                  child: Text(
                    "Cari pekerjaan dan daftarkan diri anda, dan cek lagi halaman ini secara berkala, untuk melihat apakah kamu diterima atau tidak",
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
