import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  final String categoriesCollectionName = 'Categories';
  insertNewCategory() async{
    await firestoreInstance.collection(categoriesCollectionName).add(
        {"nameAr": "طعام", "nameEn": "Food", "imageUrl": "https://image.jpg"});
  }
}
