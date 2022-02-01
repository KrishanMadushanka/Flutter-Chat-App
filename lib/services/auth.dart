import 'package:chat_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebseUser(FirebaseUser firebaseUser) {
    return firebaseUser != null ? User(firebaseUser.uid) : null;
  }

  static showTopSnack(String message,BuildContext context){
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: message,icon: null,
      ),
    );
  }

  Future signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      showTopSnack(e.toString(), context);
    }
  }

  Future signUpWithEmailAndPassword(String email, String password,BuildContext context) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      showTopSnack(e.toString(), context);
    }
  }

  Future resetPass(String email,BuildContext context) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      showTopSnack(e.toString(), context);
    }
  }

  Future signOut(BuildContext context) async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      showTopSnack(e.toString(), context);
    }
  }
}
