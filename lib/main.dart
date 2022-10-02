import 'package:flutter/material.dart';
import 'package:project/activate_routes/lock_down_activaction.dart';
import 'package:project/activate_routes/rooms_activation.dart';
import 'package:project/pages/home_page.dart';



void main() {

  runApp (const MyApp());
}
class MyApp extends StatelessWidget{

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
    );
  }
}

//SecurityLockDownActivation