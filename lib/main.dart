import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'StartApp.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    () {
      runApp(const StartApp());
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartApp(),
    );
  }
}
