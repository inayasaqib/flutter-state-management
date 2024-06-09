import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var count = 0.obs;
  increment() => count++;
}

class HomeController extends GetxController {
  int counterValue = 0;
  TextEditingController amountValue = TextEditingController();
  List historyData = [];

  addValue() {
    counterValue++;
    update();
    print(counterValue);
  }

  addAmount() {
    print(amountValue.text);
    counterValue = counterValue + int.parse(amountValue.text);
    Get.snackbar("Amount Status", "Amount Added",
        snackPosition: SnackPosition.BOTTOM);
    historyData.add({"amount": amountValue.text, "type": "Credit"});
    update();
    print(historyData);
  }

  subAmount() {
    print(amountValue.text);
    counterValue = counterValue - int.parse(amountValue.text);
    historyData.add({"amount": amountValue.text, "type": "Debit"});
    print(historyData);
    update();
  }
}
