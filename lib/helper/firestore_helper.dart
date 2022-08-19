import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce_ui_kit/models/category.dart';

import '../models/product.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  final String categoriesCollectionName = 'Categories';
  final String productsCollectionName = 'Proucts';

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

  Future<Category> addCategory(Category category) async {
    final x = await firestoreInstance
        .collection(categoriesCollectionName)
        .add(category.toMap());
    category.id = x.id;
    return category;
  }

  updateCategory(Category category) async {
    await firestoreInstance
        .collection(categoriesCollectionName)
        .doc(category.id)
        .update(category.toMap());
  }

  deleteCategory(Category category) async {
    await firestoreInstance
        .collection(categoriesCollectionName)
        .doc(category.id)
        .delete();
  }

  Future<List<Category>> getAllCategories() async {
    final ref =
        await firestoreInstance.collection(categoriesCollectionName).get();
    List<Category> cats = ref.docs.map((e) {
      Category category = Category.fromMap(e.data());
      category.id = e.id;
      return category;
    }).toList();
    print(cats);
    return cats;
  }

  Future<Product> addNewProduct(Product product, String catId) async {
    final prod = await firestoreInstance
        .collection(categoriesCollectionName)
        .doc(catId)
        .collection(productsCollectionName)
        .add(product.toMap());
    product.id = prod.id;
    return product;
  }

  Future<List<Product>> getAllProducts(String catId) async {
    final ref = await firestoreInstance
        .collection(categoriesCollectionName)
        .doc(catId)
        .collection(productsCollectionName)
        .get();
    List<Product> products = ref.docs.map((e) {
      Product product = Product.fromMap(e.data());
      product.id = e.id;
      return product;
    }).toList();
    print(products);
    return products;
  }

  updateProduct(Product product, String catId) async {
    await firestoreInstance
        .collection(categoriesCollectionName)
        .doc(catId)
        .collection(productsCollectionName)
        .doc(product.id)
        .update(product.toMap());
  }

  Future<List<Product>> getEveryProduct() async {
    List<Product> _products = [];
    final ref =
        await firestoreInstance.collection(categoriesCollectionName).get();
    ref.docs.forEach((e) async {
      final pros = await e.reference.collection(productsCollectionName).get();

      pros.docs.map((e) async {
        log(e.toString());
        log('in helper');
        Product product = Product.fromMap(e.data());
        product.id = e.id;
        _products.add(product);
        return product;
      }).toList();
    });

    return _products;
  }

  deleteProduct(Product product, String catId) {
    firestoreInstance
        .collection(categoriesCollectionName)
        .doc(catId)
        .collection(productsCollectionName)
        .doc(product.id)
        .delete();
  }

  Future<List<Product>> getAllProductsFromAllCategories() async {
    List<Product> prods = [];
    final ref =
        await firestoreInstance.collection(categoriesCollectionName).get();
    ref.docs.forEach((e) async {
      var x = await e.reference.collection(productsCollectionName).get();
      x.docs.map((e) {
        Product product = Product.fromMap(e.data());
        product.id = e.id;
        prods.add(product);
      });
    });
    return prods;
  }
}
