import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fpdart/fpdart.dart';

typedef GetUserType = Future<Either<String?, User?>>;

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

  GetUserType registerUser({emailAddress, password}) async {
    //error handling new style
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      _user = credential.user!;
      return right(_user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return left('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        return left('entered INvalid email');
      } else {
        return left(e.code);
      }
    } catch (e) {
      throw left(e.toString());
    }
  }

  GetUserType LoginUsingEmail({emailAddress, password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      _login = credential.user;
      return right(_login);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return left('Wrong password provided for that user.');
      } else if (e.code == 'wrong-password') {
        return left('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        return left('entered INvalid email');
      } else {
        return left(e.code);
      }
    } catch (e) {
      throw left(e.toString());
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
