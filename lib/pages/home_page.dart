///page 1
import 'dart:convert';
import 'dart:typed_data';

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
    garage();
    //detect
  }

  bool wal3 = false;


  bool selectedHome = false;

  bool notify = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
            title: const Text('S.Homey',
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
            child: const drawer()),
        body: Stack(
          children: [

            RefreshIndicator(
                child: Card(
                  margin: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child:ListView(
                    scrollDirection: Axis.vertical,
                    children: !selectedHome ? [
                      DropdownButton<String>(
                      //branch
                      value: dropdownHomeValue,
                      icon: const Icon(
                        Icons.arrow_downward,
                        size: 30,
                        color: Colors.black,
                      ),
                      elevation: 16,
                      style: const TextStyle(
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

                          garage();

                          setState((){
                            dropdownHomeValue = newValue!;
                          });


                          if(newValue != "select a home"){

                            setState((){
                              selectedHome = true;
                              dropdownHomeValue = newValue!;
                            });

                          }

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
                    ]
                        :[
                      DropdownButton<String>(
                        //branch
                        value: dropdownHomeValue,
                        icon: const Icon(
                          Icons.arrow_downward,
                          size: 30,
                          color: Colors.black,
                        ),
                        elevation: 16,
                        style: const TextStyle(
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

                            garage();

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
                        leading: const Icon(Icons.devices, size: 50.0),
                        title: const Text('Devices',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600)),
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();

                          prefs.setString('checkDoors', '1');

                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => const Rooms()));

                          setState(() {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                      child:
                                      const Center(child: CircularProgressIndicator()));
                                });
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.kitchen, size: 50.0),
                        title: const Text('kitchens',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600)),
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();

                          prefs.setString('checkDoors', '0');
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const Kitchen()));

                          setState(() {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                      child:
                                      const Center(child: CircularProgressIndicator()));
                                });
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.bathroom, size: 50.0),
                        title: const Text('Bathrooms',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600)),
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();

                          prefs.setString('checkDoors', '1');

                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const Bathrooms()));

                          setState(() {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                      child:
                                      const Center(child: CircularProgressIndicator()));
                                });
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.security,
                          size: 50.0,
                        ),
                        title: const Text('Security',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600)),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const Security()));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.home_filled, size: 50.0),
                        title: const Text('Garden',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600)),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const Garden()));

                          setState(() {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                      child:
                                      const Center(child: CircularProgressIndicator()));
                                });
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.garage, size: 50.0),
                        title: const Text('Garage',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600)),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const Garage()));
                          setState(() {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                      child:
                                      const Center(child: CircularProgressIndicator()));
                                });
                          });
                        },
                      ),

                      //add car
                      ListTile(
                        leading: const Icon(Icons.garage, size: 50.0),
                        title: const Text('Add new Car',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600)),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => const addNewCars()));
                        },
                      ),






                      ListTile(
                        leading: const Icon(Icons.language, size: 50.0),
                        title: const Text('Website',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600)),
                        onTap: () {
                          _launchURLBrowser();
                        },
                      ),


                    ],
                  ),
                ),
                onRefresh: () => _CheckLogin()),

            notify
                ? SizedBox(
                     width: MediaQuery.of(context).size.width - 10,
                    height: 300,
                    child: Container(
                       color: Colors.red,
                      child: Column(
                        children: [

                          Row(
                            children: [
                              IconButton(
                              onPressed: () async{

                                setState((){
                                  notify = false;
                                });

                              },
                        icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 50,
                        )),
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),


                          SizedBox(
                            width: 200,
                              height: 200,
                              child: Image.memory(bytes)
                          ),

                          Row(
                            children: [

                              ElevatedButton(
                                  child:  const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text("Open Door",
                                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600))
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pink.shade400,
                                  ),
                                  onPressed: () async {

                                    final url = Uri.parse(
                                        'https://shomey-test-default-rtdb.firebaseio.com/garage/-N5wRpyOt2REV7xvImHo.json');


                                    await http
                                        .patch(
                                      url,
                                      body: json.encode({
                                        'value': 1,
                                      }),
                                    ).then((value) {
                                      setState((){
                                        notify = false;
                                      });
                                    });

                                  }
                              ),
                              ElevatedButton(
                                  child:  const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text("cancel",
                                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600))
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pink.shade400,
                                  ),
                                  onPressed: () async {


                                    setState((){
                                      notify = false;
                                    });


                                  }
                              )

                            ],
                          ),

                        ],
                      ),
                       ),
            )
                : Container(),


          ],
        ));
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
     // _alert();
    } else {
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  //fire goes here
  void _alert() async {
    print("socket from inside is:");

    FirebaseDatabase.instance
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

  void garage() async {
    print("socket from inside is:");




      FirebaseDatabase.instance
          .reference()
          .child('garage/-N5wRpyOt2REV7xvImHo/image')
          .onValue
          .listen((event) {
        event.snapshot.value != ""
            ? startNotify()
             : null;
        print("is switched from inside is: ");

        setState(() {});
      });
      //print(isSwitched);
      //  print("newValue: "+ newValue.toString());



  }

 // var file = io.File("decodedBezkoder.png");

  late Uint8List bytes;

  void startNotify() async{

    final prefs = await SharedPreferences.getInstance();


    if(prefs.getString('selectedHome') == "-N5WgIJwaDyQHbciv74D"){



        final url = Uri.parse(
            'https://shomey-test-default-rtdb.firebaseio.com/garage/-N5wRpyOt2REV7xvImHo/image.json');


        await http.get(url).then((value) async {

          print(value.body);




          setState((){

            bytes = base64Decode(jsonDecode(value.body));

           // file.writeAsBytesSync(base64Decode(jsonDecode(value.body)));

            notify = true;
          });


        });


      }


  }

  void wal3ana() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(child: const Center(child: Text('Fire Fire')));
        });

    wal3 = true;
  }

  void getHomes() async {


    showDialog(
        barrierDismissible: false,
        context: context,
        builder:
            (BuildContext context) {
          return Container(
              child: const Center(
                  child:
                  CircularProgressIndicator()));
        });



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


        Navigator.of(context).pop();


        setState(() {
          Homes += loadDataa;
          dropdownHomeValue = Homes[0].homeName;
        });
      });
    } catch (error) {
      rethrow;
    }
  }
}

//pushNamed(routeName)
