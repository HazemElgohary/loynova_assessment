import 'dart:developer';

import 'package:flutter/material.dart';

extension StringExtensions on String {
  DateTime toDate() {
    return DateTime.parse(this);
  }

  String get urlName => split('/').last;

  String toMoneyFormat() {
    String formattedString = "";
    int counter = 0;
    for (int i = length - 1; i >= 0; i--) {
      formattedString = this[i] + formattedString;
      counter++;
      if (counter % 3 == 0 && i != 0) {
        formattedString = ",$formattedString";
      }
    }
    return formattedString;
  }

  String getFirstChar() {
    if (isEmpty) return '';
    final words = split(' ');

    if (words.isEmpty) {
      return '';
    } else {
      if (words.length < 2) {
        return words.firstOrNull?[0] ?? '';
      } else {
        return words.first[0] + (words.last.isNotEmpty ? words.last[0] : '');
      }
    }
  }

  bool isValidSwift() {
    final RegExp swiftCodeRegex = RegExp(
      r'^[A-Z]{4}[A-Z]{2}[0-9A-Z]{2}[0-9A-Z]{3}?',
    );

    return swiftCodeRegex.hasMatch(this);
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  /// ex: Text ('US'. toFlag),
  String get toFlag {
    return (this).toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
    );
  }

  String toTitleCase() {
    try {
      return isEmpty
          ? this
          : replaceAll(RegExp(' +'), ' ')
                .replaceAll('_', ' ')
                .split(' ')
                .map((str) => str.capitalize())
                .join(' ');
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      return this;
    }
  }

  String formatContactNumber() {
    if (isEmpty || length < 9) {
      return "";
    }
    replaceAll(" ", "");
    int shiftNumberBy = 0;
    if (this[0] == '+') {
      shiftNumberBy = 1;
    }

    return (length > 9)
        ? "${substring(0, 3 + shiftNumberBy)} ${substring(3 + shiftNumberBy, 6 + shiftNumberBy)} ${substring(6 + shiftNumberBy, 9 + shiftNumberBy)} ${substring(9 + shiftNumberBy)}"
        : "${substring(0, 3 + shiftNumberBy)} ${substring(3 + shiftNumberBy, 6 + shiftNumberBy)} ${substring(6 + shiftNumberBy)}";
  }

  TextDirection detectTextDirection() {
    final rtlRegex = RegExp(
      r'^[\s\u200F\u200E]*[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]',
    );
    return rtlRegex.hasMatch(this) ? TextDirection.rtl : TextDirection.ltr;
  }

  String maybeHandleOverflow({int? maxChars, String replacement = ''}) =>
      maxChars != null && length > maxChars
      ? replaceRange(maxChars, null, replacement)
      : this;
}
