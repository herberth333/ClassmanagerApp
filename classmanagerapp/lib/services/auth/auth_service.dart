import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> fazerLogin(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: senha,
      );
      return true; 
    } catch (e) {
      debugPrint("Erro no login: $e");
      return false; 
    }
  }

  Future<void> fazerLogout() async {
    await _auth.signOut();
  }
}
