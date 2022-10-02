///page 1
import 'package:flutter/material.dart';

class Moods extends StatefulWidget {
  const Moods({Key? key}) : super(key: key);

  @override
  State<Moods> createState() => _MoodsState();
}

class _MoodsState extends State<Moods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Moods',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
          backgroundColor: Colors.pink.shade400
      ),

      body: Container(

      ),
    );
  }
}
