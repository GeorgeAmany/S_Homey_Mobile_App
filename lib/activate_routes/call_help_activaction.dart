///page 8

import 'package:flutter/material.dart';

class SecurityCallHelpActivation extends StatefulWidget {
  const SecurityCallHelpActivation({Key? key}) : super(key: key);

  @override
  State<SecurityCallHelpActivation> createState() => _SecurityCallHelpActivationState();
}

class _SecurityCallHelpActivationState extends State<SecurityCallHelpActivation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Call Help Activation'),
          backgroundColor: Colors.amber.shade400
      ),

        body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(scrollDirection:Axis.vertical ,
                children: [

                  Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                          child: const Padding(
                              padding: EdgeInsets.all(15),
                              child: Text('Numbers',
                                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600))),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber.shade400,
                          ),
                          onPressed: (){}

                      )
                  ),

                ]
            )
        )
    );
  }
}
