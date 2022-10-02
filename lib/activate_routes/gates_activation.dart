///page 6

import 'package:flutter/material.dart';

class SecurityGatesActivation extends StatefulWidget {
  const SecurityGatesActivation({Key? key}) : super(key: key);

  @override
  State<SecurityGatesActivation> createState() => _SecurityGatesActivationState();
}

class _SecurityGatesActivationState extends State<SecurityGatesActivation> {

  bool isSwitched = true ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber.shade400,
      appBar: AppBar(
          title: const Text('Gates Activation',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
          backgroundColor: Colors.amber.shade400
      ),

        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 10,
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
                              title: Text('Gate',
                                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
                              trailing: Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                    print(isSwitched);
                                  });
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
            )
        )
    );
  }
}
