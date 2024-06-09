import 'package:bankapp/color/color.dart';
import 'package:bankapp/components/texttypes.dart';
import 'package:bankapp/controllrs/splash.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://static.vecteezy.com/system/resources/previews/021/363/337/original/bank-icon-for-your-website-mobile-presentation-and-logo-design-free-vector.jpg",
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome to BankApp',
                  style: TextStyles.splashText,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
