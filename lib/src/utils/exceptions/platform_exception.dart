// Exception class for handling various platform-related errors.
class BPlatformException implements Exception {
  final String code;

  BPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';
      case 'invalid-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-phone-number':
        return 'The provided phone number is invalid.';
      case 'operation-not-allowed':
        return 'The sign-in provider is disabled for your Firebase project.';
      case 'session-cookie-expired':
        return 'The Firebase session cookie has expired. Please sign in again.';
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user.';
      case 'sign_in_failed':
        return 'Sign-in failed. Please try again.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'internal-error':
        return 'An internal error occurred. Please try again later.';
      case 'web-storage-unsupported':
        return 'Web storage is not supported. Please try again.';
      case 'popup-blocked':
        return 'Popup blocked. Please enable popups and try again.';
      case 'popup-closed-by-user':
        return 'Popup closed by user. Please try again.';
      case 'unauthorized-domain':
        return 'Unauthorized domain. Please contact support for assistance.';
      case 'invalid-user-token':
        return 'Invalid user token. Please try again.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';
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
        return 'The action code is invalid. Please enter a valid code.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.';
        default:
        return 'An error occurred. Please try again.';
    }
  }
}