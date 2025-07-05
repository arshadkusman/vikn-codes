class Validators {
  static String? validateNotEmpty(String? v) =>
      (v == null || v.trim().isEmpty) ? 'This field is required' : null;

  static String? validateEmail(String? v) {
    if (v == null || v.isEmpty) return 'Email is required';
    final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(v) ? null : 'Invalid email format';
  }

  static String? validatePassword(String? v) =>
      (v != null && v.length >= 6) ? null : 'Minimum 6 characters';
}
