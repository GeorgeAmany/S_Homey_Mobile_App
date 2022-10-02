///page 1
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/drawar.dart';
import 'package:project/models/access.dart';
import 'package:project/models/home.dart';
import 'package:project/pages/login_page.dart';
import 'package:project/routes/bathrooms.dart';
import 'package:project/routes/garage.dart';
import 'package:project/routes/garden.dart';
import 'package:project/routes/kitchen.dart';
import 'package:project/routes/moods.dart';
import 'package:project/routes/rooms.dart';
import 'package:project/routes/security.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../routes/new_car.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<FirebaseApp> database = Firebase.initializeApp();

  String dropdownHomeValue = "select a home";
  List<Home> Homes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _CheckLogin();
    //_alert();
  }

  bool wal3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
            title: const Text('SHomey',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
            backgroundColor: Colors.black54
        ),

        ///init drawar
        drawer: Theme(
            data: Theme.of(context).copyWith(
              // Set the transparency here
              canvasColor: Colors
                  .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
            ),
            child: drawer()),
        body: RefreshIndicator(
            child: Card(
              margin: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child:ListView(
                scrollDirection: Axis.vertical,
                children: [
                  DropdownButton<String>(
                    //branch
                    value: dropdownHomeValue,
                    icon: const Icon(
                      Icons.arrow_downward,
                      size: 30,
                      color: Colors.black,
                    ),
                    elevation: 16,
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.black45,
                    ),

                    ///--------------------selected home-----------------------------------------
                    onChanged: (newValue) {
                      setState(() async {

                        final prefs = await SharedPreferences.getInstance();


                        prefs.setString('selectedHome', Homes[Homes.indexWhere((f) => f.homeName == newValue)].ID);


                        dropdownHomeValue = newValue!;


                      });
                    },

                    ///----------------------------------------------------------------

                    items: Homes.map((value) {
                      return DropdownMenuItem<String>(
                        value: value.homeName,
                        child: Text(value.homeName),
                      );
                    }).toList(),
                  ),



                  ListTile(
                    leading: Icon(Icons.devices, size: 50.0),
                    title: Text('Devices',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600)),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();

                      prefs.setString('checkDoors', '1');
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => Rooms()));

                      setState(() {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  child:
                                  Center(child: CircularProgressIndicator()));
                            });
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.kitchen, size: 50.0),
                    title: Text('kitchens',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600)),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();

                      prefs.setString('checkDoors', '0');
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Kitchen()));

                      setState(() {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  child:
                                  Center(child: CircularProgressIndicator()));
                            });
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.bathroom, size: 50.0),
                    title: Text('Bathrooms',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600)),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();

                      prefs.setString('checkDoors', '1');

                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Bathrooms()));

                      setState(() {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  child:
                                  Center(child: CircularProgressIndicator()));
                            });
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.security,
                      size: 50.0,
                    ),
                    title: Text('Security',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600)),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Security()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.home_filled, size: 50.0),
                    title: Text('Garden',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600)),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Garden()));

                      setState(() {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  child:
                                  Center(child: CircularProgressIndicator()));
                            });
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.garage, size: 50.0),
                    title: Text('Garage',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600)),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Garage()));
                      setState(() {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  child:
                                  Center(child: CircularProgressIndicator()));
                            });
                      });
                    },
                  ),

                  //add car
                  ListTile(
                    leading: Icon(Icons.garage, size: 50.0),
                    title: Text('Add new Car',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600)),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => addNewCars()));
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.mood_sharp, size: 50.0),
                    title: Text('Moods',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600)),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => Moods()));
                    },
                  ),


                  ListTile(
                    leading: Icon(Icons.language, size: 50.0),
                    title: Text('Website',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600)),
                    onTap: () {
                      _launchURLBrowser();
                    },
                  ),
                ],
              ),
            ),
            onRefresh: () => _CheckLogin()));
  }

  _launchURLBrowser() async {
    const url = 'https://www.geeksforgeeks.org/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _CheckLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('userData')) {
      getHomes();
      _alert();
    } else {
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  void _alert() async {
    print("socket from inside is:");

    await FirebaseDatabase.instance
        .reference()
        .child('alert/value')
        .onValue
        .listen((event) {
      event.snapshot.value == 1
          ? wal3ana()
          : wal3
              ? {Navigator.of(context).pop(), wal3 = false}
              : null;
      print("is switched from inside is: ");

      setState(() {});
    });
    //print(isSwitched);
    //  print("newValue: "+ newValue.toString());
  }

  void wal3ana() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(child: Center(child: Text('Fire Fire')));
        });

    wal3 = true;
  }

  void getHomes() async {
    Homes = [];

    Homes.add(Home(
      ID: "",
      homeName: "select a home",
      Dimensions: "",
      Address: "",
      userId: "",
      RoomsNumber: "",
      garden: "",
      garage: "",
      security: "",
    ));

    final prefs = await SharedPreferences.getInstance();

    final extractedUserData = json
        .decode(prefs.getString('userData').toString()) as Map<String, dynamic>;
    String userId = extractedUserData['id'].toString();

    print("heerree" + userId);
    final url = Uri.parse(
        'https://shomey-test-default-rtdb.firebaseio.com/access.json?orderBy="userID"&equalTo="$userId"');

    print("userId: " + userId);
    try {
      await http.get(url).then((value) async {
        print("response of session: " + value.body);

        //resppatchonse.body?? "";

        final extractedData = json.decode(value.body);

        final List<Access> loadData = [];

        extractedData?.forEach((Key, value) {
          loadData.add(Access(
            id: Key,
            objectID: value['objectID'],
            type: value['type'],
            userID: value['userID'],
          ));
        });

        final List<Home> loadDataa = [];

        for (int i = 0; i < loadData.length; i++) {
          if (loadData[i].type == "1") {
            String homeID = loadData[i].objectID;

            final url = Uri.parse(
                'https://shomey-test-default-rtdb.firebaseio.com/Home/$homeID.json');

            await http.get(url).then((value) {
              final extractedData = json.decode(value.body);

              loadDataa.add(Home(
                ID: homeID,
                homeName: extractedData['homeName'],
                Dimensions: extractedData['Dimensions'],
                Address: extractedData['Address'],
                userId: extractedData['userId'],
                RoomsNumber: extractedData['RoomsNumber'],
                garden: extractedData['garden'],
                garage: extractedData['garage'],
                security: extractedData['security'],
              ));
            });
          }
        }

        setState(() {
          Homes += loadDataa;
          dropdownHomeValue = Homes[0].homeName;
        });
      });
    } catch (error) {
      throw (error);
    }
  }
}

//pushNamed(routeName)
