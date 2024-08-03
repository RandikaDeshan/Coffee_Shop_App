import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/models/coffee.dart';
import 'package:coffee_shop_app/models/user.dart';

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

  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Coffee(
          name: doc.get('name') ?? '',
          strength: doc.get('strength') ?? 0,
          sugers: doc.get('suger') ?? '0');
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      suger: snapshot.get('suger'),
      strength: snapshot.get('strength'),
    );
  }

  Stream<List<Coffee>> get coffee {
    return coffeeCollection.snapshots().map(_coffeeListFromSnapshot);
  }

  Stream<UserData> get userData {
    return coffeeCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
