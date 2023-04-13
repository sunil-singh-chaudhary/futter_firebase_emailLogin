import 'package:firebase_first_demo/LoginPage.dart';
import 'package:firebase_first_demo/StartApp.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CheckLoginStatus extends StatelessWidget {
  const CheckLoginStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final _storage = FlutterSecureStorage();
    dynamic loginmail = _storage.read(key: 'is_register');
    if (loginmail != null) {
      return const GoogleLoginButton();
    } else {
      return const StartApp();
    }
  }
}
