import 'package:flutter/material.dart';

extension TimeOfDayEX on TimeOfDay {
  String getTime() {
    final String formattedTime =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  Duration difference({TimeOfDay? fromTime}) {
    final day = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      hour,
      minute,
    );
    final second = fromTime == null
        ? null
        : DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            fromTime.hour,
            fromTime.minute,
          );

    return second != null
        ? second.difference(day)
        : DateTime.now().difference(day);
  }
}
