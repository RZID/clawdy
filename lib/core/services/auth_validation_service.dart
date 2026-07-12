class LoginValidationResult {
  final bool isValid;
  final String? errorMessage;

  LoginValidationResult({required this.isValid, this.errorMessage});
}

LoginValidationResult validateLogin(String email, String password) {
  if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
    return LoginValidationResult(
      isValid: false,
      errorMessage: 'Please enter a valid email address.',
    );
  }

  if (password.length < 6) {
    return LoginValidationResult(
      isValid: false,
      errorMessage: 'Password must be at least 6 characters.',
    );
  }

  return LoginValidationResult(isValid: true);
}
