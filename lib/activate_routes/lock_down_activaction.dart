///page 7

import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:project/models/Sockets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityLockDownActivation extends StatefulWidget {
  const SecurityLockDownActivation({Key? key}) : super(key: key);

  @override
  State<SecurityLockDownActivation> createState() => _SecurityLockDownActivationState();
}

class _SecurityLockDownActivationState extends State<SecurityLockDownActivation> {

  final Future<FirebaseApp> database = Firebase.initializeApp();
  // List<LockDown> confermUser = [];
  // String pass= '';
  // String id = '';


  bool isSwitched = false;
  List<Sockets> sockets = [];
  List<Sockets> lights = [];
  List<Sockets> devices = [];

  String title = '';

  bool doors = false;

  String doorName = '';
  String doorID = '';
  int doorValue = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkDoors();

    _getSockets();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amberAccent,
      appBar: AppBar(
          title: const Text('Check Home ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
          backgroundColor: Colors.amber.shade400,
      ),

        body: Padding(
          padding: const EdgeInsets.all(20),
          child: RefreshIndicator(
              child: ListView(
                scrollDirection: Axis.vertical,
                children:[

                  // Padding(
                  //     padding: EdgeInsets.only(top: 20, bottom: 20),
                  //     child: TextField(
                  //         decoration: InputDecoration(
                  //             labelText: 'Enter your Password',
                  //             icon: Icon(Icons.lock)),
                  //         style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)
                  //     )
                  // ),
                  //
                  //
                  // Container(
                  //     width: double.infinity,
                  //     margin: const EdgeInsets.only(bottom: 10),
                  //     child: ElevatedButton(
                  //         child: const Padding(
                  //             padding: EdgeInsets.all(15),
                  //             child: Text('Confirm')),
                  //         style: ElevatedButton.styleFrom(
                  //           primary: Colors.amber.shade400,
                  //         ),
                  //         onPressed: ()
                  //           async {
                  //             _CheckNamePassword();
                  //
                  //           }
                  //
                  //
                  //     )
                  // ),




                  // Card(
                  //     elevation: 10,
                  //     margin: const EdgeInsets.all(10.0),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(25),
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         //inside Container white
                  //         Text('All Devices',
                  //             style: TextStyle(
                  //                 fontSize: 30.0, fontWeight: FontWeight.w600)),
                  //         SizedBox(
                  //             height: MediaQuery.of(context).size.height * 0.30,
                  //             width: MediaQuery.of(context).size.width - 5,
                  //             child: ListView.builder(
                  //               scrollDirection: Axis.horizontal,
                  //               itemCount: devices.length,
                  //               itemBuilder: (context, index) {
                  //                 return Padding(
                  //                     padding: const EdgeInsets.only(left: 5),
                  //                     child: SizedBox(
                  //                       height: MediaQuery.of(context).size.height * 0.22,
                  //                       width: MediaQuery.of(context).size.width * 0.60,
                  //                       child: Column(
                  //                         children: [
                  //                           Container(
                  //                               child: Image.asset(
                  //                                 'assets/images/' +
                  //                                     devices[index].type +
                  //                                     '.jpg',
                  //                                 fit: BoxFit.fill,
                  //                               )
                  //                           ),
                  //                           Row(
                  //                             mainAxisAlignment:
                  //                             MainAxisAlignment.spaceEvenly,
                  //                             children: [
                  //                               Text(
                  //                                 '${devices[index].Name}',
                  //                                 style: TextStyle(
                  //                                     fontSize: 20.0,
                  //                                     fontWeight: FontWeight.w600),
                  //                                 maxLines: 2,
                  //                                 overflow: TextOverflow.ellipsis,
                  //                               ),
                  //                               IconButton(
                  //                                 onPressed: () {
                  //                                   showDialog(
                  //                                       barrierDismissible: false,
                  //                                       context: context,
                  //                                       builder:
                  //                                           (BuildContext context) {
                  //                                         return Container(
                  //                                             child: Center(
                  //                                                 child:
                  //                                                 CircularProgressIndicator()));
                  //                                       });
                  //
                  //                                   turnOn(
                  //                                     devices[index].id,
                  //                                     devices[index].value,
                  //                                   );
                  //                                 },
                  //                                 icon: Icon(
                  //                                   Icons.power_settings_new,
                  //                                   size: MediaQuery.of(context).size.height * 0.035,
                  //                                   color: devices[index].value == 1 ? Colors.green : Colors.black,
                  //                                 ),
                  //                               )
                  //                             ],
                  //                           )
                  //                         ],
                  //                       ),
                  //                     ));
                  //               },
                  //             )
                  //
                  //         ),
                  //         SizedBox(
                  //           height: 25,
                  //         ),
                  //       ],
                  //     )
                  // ),


                  Card(
                      elevation: 10,
                      margin: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child :Column(
                          children: [

                            //inside Container white
                            Text('All Lights',
                                style: TextStyle(
                                    fontSize: 30.0, fontWeight: FontWeight.w600)),

                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.30,
                                width: MediaQuery.of(context).size.width - 5,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: lights.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.10,
                                          width: MediaQuery.of(context).size.width * 0.20,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text('${lights[index].Name}',
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.w600),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,),
                                                  IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder:
                                                              (BuildContext context) {
                                                            return Container(
                                                                child: Center(
                                                                    child:
                                                                    CircularProgressIndicator()
                                                                )
                                                            );
                                                          }
                                                      );

                                                      turnOn(
                                                        lights[index].id,
                                                        lights[index].value,
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.lightbulb,
                                                      size: MediaQuery.of(context).size.height * 0.035,
                                                      color: lights[index].value == 1 ? Colors.amber : Colors.black,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ));
                                  },
                                )
                            )
                          ]
                      )
                  ),



                  Card(
                      elevation: 10,
                      margin: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child :Column(
                          children: [

                            //inside Container white
                            Text('All Sockets',
                                style: TextStyle(
                                    fontSize: 30.0, fontWeight: FontWeight.w600)),

                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.30,
                                width: MediaQuery.of(context).size.width - 5,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: sockets.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.10,
                                          width: MediaQuery.of(context).size.width * 0.20,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text('${sockets[index].Name}',
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.w600),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,

                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder:
                                                              (BuildContext context) {
                                                            return Container(
                                                                child: Center(
                                                                    child:
                                                                    CircularProgressIndicator()
                                                                )
                                                            );
                                                          }
                                                      );

                                                      turnOn(
                                                        sockets[index].id,
                                                        sockets[index].value,
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.electrical_services_outlined,
                                                      size: MediaQuery.of(context).size.height * 0.035,
                                                      color: sockets[index].value == 1 ? Colors.pink : Colors.black,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ));
                                  },
                                )
                            )
                          ]
                      )
                  ),



                  Card(
                    elevation: 10,
                    margin: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('$doorName',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder:
                                    (BuildContext context) {
                                  return Container(
                                      child: Center(
                                          child:
                                          CircularProgressIndicator()
                                      )
                                  );
                                }
                            );

                            turnOn(
                              doorID,
                              doorValue,
                            );
                          },
                          icon: Icon(
                            Icons.door_back_door_outlined,
                            size: MediaQuery.of(context).size.height * 0.035,
                            color: doorValue == 1 ? Colors.amber : Colors.black,
                          ),
                        )
                      ],
                    ),
                  )

                ]

              ),
              onRefresh: _getSockets),

        )
    );
  }




  void getStatusDoors() async {
    print("socket from inside is: " + doorID.toString());

    await FirebaseDatabase.instance
        .reference()
        .child('Devices/' + doorID + '/value')
        .onValue
        .listen((event) {
      event.snapshot.value == 1
          ? doorValue = 1
          : doorValue = 0;
      print("is switched from inside is: " + doorValue.toString());


      setState(() {});
    });
    //print(isSwitched);
    //  print("newValue: "+ newValue.toString());
  }


  void getStatusDevices(int index) async {
    print("socket from inside is: " + devices[index].id.toString());

    await FirebaseDatabase.instance
        .reference()
        .child('Devices/' + devices[index].id + '/value')
        .onValue
        .listen((event) {
      event.snapshot.value == 1
          ? devices[index].value = 1
          : devices[index].value = 0;
      print("is switched from inside is: " + devices[index].value.toString());

      setState(() {});
    });
    //print(isSwitched);
    //  print("newValue: "+ newValue.toString());
  }


  void getStatusLights(int index) async {
    print("socket from inside is: " + lights[index].id.toString());

    await FirebaseDatabase.instance
        .reference()
        .child('Devices/' + lights[index].id + '/value')
        .onValue
        .listen((event) {
      event.snapshot.value == 1
          ? lights[index].value = 1
          : lights[index].value = 0;
      print("is switched from inside is: " + lights[index].value.toString());

      setState(() {});
    });
    //print(isSwitched);
    //  print("newValue: "+ newValue.toString());
  }


  void getStatusSockets(int index) async {
    print("socket from inside is: " + sockets[index].id.toString());

    await FirebaseDatabase.instance
        .reference()
        .child('Devices/' + sockets[index].id + '/value')
        .onValue
        .listen((event) {
      event.snapshot.value == 1
          ? sockets[index].value = 1
          : sockets[index].value = 0;
      print("is switched from inside is: " + sockets[index].value.toString());

      setState(() {});
    });
    //print(isSwitched);
    //  print("newValue: "+ newValue.toString());
  }




  Future<void> _getSockets() async {


    /// read sheardpref
    // final prefs = await SharedPreferences.getInstance();

    // setState(() {
    //   title = prefs.getString('clickedRoomName').toString();
    // });

    // String testSocketID = prefs.getString('clickedRoomID').toString();
    //
    // print("test socked id: " + testSocketID);

    // final url = Uri.parse(
    //     'https://shomey-test-default-rtdb.firebaseio.com/Devices.json?orderBy="RoomID"&equalTo="' +
    //         testSocketID +
    //         '"');

    final url = Uri.parse(
        'https://shomey-test-default-rtdb.firebaseio.com/Devices.json?orderBy="RoomID"');

    await http.get(url).then((value) {
      List<Sockets> devicesListtt = [];
      List<Sockets> lightsListtt = [];
      List<Sockets> SocketsListtt = [];

      final extractedData = json.decode(value.body);
      //loop
      extractedData?.forEach((key, value) {

        if(value['type'] == '1'){


          SocketsListtt.add(Sockets(
            Name: value['Name'],
            type: value['type'],
            id: key,
            RoomID: value['RoomID'],
            value: value['value'],
          ));


        } else if(value['type'] == '6'){

          lightsListtt.add(Sockets(
            Name: value['Name'],
            type: value['type'],
            id: key,
            RoomID: value['RoomID'],
            value: value['value'],
          ));


        }else if(value['type'] == '15'){

          doorName = value['Name'];
          doorID = key;
          doorValue = value['value'];

          getStatusDoors();

          // Name:
          //   type: value['type'],
          //   id: key,
          //   RoomID: value['RoomID'],
          //   value: value['value'],


        } else{

          devicesListtt.add(Sockets(
            Name: value['Name'],
            type: value['type'],
            id: key,
            RoomID: value['RoomID'],
            value: value['value'],
          ));


        }


      });

      print(extractedData);

      setState(() {
        sockets = SocketsListtt;
        lights = lightsListtt;
        devices = devicesListtt;

      });


      for (int i = 0; i < sockets.length; i++) {
        print("i:" + i.toString());

        getStatusSockets(i);
      }



      for (int i = 0; i < devices.length; i++) {
        print("i:" + i.toString());

        getStatusDevices(i);
      }




      for (int i = 0; i < lights.length; i++) {
        print("i:" + i.toString());

        getStatusLights(i);
      }


      Navigator.of(context).pop();

    });
  }

  Future<void> turnOn(String id, int v) async {
    print('$id');

    final url = Uri.parse(
        'https://shomey-test-default-rtdb.firebaseio.com/Devices/$id.json');

    await http
        .patch(
      url,
      body: json.encode({
        'value': v == 0 ? 1 : 0,
      }),
    )
        .then((value) {

      _getSockets();
    });
  }

  Future<void> _checkDoors() async {

    final prefs = await SharedPreferences.getInstance();

    String testSocketID = prefs.getString('checkDoors').toString();

    if(testSocketID=='1'){
      setState(() {
        doors = true;
      });
    }else{
      setState(() {
        doors = false;
      });
    }

  }

}
