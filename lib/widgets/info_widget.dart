import 'package:flutter/material.dart';

import 'package:weather_app/widgets/components/info_row.dart';
import 'package:weather_app/widgets/components/vertical_container.dart';

import '../constants.dart';
import '../methods/weather_data_calculation.dart';

class InfoWidget extends StatelessWidget {
  InfoWidget(
      {super.key,
      required this.sunriseTime,
      required this.sunSet,
     // required this.wind,
     // required this.windSpeed,
      required this.realFeel,
      required this.pressure,
      required this.humidity,
      required this.visibility});

  var sunriseTime;
  var sunSet;
 // var wind;
 // var windSpeed;
  var realFeel;
  var pressure;
  var humidity;
  var visibility;

  @override
  Widget build(BuildContext context) {
    var formatedSunrise =
        WeatherDataCalculation.convertTimestampToTime(sunriseTime ?? 0.0);
    var formatedSunset = WeatherDataCalculation.convertTimestampToTime(sunSet ?? 0.0);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: VerticalContainer(
                          label: 'Sunrise',
                          // value: globalController.sunriseTime(),
                          value: formatedSunrise,
                          imagePath: ImageAssets.sunrise,
                        ),
                      ),
                      Expanded(
                        child: VerticalContainer(
                          label: 'Sunset',
                          //  value: globalController.sunsetTime(),
                          value: formatedSunset,
                          imagePath: ImageAssets.sunset,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InfoRow(
                      label: 'Feels Like',
                      value: "${(double.parse(realFeel!) - 273.15).round()} °C",
                    ),
                    InfoRow(
                      label: 'Pressure',
                      value: "$pressure hPa",
                    ),
                    InfoRow(
                      label: 'Humidity',
                      value: "$humidity %",
                    ),
                    InfoRow(
                      label: 'Visibility',
                      value: "${double.parse(visibility) / 1000} Km",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
