class MyValidator {
  static String emailValidator(final String value) {
    String message = '';
    if (value.trim().isEmpty) message = 'Please enter email';
    RegExp emailPattern = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.trim().isNotEmpty && !emailPattern.hasMatch(value)) {
      message = 'please enter valid Email';
    }
    if (emailPattern.hasMatch(value)) {
      message = 'Email is valid';
    }
    return message;
  }

  static String passwordValidator(final String value) {
    String message = '';
    if (value.trim().isEmpty) message = 'Please enter password';
    if (value.trim().isNotEmpty && value.length < 8) {
      message = 'Password must be more than 7 characters';
    }
    if (value.trim().isNotEmpty && value.length > 7) {
      message = 'Password is valid';
    }
    return message;
  }
}