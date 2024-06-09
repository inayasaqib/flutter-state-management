import 'package:bankapp/controllrs/countercontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Other extends StatelessWidget {
  final CounterController c = Get.find();

  @override
  Widget build(context) {
    return Scaffold(body: Center(child: Text("${c.count}")));
  }
}