import 'package:flutter/material.dart';
import 'package:pas_app/Api/NeedWork/Postmodel.dart';
import 'package:pas_app/Screen/Home/DetailHomeScreen/DetailHomeScreen.dart';
import 'package:pas_app/Screen/Home/HomeScreen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  var database;

  List<Data> onsave = <Data>[];

  //Open Database Local
  Future initDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'saved_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE saved(id INTEGER, companyName TEXT, companyLogo TEXT, companyLocation TEXT, aboutCompany TEXT, companyEmail TEXT, poster TEXT, jobDescription TEXT, skillRequirements TEXT, salaryEstimate TEXT, advantagesOfJoin TEXT, workSystem TEXT)',
        );
      },
      version: 1,
    );
    getSaved().then((value) {
      setState(() {
        onsave = value;
      });
    });
  }

  //Read
  Future<List<Data>> getSaved() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('saved');
    print(onsave.toString());

    return List.generate(maps.length, (i) {
      return Data(
        id: maps[i]['id'] as int,
        contactPerusahaan: maps[i]['companyName'] as String,
        logoPerusahaan: maps[i]['companyLogo'] as String,
        lokasiPerusahaan: maps[i]['companyLocation'] as String,
        tentangPerusahaan: maps[i]['aboutCompany'] as String,
        emailPerusahaan: maps[i]['companyEmail'] as String,
        banner: maps[i]['poster'] as String,
        dibutuhkan: maps[i]['jobDescription'] as String,
        persyaratan: maps[i]['skillRequirements'] as String,
        rangeGaji: maps[i]['salaryEstimate'] as String,
        lulusanMinimal: maps[i]['advantagesOfJoin'] as String,
        sistemkerja: maps[i]['workSystem'] as String,
      );
    });
  }

//Delete data
  Future<void> deleteResult(int? id) async {
    final db = await database;
    await db.delete(
      'saved',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  void initState() {
    super.initState();
    initDb();
  }

  @override
  Widget build(BuildContext context) {
    if (onsave.length > 0) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Saved",
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
              child: ListView.builder(
                  itemCount: onsave.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("Delete " +
                                onsave[index].contactPerusahaan.toString()),
                            content: Text("Are you sure you want to remove " +
                                onsave[index].contactPerusahaan.toString() +
                                " from your saved list?"),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    deleteResult(onsave[index].id!)
                                        .then((value) {
                                      getSaved().then((value) {
                                        setState(() {
                                          onsave = value;
                                        });
                                      });
                                    });
                                  },
                                  child: Text("Yes")),
                            ],
                          ),
                        );

                        // showModalBottomSheet(
                        //     context: context,
                        //     shape: const RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.only(
                        //         topLeft: Radius.circular(25.0),
                        //         topRight: Radius.circular(25.0),
                        //       ),
                        //     ),
                        //     builder: (context) {
                        //       return SizedBox(
                        //         height: 170,
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: const <Widget>[
                        //             ListTile(
                        //               onTap: ,
                        //               leading: Icon(Icons.delete),
                        //               title: Text("Delete"),
                        //             ),
                        //             ListTile(
                        //               leading:
                        //                   Icon(Icons.account_tree_outlined),
                        //               title:
                        //                   Text("applying for a job (Coming)"),
                        //             ),
                        //             ListTile(
                        //               leading: Icon(Icons.share),
                        //               title: Text("Share (Coming)"),
                        //             )
                        //           ],
                        //         ),
                        //       );
                        //     });
                      },
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailHomeScreen(
                                data: onsave[index],
                              ),
                            )).then((value) => initDb());
                        ;
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
                                      child: Image.network(onsave[index]
                                          .logoPerusahaan
                                          .toString()),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 200,
                                          child: Text(
                                            onsave[index]
                                                .contactPerusahaan
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Container(
                                          width: 200,
                                          child: Text(
                                            onsave[index]
                                                .lokasiPerusahaan
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
                                              onsave[index]
                                                  .rangeGaji
                                                  .toString()),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            width: 270,
                                            child: Text("Need : ")),
                                        Container(
                                            width: 270,
                                            child: Text(onsave[index]
                                                .dibutuhkan
                                                .toString())),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ),
                    );
                  })),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Saved",
            style: TextStyle(
                color: Color.fromARGB(255, 0, 123, 245),
                fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 90),
          child: Column(
            children: [
              Image.asset('Asset/Image/SaveAsset/SaveAsset.png'),
              Container(
                width: 300,
                child: Text(
                  "Kamu belum menyimpan apapun di sini!",
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
                  "Telusuri banyak peluang kerja dan simpan terlebih dahulu, untuk mempermudah anda melakukan survei pekerjaan",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
