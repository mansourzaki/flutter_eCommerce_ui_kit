import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_ecommerce_ui_kit/auth/signin.dart';
import 'package:flutter_ecommerce_ui_kit/home/home.dart';
import 'package:flutter_ecommerce_ui_kit/router.dart';
import 'package:flutter_ecommerce_ui_kit/screens/login_screen.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth auth = FirebaseAuth.instance;
  signIn(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      AppRouter.NavigateWithReplacemtnToWidget(Home());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  signOut() {
    auth.signOut();
    AppRouter.NavigateWithReplacemtnToWidget(SignIn());
    
  }

  checkUser() async {
    User? user = auth.currentUser;
    if (user == null) {
      AppRouter.NavigateWithReplacemtnToWidget(SignIn());
    } else {
      AppRouter.NavigateWithReplacemtnToWidget(Home());
    }
  }

  User? getUserState(){
    User? user = auth.currentUser;
    return user;
  }

  Future<UserCredential?> signUp(String emailAddress, String password) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      
      return credential;
    
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
   
    } catch (e) {
      print(e);
      return null;
    }
  }

  
}
