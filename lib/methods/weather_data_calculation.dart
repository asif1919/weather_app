import 'package:intl/intl.dart';

class WeatherDataCalculation {


 static String convertTimestampToTime(String timestamp) {
      int timestampInt = int.tryParse(timestamp) ?? 0;

      final DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(timestampInt * 1000);
      final String formattedTime = DateFormat('h:mm a').format(dateTime);
      return formattedTime;
    }

   static String getWindDirection(String degrees) {
      int degreesInt = int.tryParse(degrees) ?? 0;

      if (degreesInt >= 338 || degreesInt < 23) {
        return 'North';
      } else if (degreesInt >= 23 && degreesInt < 68) {
        return 'Northeast';
      } else if (degreesInt >= 68 && degreesInt < 113) {
        return 'East';
      } else if (degreesInt >= 113 && degreesInt < 158) {
        return 'Southeast';
      } else if (degreesInt >= 158 && degreesInt < 203) {
        return 'South';
      } else if (degreesInt >= 203 && degreesInt < 248) {
        return 'Southwest';
      } else if (degreesInt >= 248 && degreesInt < 293) {
        return 'West';
      } else {
        return 'Northwest';
      }
    }

  static  String convertSpeed(String speedMetersPerSecond) {
      double speedKilometersPerHour = double.parse(speedMetersPerSecond) * 3.6;
      return '${speedKilometersPerHour.toStringAsFixed(0)} km/h';
    }
}