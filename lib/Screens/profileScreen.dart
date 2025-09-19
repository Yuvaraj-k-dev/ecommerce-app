import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),

      body: Column(
        spacing: 10,
        children: [
          Center(
            child: Container(
              height: 70,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  Column(children: [Text('Username'), Text('Email address')]),
                  Icon(Iconsax.edit),
                ],
              ),
            ),
          ),
          Container(
            height: 450,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Iconsax.profile, size: 50, color: Colors.black),
                    Text('Account Details'),
                    Icon(Iconsax.arrow_down5, size: 50),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
