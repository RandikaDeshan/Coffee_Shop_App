import 'package:coffee_shop_app/models/user.dart';
import 'package:coffee_shop_app/services/database.dart';
import 'package:coffee_shop_app/shared/constants.dart';
import 'package:coffee_shop_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugers = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugers;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid!).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'update your settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'please enter a name' : null,
                    onChanged: (val) => setState(() {
                      _currentName = val;
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugers ?? userData.suger,
                      items: sugers.map((suger) {
                        return DropdownMenuItem(
                            value: suger, child: Text('$suger Sugers'));
                      }).toList(),
                      onChanged: (val) => setState(() {
                            _currentSugers = val;
                          })),
                  Slider(
                    value: (_currentStrength ?? userData.strength)!.toDouble(),
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength!],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength!],
                    onChanged: (val) => setState(() {
                      _currentStrength = val.round();
                    }),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[400],
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid!).updateUserData(
                              _currentSugers ?? userData.suger!,
                              _currentName ?? userData.name!,
                              _currentStrength ?? userData.strength!);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
