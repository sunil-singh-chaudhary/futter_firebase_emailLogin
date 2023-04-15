import 'package:fpdart/fpdart.dart';

class ValidatePhoneNumber {
  static Either<bool?, String?> onPhoneNumberChanged(String phoneno) {
    bool isValid =
        validatePhoneNumber(phoneno); // Call the validatePhoneNumber function
    if (isValid) {
      // Do something if the phone number is valid
      return Right(phoneno);
    } else {
      return left(false);
    }
  }
}

bool validatePhoneNumber(String phoneNumber) {
  // Remove any non-digit characters from the input
  phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

  // Check if the phone number has exactly 10 digits
  if (phoneNumber.length == 10) {
    return true; // Valid phone number
  } else {
    return false; // Invalid phone number
  }
}
