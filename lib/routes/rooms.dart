///page 2
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:project/activate_routes/rooms_activation.dart';
import 'package:project/models/room_counter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/access.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  final Future<FirebaseApp> database = Firebase.initializeApp();
  List<RoomCounter> Room = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink.shade400,
        appBar: AppBar(
            title: const Text('Rooms',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
            backgroundColor: Colors.pink.shade400
        ),

        body: RefreshIndicator(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                    margin: const EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                   child: ListView.builder(
                      itemCount: Room.length,
                      itemBuilder: (context, index) {
                        return Padding(padding: EdgeInsets.all(7),
                          child: ElevatedButton(
                              child:  Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(Room[index].Name,
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600))
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.pink.shade400,
                              ),
                              onPressed: () async {
                                final prefs = await SharedPreferences.getInstance();
                                prefs.setString('clickedRoomID', Room[index].id);
                                prefs.setString('clickedRoomName', Room[index].Name);

                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RoomsActivation()));
                                setState(() {
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
                                });
                              }
                          ),);

                      },
                    )
                )
            ), onRefresh: () => _getRooms())
    );
  }


  Future<void> _getRooms() async {




    Room = [];

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

        List<RoomCounter> loadDataa = [];

        for(int i = 0; i< loadData.length; i++){

        if(loadData[i].type == "2"){

          String RoomID = loadData[i].objectID;


          final url = Uri.parse(
              'https://shomey-test-default-rtdb.firebaseio.com/Rooms/$RoomID.json');

          await http.get(url).then((value) async{

            final extractedData = json.decode(value.body);


              if(extractedData['type']=='1') {


                final prefs = await SharedPreferences.getInstance();

///---------------------------select the rooms of the selected house------------------------------------------------------
                if(prefs.getString('selectedHome') == extractedData['HomeID']){

                  loadDataa.add(RoomCounter(
                    id: RoomID,
                    Name: extractedData['Name'],
                    HomeID: extractedData['HomeID'],
                    type: extractedData['type'],
                    socketsN: extractedData['socketsN'],
                      ));

                  }
///-------------------------------------------------------------------------------

              }


          });

        }

        if(i==(loadData.length-1)){
          Navigator.of(context).pop();
        }

        }

        setState(() {
          Room = loadDataa;
        });

      });



    } catch (error) {
      throw (error);
    }




  }


}


