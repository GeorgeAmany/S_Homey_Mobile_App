///page 8

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;


class SecurityCallHelpActivation extends StatefulWidget {
  const SecurityCallHelpActivation({Key? key}) : super(key: key);

  @override
  State<SecurityCallHelpActivation> createState() => _SecurityCallHelpActivationState();
}

class _SecurityCallHelpActivationState extends State<SecurityCallHelpActivation> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //continue from here
     _getInfo();

  }

  String idToEdit = "";
  TextEditingController N1 = TextEditingController();
  TextEditingController N2 = TextEditingController();
  TextEditingController text = TextEditingController();

  String userId = "";

  Future<void> _getInfo() async {




    /// read sheardpref
    final prefs = await SharedPreferences.getInstance();

    final extractedUserData = json.decode(prefs.getString('userData').toString()) as Map<String, dynamic>;
    userId = extractedUserData['id'].toString();



    final url = Uri.parse(
        'https://shomey-test-default-rtdb.firebaseio.com/callHelp.json?orderBy="userID"&equalTo="' + userId + '"');

    await http.get(url).then((value) {


      final extractedData = json.decode(value.body);
      //loop
      extractedData?.forEach((key, value) {


        setState(() {

          idToEdit = key;
          N1.text = value['N1'];
          N2.text = value['N2'];
          text.text= value['text'];


        });

      });

      print(extractedData);



    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amberAccent,
      appBar: AppBar(
          title: const Text('Call Help '),
          backgroundColor: Colors.amber.shade400
      ),

        body: Padding(
            padding: EdgeInsets.all(10),

            child: Card(
              elevation: 10,
                margin: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                ),
                  child: ListView(

                    scrollDirection:Axis.vertical ,
                    children: [


                      SizedBox(
                          height: 80, // fixed height
                        child :Container(
                            margin: EdgeInsets.all(10.0),
                            padding:  EdgeInsets.all(1.0),
                                 decoration: BoxDecoration(
                                 border: Border.all(color: Colors.black)
                            ),
                            child: ListView.builder(
                              itemCount: 1 ,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 20),
                                  child: TextField(
                                    controller: N1,
                                      decoration: InputDecoration(
                                        labelText: 'First Emergency Number: ',
                                        labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                                      )

                                  ),
                                );

                              },
                            )
                        ),
                      ),

                      SizedBox(
                        height: 80, // fixed height
                        child :Container(
                            margin: EdgeInsets.all(10.0),
                            padding:  EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: ListView.builder(
                              itemCount: 1 ,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 20),
                                  child: TextField(
                                      controller: N2,
                                      decoration: InputDecoration(
                                        labelText: 'Second Emergency Number: ',
                                        labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),

                                      )

                                  ),
                                );

                              },
                            )
                        ),
                      ),

                      SizedBox(
                        height: 250, // fixed height
                        child :Container(
                            margin: EdgeInsets.all(10.0),
                            padding:  EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: ListView.builder(
                              itemCount: 1 ,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 20),
                                  child: TextField(
                                      controller: text,

                                      maxLines: null,
                                      decoration: InputDecoration(
                                        labelText: "Text's Message: ",
                                        labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                                      )

                                  ),
                                );

                              },
                            )
                        ),
                      ),


                      SizedBox(
                          height: 60, // fixed height

                          child: ListView.builder(
                            itemCount: 1 ,
                            itemBuilder: (context, index) {
                              return ElevatedButton(

                                  child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text('Save',
                                          style: TextStyle(fontSize: 18.0,
                                              fontWeight: FontWeight.w600)
                                      )
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.amber.shade400,
                                  ),
                                  onPressed: () async{



                                    try{


                                      final url = Uri.parse(
                                          'https://shomey-test-default-rtdb.firebaseio.com/callHelp.json');

                                      if(text.text.isEmpty || N1.text.isEmpty){

                                      }else{

                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                  child:
                                                  Center(child: CircularProgressIndicator()));
                                            });

                                        await http
                                            .post(
                                          url,
                                          body: json.encode({
                                            'userID': userId,
                                            'N1': N1.text,
                                            'N2': N2.text,
                                            'text': text.text,

                                          }),
                                        ).then((value) {

                                          Navigator.of(context).pop();

                                        });

                                      }


                                    }catch(e){
                                      print(e);
                                    }


                                  }
                              );

                            },
                          )
                      ),


                      ],
                    )

          )
        )
    );
  }
}
