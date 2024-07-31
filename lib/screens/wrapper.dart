import 'package:coffee_shop_app/models/user.dart';
import 'package:coffee_shop_app/screens/authenticate/authenticate.dart';
import 'package:coffee_shop_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
