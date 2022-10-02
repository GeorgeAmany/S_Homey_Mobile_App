///page 5

import 'package:flutter/material.dart';

class SecurityCameraActivation extends StatefulWidget {
  const SecurityCameraActivation({Key? key}) : super(key: key);

  @override
  State<SecurityCameraActivation> createState() => _SecurityCameraActivationState();
}

class _SecurityCameraActivationState extends State<SecurityCameraActivation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Camera Activation',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
          backgroundColor: Colors.amber.shade400
      ),
    );
  }
}
