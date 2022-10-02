///page 1 => 10
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project/models/Sockets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import 'package:http/http.dart'as http;

import '../models/access.dart';


class Garage extends StatefulWidget {
  const Garage({Key? key}) : super(key: key);

  @override
  State<Garage> createState() => _GarageState();
}

class _GarageState extends State<Garage> {

  // late VideoPlayerController _videoPlayerController;


  String type = '';
  String id ='';


  String NameD = '';
  String typeD = '';
  String idD = '';
  String RoomIDD = '';
  int valueD = 0;
  String urlD = '';

// doors 16
  String doorName = '';
  String doorID = '';
  int doorValue =0;

//lamp 6
  String lampName =''  ;
  String lamptype ='' ;
  String lampid =  '' ;
  String lampRoomID = '' ;
  int lampvalue =  0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // playVideo();
    _getCamera();
  }


  // void playVideo() async{
  //   _videoPlayerController = VideoPlayerController.network("commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
  //   await _videoPlayerController.setLooping(true);
  //   await _videoPlayerController.initialize();
  //   //await _videoPlayerController.setVolume(0.0);
  //   await _videoPlayerController.play();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade400,
      appBar: AppBar(
          title: const Text('Garage',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
          backgroundColor: Colors.blue.shade400
      ),

        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
                margin: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                ),
              child: ListView(
                  scrollDirection:Axis.vertical ,
                  children: [


                    SizedBox(
                        height: 50, // fixed height
                        child: ListView.builder(
                          itemCount: 1 ,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('Door',
                                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
                              trailing: Switch(
                                value: doorValue == 1? true : false,
                                onChanged: (value) {

                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                            child:
                                            Center(child: CircularProgressIndicator()));
                                      });


                                  turnOn(doorID,doorValue);


                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            );
                          },
                        )
                    ),



                    // Container(
                    //   color: Colors.black,
                    //   child: SizedBox(
                    //     width: 200,
                    //     height: 200,
                    //     child: VideoPlayer(_videoPlayerController),
                    //   ),
                    // )



                  ]
              ),
            )
        )
    );
  }


  Future<void> _getCamera() async {


    final prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData').toString()) as Map<String, dynamic>;
    String userId = extractedUserData['id'].toString();


    final url = Uri.parse(
        'https://shomey-test-default-rtdb.firebaseio.com/access.json?orderBy="userID"&equalTo="$userId"');

    print("userId: " + userId);
    try {
      await http.get(url).then((value) async {


        print("response of session: " + value.body);

        //response.body?? "";

        final extractedData = json.decode(value.body);


        List<Access> loadData = [];


        extractedData?.forEach((Key, value) {
          loadData.add(Access(
            id: Key,
            objectID: value['objectID'],
            type: value['type'],
            userID: value['userID'],


          ));


        });




        for(int i = 0; i< loadData.length; i++){

          if(loadData[i].type == "2"){

            String RoomID = loadData[i].objectID;


            final url = Uri.parse(
                'https://shomey-test-default-rtdb.firebaseio.com/Rooms/$RoomID.json');

            await http.get(url).then((value) async {

              final extractedData = json.decode(value.body);

              if(extractedData['type']=='5') {

                setState(() {
/*
                  HomeID = extractedData['HomeID'];
                  Name = extractedData['Name'];
                  socketsN = extractedData['socketsN'];*/
                  type =extractedData['type'];
                  id = RoomID ;

                });



                /// get from devices
                final url = Uri.parse(
                    'https://shomey-test-default-rtdb.firebaseio.com/Devices.json?orderBy="RoomID"&equalTo="' +
                        id +
                        '"');



                await http.get(url).then((valuee) async {

                  final extractedDataa = json.decode(valuee.body);

                  extractedDataa?.forEach((Key, value) {

                    if(value['type'] == "17"){

                      NameD = value['Name'];

                      typeD = value['type'];

                      idD = Key;

                      RoomIDD = value['RoomID'];

                      valueD = value['value'];

                      urlD = value['url'];



                    }


                  });


                  //playVideo();


                });




              }


            });

            if(i==(loadData.length-1)){
              Navigator.of(context).pop();
            }

          }

          //remove this and call getData
           _getSockets();


        }


      });



    } catch (error) {
      throw (error);
    }

  }

  Future<void> _getSockets() async {


    /// read sheardpref

    String testSocketID = id;
    final url = Uri.parse(
        'https://shomey-test-default-rtdb.firebaseio.com/Devices.json?orderBy="RoomID"&equalTo="' +
            testSocketID +
            '"');

    await http.get(url).then((value) {


      final extractedData = json.decode(value.body);
      //loop
      extractedData?.forEach((key, value) {
      if(value['type'] == '6'){
// 6 lamp

        lampName = value['Name'];
        lamptype = value['type'];
        lampid = key;
        lampRoomID = value['RoomID'];
        lampvalue = value['value'];




        }else if(value['type'] == '15'){
// 15 doors
          doorName = value['Name'];
          doorID = key;
          doorValue = value['value'];

          getStatusDoors();

          // Name:
          //   type: value['type'],
          //   id: key,
          //   RoomID: value['RoomID'],
          //   value: value['value'],


        }


      });

      print(extractedData);


        getStatusLights();




    });
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



  void getStatusLights() async {
    print("socket from inside is: " + lampid.toString());

    await FirebaseDatabase.instance
        .reference()
        .child('Devices/' + lampid + '/value')
        .onValue
        .listen((event) {
      event.snapshot.value == 1
          ? lampvalue = 1
          : lampvalue = 0;
      print("is switched from inside is: " + lampvalue.toString());

      setState(() {});
    });
    //print(isSwitched);
    //  print("newValue: "+ newValue.toString());
  }



  Future<void> turnOn(String IDD , int valuee) async {
    print('$IDD');

    final url = Uri.parse(
        'https://shomey-test-default-rtdb.firebaseio.com/Devices/$IDD.json');

    await http
        .patch(
      url,
      body: json.encode({
        'value': valuee == 0 ? 1 : 0,
      }),
    )
        .then((valuee) {

      Navigator.of(context).pop();


    });
  }
}
