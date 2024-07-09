// create a class HelperFunctions with important helper functions for the app
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BHelperFunctions {
  BHelperFunctions._();

  //create a function to check colors that will match my product specific colors and return the color
  static Color? getColor(String color) {
    switch (color) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'pink':
        return Colors.pink;
      case 'indigo':
        return Colors.indigo;
      case 'brown':
        return Colors.brown;
      case 'purp le':
        return Colors.purple;
      default:
        return null;
    }
  }

  //show a snackbar
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // show alert
  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // navigate to a new screen
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  //truncate text
  static String truncateText(String text, int maxlength) {
    if (text.length <= maxlength) {
      return text;
    } else {
      return '${text.substring(0, maxlength)}...';
    }
  }

  // is dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  //screen size
  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  //screen height
  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  //screen width
  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  // get formatted date
  static String getFormattedDate(DateTime date,
      {String format = 'dd-MM-yyyy'}) {
    return DateFormat(format).format(date);
  }

// remove duplicates
  static List<B> removeDuplicates<B>(List<B> list) {
    return list.toSet().toList();
  }

  // wrap widgets
  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(
        children: rowChildren,
      ));
    }
    return wrappedList;
  }
}
