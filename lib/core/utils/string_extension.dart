extension StringExt on String {

  /// Extension function to test
  /// if a String is a valid e-mail
  /// or not
  ///
  /// Example:
  /// angga@gmail.com, will return True
  /// angga....mail...com, will return False
  bool get isValidEmail {
    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?"
    r"^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
    return emailValid;
  }

}