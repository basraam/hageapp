// Custom exception class to handle various format-related errors.
class BFormatException implements Exception {
  /// The associated error message.
  final String message;
  /// Default constructor with a generic error message.
  const BFormatException ([this.message = 'An unexpected format error occurred. Please check your input.']);
  /// Create a format exception from a specific error message.
  factory BFormatException.fromMessage(String message) {
    return BFormatException(message);
  }
  /// Get the corresponding error message.
  String get formattedMessage => message;
  /// Create a format exception from a specific error code.
  factory BFormatException.fromCode (String code) {
    switch (code) {
      case 'invalid-email-format':
        return const BFormatException(
            'The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const BFormatException(
            'The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return const BFormatException(
            'The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const BFormatException(
            'The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const BFormatException(
            'The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-ipv4-format':
        return const BFormatException('The IPv4 address format is invalid. Please enter a valid IPv4 address.');
      case 'invalid-ipv6-format':
        return const BFormatException('The IPv6 address format is invalid. Please enter a valid IPv6 address.');
      case 'invalid-mac-address-format':
        return const BFormatException('The MAC address format is invalid. Please enter a valid MAC address.');
      case 'invalid-uuid-format':
        return const BFormatException('The UUID format is invalid. Please enter a valid UUID.');
      case 'invalid-iban-format':
        return const BFormatException('The IBAN format is invalid. Please enter a valid IBAN.');
      case 'invalid-bic-format':
        return const BFormatException('The BIC format is invalid. Please enter a valid BIC.');
        default:
        return const BFormatException();
    }
  }
}