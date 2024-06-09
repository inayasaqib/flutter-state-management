import 'package:bankapp/color/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
           children: [
            CircleAvatar(
              backgroundColor: AppColors.black,
            ),
            Text("Email", style: TextStyle(fontSize: 20,),),
           ],
          ),
        ),
      )
    );
  }
}

