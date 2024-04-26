import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:week9_authentication/models/user_model.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<User?> getUser() {
    return auth.authStateChanges();
  }

  Future<void> signIn(String email, String password) async {
    UserCredential credential;
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //possible to return something more useful
        //than just print an error message to improve UI/UX
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signUp(String email, String password, UserDeets user) async {
    UserCredential credential;
    try {
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add other details
      await db.collection('users').doc(credential.user!.uid).set({
        'email': email,
        'firstName': user.firstName,
        'lastName': user.lastName,
      });
    } on FirebaseAuthException catch (e) {
      //possible to return something more useful
      //than just print an error message to improve UI/UX
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    auth.signOut();
  }
}
