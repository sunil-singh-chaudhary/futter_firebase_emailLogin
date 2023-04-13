import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_first_demo/register_feature/core/Auth.dart';
import 'package:firebase_first_demo/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'firebase_options.dart';

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FireBaseSetUp(),
    );
  }
}

class FireBaseSetUp extends StatefulWidget {
  const FireBaseSetUp({super.key});

  @override
  State<FireBaseSetUp> createState() => _FireBaseSetUpState();
}

class _FireBaseSetUpState extends State<FireBaseSetUp> {
  @override
  void initState() {
    Firebase.initializeApp(
      //initialized firebase
      options: DefaultFirebaseOptions.currentPlatform,
    );
    super.initState();
  }

  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _pswd_controller = TextEditingController();
  final Auth _auth = Auth();
  final _storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
              child: TextFormField(
                controller: _email_controller,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
              child: TextFormField(
                controller: _pswd_controller,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                dynamic users = await _auth.registerUser(
                    emailAddress: _email_controller.text,
                    password: _pswd_controller.text);
                if (users == null) {
                  print('error sign in');
                } else {
                  _storage.write(key: 'is_register', value: users.email);
                  print(
                      ' sign in success -- > ${_auth.users}'); //adding getter to access
                  MaterialPageRoute(
                    builder: (context) {
                      return const GoogleLoginButton();
                    },
                  );
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
