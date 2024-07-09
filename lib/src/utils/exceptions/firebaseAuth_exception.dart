/// Custom exception class to handle various Firebase authentication-related errors.
class BFirebaseAuthException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  BFirebaseAuthException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid login details. User not found.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please contact support for assistance.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection and try again.';
      case 'app-not-authorized':
        return 'App not authorized. Please contact support for assistance.';
      case 'web-storage-unsupported':
        return 'Web storage unsupported. Please try again.';
      case 'popup-blocked':
        return 'Popup blocked. Please enable popups and try again.';
      case 'popup-closed-by-user':
        return 'Popup closed by user. Please try again.';
      case 'unauthorized-domain':
        return 'Unauthorized domain. Please contact support for assistance.';
      case 'invalid-user-token':
        return 'Invalid user token. Please try again.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.*';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed in user.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new action code.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check the code and try again.';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid action code.';
      case 'user-token-expired':
        return 'The user\'s token has expired, and authentication is required. Please sign in again.';
      case 'invalid-credential':
        return 'The supplied credential is malformed or has expired.';
      case 'user-token-revoked':
        return 'The user\'s token has been revoked. Please sign in again.';
      case 'invalid-continue-uri':
        return 'The continue URL provided in the request is invalid.';
      case 'missing-android-pkg-name':
        return 'An Android package name must be provided to link with an Android app.';
      case 'missing-continue-uri':
        return 'A continue URL must be provided in the request.';
      case 'missing-ios-bundle-id':
        return 'An iOS bundle ID must be provided to link with an iOS app.';
      case 'missing-verification-code':
        return 'The phone auth credential was created with an empty verification code.';
      case 'missing-verification-id':
        return 'The phone auth credential was created with an empty verification ID.';
        default:
        return 'An unexpected Firebase error occurred. Please try again.';
      }
  }
}