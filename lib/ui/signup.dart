import 'package:bankapp/color/color.dart';
import 'package:bankapp/components/texttypes.dart';
import 'package:bankapp/ui/homeview.dart';
import 'package:bankapp/ui/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
   SignupPage({super.key});
    final emailController = TextEditingController();
  final passwordController = TextEditingController();

   registerUser() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
          emailController.clear();
      passwordController.clear();
      print("=============== SignedUp Successfully ===================");
     Get.to(HomeView());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.black,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Column(
                  children: <Widget>[
                    SizedBox(height: 60.0),
                    Text(
                      "Sign up",
                      style: TextStyles.header,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create your account",
                      style: TextStyles.subHeader,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    TextField(
                      style: TextStyles.inputText,
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: AppColors.white,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.email,
                            color: AppColors.black,
                          )),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      style: TextStyles.inputText,
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: AppColors.white,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.password,
                          color: AppColors.black,
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    child: ElevatedButton(
                      onPressed: () async {
                      await registerUser();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.green,
                      ),
                      child: const Text(
                        "Sign up",
                        style: TextStyles.buttonText,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?",
                        style: TextStyles.subHeader),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 16, color: AppColors.green),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
