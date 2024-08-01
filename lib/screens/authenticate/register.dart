import 'package:coffee_shop_app/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: const Text(
          "Sign up to Coffee Shop",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            label: const Text(
              "Sign in",
              style: TextStyle(color: Colors.black),
            ),
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) => val!.length < 6
                        ? 'Enter a password 6+ char long'
                        : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'please supply a valid email';
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[600]),
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  )
                ],
              ))),
    );
  }
}
