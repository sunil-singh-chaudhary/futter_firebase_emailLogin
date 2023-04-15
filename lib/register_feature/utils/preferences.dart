// Create an instance of FlutterSecureStorage
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

void setRegistrationCompleteUsingSecured(String key,
    [String value = 'false']) async {
// Store the isRegistered value
  await _secureStorage.write(key: key, value: value);
}

// Function to check if registration is complete
Future<bool> isRegistrationCompleteUsingSecured(String key) async {
// Retrieve the isRegistered value
  String? isRegisteredString = await _secureStorage.read(key: key);
  bool isRegistered = isRegisteredString == 'true';

  return isRegistered;
}
