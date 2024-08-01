import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  late final String uid;
  DatabaseService({required this.uid});

  final CollectionReference coffeeCollection =
      FirebaseFirestore.instance.collection("coffee");

  Future updateUserData(String suger, String name, int strength) async {
    return await coffeeCollection.doc(uid).set({
      'suger': suger,
      'name': name,
      'strength': strength,
    });
  }
}
