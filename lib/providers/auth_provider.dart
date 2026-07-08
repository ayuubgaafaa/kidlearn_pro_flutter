import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  UserModel? _user;
  bool _isLoading = false;
  bool _isAuthenticated = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _loadUserData(user.uid);
      } else {
        _user = null;
        _isAuthenticated = false;
        notifyListeners();
      }
    });
  }

  Future<void> _loadUserData(String uid) async {
    _isLoading = true;
    notifyListeners();
    try {
      DataSnapshot snapshot = await _db.child('users/$uid').get();
      if (snapshot.exists) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(snapshot.value as Map);
        _user = UserModel.fromJson({...data, 'uid': uid});
        _isAuthenticated = true;
      } else {
        _isAuthenticated = false;
      }
    } catch (e) {
      _isAuthenticated = false;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> register(
      String email, String password, String name, String role) async {
    _isLoading = true;
    notifyListeners();
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel newUser = UserModel(
        uid: result.user!.uid,
        name: name,
        email: email,
        role: role,
      );
      await _db.child('users/${result.user!.uid}').set(newUser.toJson());
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> updateStars(int stars) async {
    if (_user != null) {
      await _db.child('users/${_user!.uid}/stars').set(stars);
      await _db.child('leaderboard/${_user!.uid}').set({
        'name': _user!.name,
        'stars': stars,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      });
      _user = UserModel(
        uid: _user!.uid,
        name: _user!.name,
        email: _user!.email,
        role: _user!.role,
        stars: stars,
      );
      notifyListeners();
    }
  }
}
