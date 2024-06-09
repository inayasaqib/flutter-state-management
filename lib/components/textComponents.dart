import 'package:bankapp/color/color.dart';
import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String textComponentValue;
  const TextComponent({super.key, required this.textComponentValue});

  @override
  Widget build(BuildContext context) {
    return Text(
      textComponentValue,
      style: const TextStyle(color: Colors.black, fontSize: 33),
    );
  }
}

class TextsComponent extends StatelessWidget {
  final String textComponentValue;
  const TextsComponent({super.key, required this.textComponentValue});

  @override
  Widget build(BuildContext context) {
    return Text(
      textComponentValue,
      style: const TextStyle(color: AppColors.white, fontSize: 33),
    );
  }
}
