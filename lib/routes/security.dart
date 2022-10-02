///page 4
import 'package:flutter/material.dart';
import 'package:project/activate_routes/call_help_activaction.dart';
import 'package:project/activate_routes/camera_%20activation.dart';
import 'package:project/activate_routes/gates_activation.dart';
import 'package:project/activate_routes/lock_down_activaction.dart';

class Security extends StatefulWidget {
  const Security({Key? key}) : super(key: key);

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink.shade400,
      appBar: AppBar(
          title: Text('Security',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
          backgroundColor: Colors.pink.shade400
      ),

        body: Padding(
            padding:  EdgeInsets.all(10.0),

                  child: Card(
                    elevation: 10,
                    margin: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: ListView(scrollDirection:Axis.vertical ,
                        children: [
                          SizedBox(
                              height: 60, // fixed height

                              child: ListView.builder(
                                itemCount: 1 ,
                                itemBuilder: (context, index) {
                                  return ElevatedButton(

                                      child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Text('Camera',
                                              style: TextStyle(fontSize: 18.0,
                                                  fontWeight: FontWeight.w600))
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.pink.shade400,
                                      ),
                                      onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecurityCameraActivation()));
                                      }
                                  );
                                },
                              )
                          ),


                          SizedBox(
                              height: 60, // fixed height
                              child: ListView.builder(
                                itemCount: 1 ,
                                itemBuilder: (context, index) {
                                  return ElevatedButton(
                                      child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Text('Gates',
                                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600))
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.pink.shade400,

                                      ),
                                      onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecurityGatesActivation()));
                                      }
                                  );

                                },
                              )
                          ),


                          SizedBox(
                              height: 60, // fixed height
                              child: ListView.builder(
                                itemCount: 1 ,
                                itemBuilder: (context, index) {
                                  return ElevatedButton(
                                      child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Text('Lock Down',
                                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600))
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.pink.shade400,
                                      ),
                                      onPressed: () async {


                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecurityLockDownActivation()));
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
                                  );
                                },
                              )
                          ),


                          SizedBox(
                              height: 60, // fixed height
                              child: ListView.builder(
                                itemCount: 1 ,
                                itemBuilder: (context, index) {
                                  return ElevatedButton(
                                      child:Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Text('Call Help',
                                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600))
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.pink.shade400,
                                      ),
                                      onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecurityCallHelpActivation()));
                                      }
                                  );
                                },
                              )
                          ),


                        ]
                    ),
                  ),


        )
    );
  }
}
