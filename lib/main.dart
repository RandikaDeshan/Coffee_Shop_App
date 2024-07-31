import 'package:coffee_shop_app/models/user.dart';
import 'package:coffee_shop_app/screens/wrapper.dart';
import 'package:coffee_shop_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD_61EUnUyaHQnbOtxa4zXf1oeO5Dj9cbw",
          appId: "1:698037865629:android:d85b7f6c0a280e8ddc9874",
          messagingSenderId: "698037865629",
          projectId: "service-center-a7af8"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_, __) => null,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
