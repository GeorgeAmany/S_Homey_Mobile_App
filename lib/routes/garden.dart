///page 1 => 9

import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:project/models/access.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Garden extends StatefulWidget {
  const Garden({Key? key}) : super(key: key);

  @override
  State<Garden> createState() => _GardenState();
}

class _GardenState extends State<Garden> {

  final Future<FirebaseApp> database = Firebase.initializeApp();

  bool isSwitched = false ;

 String HomeID= '';
  String Name= '';
  String socketsN = '';
  String type = '';
  String id ='';



  String NameD = '';
  String typeD = '';
  String idD = '';
  String RoomIDD = '';
  int valueD = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGarden();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.blue.shade400,
      appBar: AppBar(
          title: const Text('Garden',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
          backgroundColor: Colors.blue.shade400
      ),

        body: Padding(
            padding: const EdgeInsets.all(10),
            child:RefreshIndicator(
            child:Card(
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
                              title: Text('Garden Sprinkler',
                                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
                              trailing: Switch(
                                value: valueD == 1? true : false,
                                onChanged: (value) {

                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder:
                                          (BuildContext context) {
                                        return Container(
                                            child: Center(
                                                child:
                                                CircularProgressIndicator()));
                                      });


                                  turnOn();

                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            );
                          },
                        )
                    ),
                  ]
              ),
            ),
                onRefresh: _getGarden),
        )
    );
  }



  Future<void> _getGarden() async {


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

              if(extractedData['type']=='2') {

                 setState(() {

                   HomeID = extractedData['HomeID'];
                   Name = extractedData['Name'];
                   socketsN = extractedData['socketsN'];
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

                  print("garden: " + valuee.body);


                  extractedDataa?.forEach((Key, value) {
                    setState(() {
                       NameD = value['Name'];
                      typeD = value['type'];
                       idD = Key;
                       RoomIDD = value['RoomID'];
                       valueD = value['value'];
                    });
                  });

                  await FirebaseDatabase.instance
                      .reference()
                      .child('Devices/' + idD + '/value')
                      .onValue
                      .listen((event) {
                    event.snapshot.value == 1
                        ? valueD = 1
                        : valueD = 0;
                    print("is switched from inside is: " + valueD.toString());

                    setState(() {


                    });
                  });


                });




              }

            });


          }

          if(i==(loadData.length-1)){
            Navigator.of(context).pop();
          }

        }


      });



    } catch (error) {
      throw (error);
    }

  }

  Future<void> turnOn() async {
    print('$idD');

    final url = Uri.parse(
        'https://shomey-test-default-rtdb.firebaseio.com/Devices/$idD.json');

    await http
        .patch(
      url,
      body: json.encode({
        'value': valueD == 0 ? 1 : 0,
      }),
    )
        .then((value) {
      Navigator.of(context).pop();

    });
  }






}
