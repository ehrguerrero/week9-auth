import 'package:flutter/material.dart';
import 'package:week9_authentication/api/firebase_users_api.dart';
import 'package:week9_authentication/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyUsersListProvider with ChangeNotifier {
  late FirebaseUsersAPI firebaseService;
  late Stream<QuerySnapshot> _usersStream;
  UserDeets? _selectedUsers;

  MyUsersListProvider() {
    firebaseService = FirebaseUsersAPI();
    fetchUsers();
  }

  // getter
  Stream<QuerySnapshot> get users => _usersStream;
  UserDeets get selected => _selectedUsers!;

  changeSelectedTodo(UserDeets item) {
    _selectedUsers = item;
  }

  void fetchUsers() {
    _usersStream = firebaseService.getAllUsers();
    notifyListeners();
  }
}
