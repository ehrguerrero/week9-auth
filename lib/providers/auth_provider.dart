import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:week9_authentication/models/user_model.dart';
import '../api/firebase_auth_api.dart';

class MyAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> uStream;
  User? userObj;

  MyAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => uStream;

  void fetchAuthentication() {
    uStream = authService.getUser();

    notifyListeners();
  }

  Future<void> signUp(String email, String password, UserDeets user,
      BuildContext context) async {
    await authService.signUp(email, password, user, context);
    notifyListeners();
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    await authService.signIn(email, password, context);
    notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
