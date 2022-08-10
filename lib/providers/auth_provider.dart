import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_ui_kit/helper/auth_helper.dart';
import 'package:flutter_ecommerce_ui_kit/helper/firestore_helper.dart';
import 'package:flutter_ecommerce_ui_kit/helper/storage_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';

class AuthProvider with ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  User? user;
  validateNull(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field shouldn\'t be done';
    }
  }

  emailValiation(String? value) {
    if (!isEmail(value!)) {
      return 'Wrong email';
    }
  }

  logIn(String emailAddress, String password) async {
    AuthHelper.authHelper.signIn(emailAddress, password);

    notifyListeners();
  }

  signOut() async {
    AuthHelper.authHelper.signOut();
    notifyListeners();
  }

  getUserState() {
    user = AuthHelper.authHelper.getUserState();
    notifyListeners();
  }

  checkUser() async {
    AuthHelper.authHelper.checkUser();
  }

  signUp(String emailAddress, String password, String userName) async {
    UserCredential? user =
        await AuthHelper.authHelper.signUp(emailAddress, password);

    print(user);
    if (user != null) {
      print('in != null');
      await FirestoreHelper.firestoreHelper
          .addNewUserToFirestore(userName, emailAddress, user.user!.uid);
    }
  }

  Future<String> uploadImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    String x = await StorageHelper.storageHelper.uploadImage(File(xFile!.path));
    return x;
  }
}
