import 'package:intl/intl.dart';

class DateGreet {

  static String getDateGreet() {
    int time = DateTime.now().hour;

    if (time < 12)
      return 'Selamat pagi,';
    else if (time > 12 && time < 16)
      return 'Selamat siang,';
      else if (time > 16 && time < 18)
      return 'Selamat sore,';
    else if (time < 24 && time > 18)
      return 'Selamat malam,';
    else
      return 'Hallo!';
  }

  static String getDateOrder(String date) {
    var newStr = date.substring(0, 10) + ' ' + date.substring(11, 23);

    DateTime dt = DateTime.parse(newStr);
    return DateFormat("EEE, d MMM  yyyy HH:mm:ss").format(dt);
  }
}
