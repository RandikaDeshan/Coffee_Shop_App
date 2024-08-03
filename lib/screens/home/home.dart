import 'package:coffee_shop_app/models/coffee.dart';
import 'package:coffee_shop_app/screens/home/coffee_list.dart';
import 'package:coffee_shop_app/screens/home/settings_form.dart';
import 'package:coffee_shop_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_shop_app/services/database.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              decoration: const BoxDecoration(color: Colors.grey),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: const SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Coffee>?>.value(
      value: DatabaseService(uid: '').coffee,
      initialData: null,
      child: Scaffold(
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
            ),
            TextButton.icon(
              onPressed: () => showSettingsPanel(),
              label: const Text(
                "Setings",
                style: TextStyle(color: Colors.black),
              ),
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/coffee_bg.png'),
                    fit: BoxFit.cover)),
            child: const CoffeeList()),
      ),
    );
  }
}
