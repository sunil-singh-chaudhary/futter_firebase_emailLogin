import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first_demo/register_feature/core/AuthException.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  late final _user;
  late final _login;
  User? get users => _user;
  User? get login => _login;
  final _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final _auth = FirebaseAuth.instance;
  late final UserCredential user;
  Future<User?> registerUser({emailAddress, password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      _user = credential.user!;
      return _user;
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      throw AuthException(e);
    }
  }

  void LoginUsingEmail({emailAddress, password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      _login = credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  Future<User?> googleButtonSignIn() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      user = await _auth.signInWithCredential(credential);
      return user.user;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    return user.user;
  }
}
