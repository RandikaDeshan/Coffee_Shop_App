import 'package:coffee_shop_app/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: const Text(
          "Coffee Shop",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            label: const Text(
              "Logout",
              style: TextStyle(color: Colors.black),
            ),
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
