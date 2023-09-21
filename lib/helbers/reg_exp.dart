mixin ChickValidData {
  bool isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (emailRegExp.hasMatch(email)) return true;
    return false;
  }
}
