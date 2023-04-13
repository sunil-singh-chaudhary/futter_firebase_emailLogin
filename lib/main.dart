import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_first_demo/register_feature/Screen/RegisterScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'CheckLoginOrNot.dart';

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
      runApp(MaterialApp(home: MyApp()));
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context),
      child: ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Sizer(
            builder: (context, orientation, deviceType) => RegisterScreen()),
      ),
    );
  }
}
