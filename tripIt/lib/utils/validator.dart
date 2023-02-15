import 'package:validators/validators.dart';

class FieldValidator {
  static String validatePasswordAlphaNumeric(String value) {
    print("validate password : $value ");

    if (value.isEmpty) return "Please enter password";
    if (value.length <= 6) {
      return "password length should be greater than 6";
    }
    String pattern = r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim())) {
      return "password must be alphanumeric";
    }
    return null;
  }

  static String validatePassword(String value) {
    print("validatepassword : $value ");

    if (value.isEmpty) return "Password is Required";

    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';

    ///use below line if you want a special character too
    // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim())) {
      return "one capital letter,one small letter and number";
    }
    if (value.length <= 6) {
      return "password length should be greater than 6";
    }
    return null;
  }

  static String validateEmail(String value) {
    if (value.isEmpty) {
      return "Email is Required";
    }
    if (!isEmail(value)) {
      return "Please enter a valid email address";
    }

    return null;
  }

  static String validateUsername(String value) {
    if (value.isEmpty) {
      return 'Username is Required';
    }
    return null;
  }

  static String validatePhoneNumber(String value) {
    print("validatepassword : $value ");

    if (value.isEmpty) return "Phone number is Required";

    if (value[0] != "0") {
      return "Number should start with 05";
    }
    if (value.length > 1) {
      if (value[1] != "5") {
        return "Number should start with 05";
      }
    }
    if (value.length != 10) {
      return "Number length should be 10 ";
    }
    String pattern = r'(^(?:[+0]9)?[0-9]{10,10}$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim())) {
      return "Invalid Number";
    }
    return null;
  }
}
