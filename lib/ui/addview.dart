import 'package:bankapp/components/textComponents.dart';
import 'package:bankapp/controllrs/transactioncontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddView extends StatelessWidget {
  AddView({super.key});
  HomeController homeControl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Obx(() => TextComponent(
              textComponentValue:
                  "${homeControl.counterValue} ${Get.arguments}")),
          ElevatedButton(
              onPressed: () {
                Get.back(result: "I am Back");
              },
              child: const Text("back from this"))
        ],
      )),
    );
  }
}