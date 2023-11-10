import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants.dart';

class FooterWidget extends StatelessWidget {
  FooterWidget({super.key, required this.lastUpdateTime});

  String lastUpdateTime = "";
  @override
  Widget build(BuildContext context) {
    String convertTimestampToTime(String timestamp) {
      int timestampInt = int.tryParse(timestamp) ?? 0;

      final DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(timestampInt * 1000);
      final String formattedTime = DateFormat('h:mm a').format(dateTime);
      return formattedTime;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          const Text(
            'OpenWeather',
            style: lightBodyTextStyle,
          ),
          const SizedBox(height: 3,),
          Text(
            'Last updated  ${convertTimestampToTime(lastUpdateTime)}',
            style: lightBodyTextStyle,
          ),
        ],
      ),
    );
  }
}
