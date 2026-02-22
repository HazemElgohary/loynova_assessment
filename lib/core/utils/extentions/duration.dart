extension DurationEX on Duration {
  String getHoursAndMinutes({String locale = 'en'}) {
    final int hours = inHours;
    final int minutes = inMinutes.remainder(60);
    final isEn = locale == 'en';
    return '${hours.abs()}${isEn ? 'hrs' : 'س'} ${minutes.abs()}${isEn ? 'm' : 'د'}';
  }
}
