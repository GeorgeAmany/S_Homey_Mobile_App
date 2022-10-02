///page 5

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../models/access.dart';
import '../models/camera_model.dart';
import '../models/room_counter.dart';
import 'package:http/http.dart'as http;



class SecurityCameraActivation extends StatefulWidget {
  const SecurityCameraActivation({Key? key}) : super(key: key);

  @override
  State<SecurityCameraActivation> createState() => _SecurityCameraActivationState();
}

class _SecurityCameraActivationState extends State<SecurityCameraActivation> {

  List<RoomCounter> Room = [];
  List<camera> cameras = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCameras();
  }


  Future<void> _getCameras() async {

    Room = [];
    cameras = [];

    final prefs = await SharedPreferences.getInstance();

    final extractedUserData = json.decode(prefs.getString('userData').toString()) as Map<String, dynamic>;
    String userId = extractedUserData['id'].toString();


    final url = Uri.parse(
        'https://shomey-test-default-rtdb.firebaseio.com/access.json?orderBy="userID"&equalTo="$userId"');

    print("userId: " + userId);
    try {
      await http.get(url).then((value) async {

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

        List<RoomCounter> loadDataa = [];
        List<camera> cameraList = [];

        for(int i = 0; i< loadData.length; i++){

          if(loadData[i].type == "2"){

            String RoomID = loadData[i].objectID;


            final url = Uri.parse(
                'https://shomey-test-default-rtdb.firebaseio.com/Rooms/$RoomID.json');

            await http.get(url).then((value) async {

              final extractedData = json.decode(value.body);


              if(extractedData['type']=='5') {

                if(prefs.getString('selectedHome') == extractedData['HomeID']) {

                  loadDataa.add(RoomCounter(
                    id: RoomID,
                    Name: extractedData['Name'],
                    HomeID: extractedData['HomeID'],
                    type: extractedData['type'],
                    socketsN: extractedData['socketsN'],
                  ));


                  final url = Uri.parse(
                      'https://shomey-test-default-rtdb.firebaseio.com/Devices.json?orderBy="RoomID"&equalTo="' +
                          RoomID +
                          '"');

                  await http.get(url).then((value) {


                    final extractedDataCamera = json.decode(value.body);


                    extractedDataCamera?.forEach((key, value) {

                      if(value['type'] == '17'){


                        cameraList.add(camera(
                          Name: value['Name'],
                          type: value['type'],
                          idToEdit: key,
                          RoomID: value['RoomID'],
                          value: value['value'],
                          url: value['url'],
                          controller: VideoPlayerController.network(value['url']),

                        ));


                      }

                    });


                  });



                }



              }


            });

          }


          if(i==(loadData.length-1)){
            Navigator.of(context).pop();
          }


        }
       // Navigator.of(context).pop();


        for(int z = 0; z<cameras.length; z++){

          cameras[z].controller..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });

        }


        setState(() {
          Room = loadDataa;

          cameras = cameraList;

        });

      });



    } catch (error) {
      throw (error);
    }




  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amberAccent,
      appBar: AppBar(
          title: const Text('Camera ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
          backgroundColor: Colors.amber.shade400
      ),

        body: RefreshIndicator(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  margin: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: ListView.builder(
                    itemCount: cameras.length,
                    itemBuilder: (context, index) {
                      return VideoPlayer(cameras[index].controller);

                    },
                  ),
                )
            ),
            onRefresh: () => _getCameras()
        )


    );
  }
}
