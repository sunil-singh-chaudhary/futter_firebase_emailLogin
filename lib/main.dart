import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_first_demo/register_feature/core/login_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'package:firebase_first_demo/login_feature/login_screen.dart';
import 'package:firebase_first_demo/register_feature/Screen/RegisterScreen.dart';

import 'mainScreen/HomeScreen.dart';
import 'register_feature/core/Auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF201a31), // navigation bar color
    statusBarColor: Color(0xFF201a31),
  )); // status bar color

  FlutterError.onError = (details) {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      var error = details.exception;
      var stacktrace = details.stack ?? StackTrace.empty;
      Zone.current.handleUncaughtError(error, stacktrace);
    }
  };
  runZonedGuarded(
    () async {
      runApp(MaterialApp(
          home: MyApp(
        auth: Auth(),
        loginAuth: LoginAuth(),
      )));
    },
    (error, stack) {
      debugPrint('caught Dart error');
      if (kDebugMode) {
        print(error);
        print(stack);
      } else {
        //In production mode to report
      }
    },
    zoneSpecification: const ZoneSpecification(),
    zoneValues: {},
  );
}

class MyApp extends StatelessWidget {
  Auth auth;
  LoginAuth loginAuth;

  MyApp({super.key, required this.auth, required this.loginAuth});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: auth),
        RepositoryProvider.value(value: loginAuth),
      ],
      child: ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: MediaQuery(
          data: MediaQuery.of(context),
          child: Sizer(builder: (context, orientation, deviceType) {
            return MaterialApp(
              home: FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    SharedPreferences _prefs = snapshot.data!;
                    print(_prefs.getBool('isLogin'));
                    bool? isLogin = _prefs.getBool('isLogin') ?? false;
                    return isLogin ? const HomeScreen() : const LoginScreen();
                  }

                  // `_prefs` is not ready yet, show loading bar till then.
                  return const CircularProgressIndicator();
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
