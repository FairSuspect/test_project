class DateCoder {
  static String encode(DateTime date) {
    String month = date.month < 10 ? "0${date.month}" : "${date.month}";
    String day = date.month < 10 ? "0${date.day}" : "${date.day}";

    return "${date.year}$month$day";
  }

  static DateTime decode(String formattedString) =>
      DateTime.parse(formattedString);
}

/// Форматы дат
class DateFormater {
  static String ddmmyyyy(DateTime date) {
    String month = date.month < 10 ? "0${date.month}" : "${date.month}";
    String day = date.day < 10 ? "0${date.day}" : "${date.day}";
    return "$day.$month.${date.year}";
  }
}
