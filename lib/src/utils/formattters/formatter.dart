import 'package:intl/intl.dart';

//create a class Formatters with important formatters for the app
class Formatters {
  Formatters._();

  //create a formatter for currency
  static String currencyFormatter(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  // date formatter
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date);
  }

// format phoneNumber
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else {
      return phoneNumber;
    }
  }

  //create a formatter for time
  static final timeFormatter = DateFormat('hh:mm a');

  // international phone number formatter, for different countries like Somalia, Kenya, Eithopia, DJibouti, etc
  static String internationalPhoneNumberFormatter(String phoneNumber) {
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // extract the country code from the digitsOnly
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    //add the remaining digits with the proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('${countryCode} ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+252') {
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }
    return formattedNumber.toString();
  }
}
