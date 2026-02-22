import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  String toOurDay() {
    if (day == DateTime.now().day &&
        month == DateTime.now().month &&
        year == DateTime.now().year) {
      return 'today';
    } else if (day == DateTime.now().day - 1 &&
        month == DateTime.now().month &&
        year == DateTime.now().year) {
      return 'yesterday';
    } else if (day == DateTime.now().day + 1 &&
        month == DateTime.now().month &&
        year == DateTime.now().year) {
      return 'tomorrow';
    } else {
      return DateFormat.yMMMd().format(this);
    }
  }

  String formattedDate() {
    return DateFormat.yMMMd().format(this).toString();
  }

  String toTimeFormat({String locale = 'en'}) {
    return DateFormat('MMM dd, yyyy – hh:mm a', locale).format(this);
  }

  String getTime({String locale = 'en'}) {
    return DateFormat('HH:mm', locale).format(this);
  }

  String getDayName({String locale = 'en'}) {
    return DateFormat('EE', locale).format(this);
  }

  String getDayAndMonth({String locale = 'en'}) {
    return DateFormat('d MMMM', locale).format(this);
  }

  String getMonthOnly({String locale = 'en'}) {
    return DateFormat('MMMM', locale).format(this);
  }

  String getDayAndMonthAndYear({String locale = 'en'}) {
    return DateFormat('d MMM, yyyy', locale).format(this);
  }

  bool isSameDate(DateTime? other) {
    if (other == null) return false;
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime firstDayOfWeek() {
    final weekday = this.weekday;
    return subtract(Duration(days: weekday - 1));
  }

  List<DateTime> getWeekDays({DateTime? date}) {
    final firstDay = firstDayOfWeek();
    return List.generate(
      7,
      (index) =>
          (date?.add(Duration(days: index))) ??
          (firstDay.add(Duration(days: index))),
    );
  }

  List<DateTime> getDatesBetween(DateTime toDate) {
    final daysInBetween = toDate.difference(this).inDays;
    return List.generate(daysInBetween + 1, (index) {
      return add(Duration(days: index));
    });
  }
}
