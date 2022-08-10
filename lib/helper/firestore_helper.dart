import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  final String categoriesCollectionName = 'Categories';
  addNewCategory() {}

  addNewUserToFirestore(String username, String email, String id) async {
    try {
      await firestoreInstance
          .collection('users')
          .doc(id)
          .set({'userName': username, 'email': email, 'id': id});
      print('created');
    } catch (e) {
      log('add new user');
      log(e.toString());
    }
  }

  getUserFromFirestore(String id) async {
    var ref = await firestoreInstance.collection('users').doc(id).get();
    log(ref.data().toString());
  }
}
