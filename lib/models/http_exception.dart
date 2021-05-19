class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
  }

  String get userMessage {
    print(message);
    if (message.contains('EMAIL_EXISTS')) {
      return 'The email address is already in use by another account.';
    } else if (message.contains('EMAIL_NOT_FOUND')) {
      return 'There is no user record corresponding to this identifier.';
    } else if (message.contains('INVALID_EMAIL')) {
      return 'The email address is badly formatted.';
    } else if (message.contains('INVALID_PASSWORD')) {
      return 'The password is invalid';
    } else if (message.contains('WEAK_PASSWORD')) {
      return 'The password must be 6 characters long or more.';
    } else if (message.contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
      return 'We have blocked all requests from this device due to unusual activity. Try again later.';
    } else {
      return 'Something went wrong, please try to connect later.';
    }
  }
}
