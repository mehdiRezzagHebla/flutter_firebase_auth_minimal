import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // email register method
  Future<User> register(String email, String pw, BuildContext context) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: pw);
      return user.user;
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text('Error Occured'),
                actions: [
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    }
  }

  // sign in
  Future<User> logIn(String email, String pw, BuildContext context) async {
    try {
      UserCredential user =
          await _auth.signInWithEmailAndPassword(email: email, password: pw);
      return user.user;
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text('Error Occured'),
                actions: [
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    }
  }

  // this method transforms User object into a CustomUser Object
  CustomUser _userToCustomUser(User user) {
    if (user == null) {
      return null;
    }
    return CustomUser(uid: user.uid);
  }

  // stream user or null
  Stream<CustomUser> onAuthchanged() {
    return _auth.authStateChanges().map(_userToCustomUser);
  }

  // signOut
  Future<void> logOut() async {
    await _auth.signOut();
  }
}

class CustomUser {
  final String uid;
  CustomUser({this.uid});
}
