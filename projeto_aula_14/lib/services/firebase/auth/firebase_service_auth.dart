import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_as/models/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserModel?> get user {
    return _auth.authStateChanges().map((user) {
      if (user != null) {
        return UserModel(email: user.email ?? '');
      }
      return null;
    });
  }

  Future<UserModel?> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user != null) {
        return UserModel(email: user.email ?? '');
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Erro no login: ${e.code} - ${e.message}");
    }
    return null;
  }

  Future<UserModel?> signUp(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user != null) {

        return UserModel(email: user.email ?? '');
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Erro no cadastro: ${e.code} - ${e.message}");
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  UserModel? getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      return UserModel(email: user.email ?? '');
    }
    return null;
  }
}
