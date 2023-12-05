import 'package:flutter/material.dart';

class ListTileByCity extends StatelessWidget {
  ListTileByCity(
      {required this.title,
      required this.subtitle,
      required this.trailing,
      super.key});

  String title;
  String trailing;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
         title,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      trailing: Text(trailing,
          style: const TextStyle(color: Colors.white, fontSize: 30)),
      subtitle: Text(
         subtitle,
           style: TextStyle(
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}


 // ListTile(
                                          //     title: Text(
                                          //       _searchController.text.trim(),
                                          //       style: const TextStyle(
                                          //           color: Colors.white,
                                          //           fontSize: 18),
                                          //     ),
                                          //     trailing: Text(
                                          //         weatherByCityController
                                          //             .tempConverter,
                                          //         style: const TextStyle(
                                          //             color: Colors.white,
                                          //             fontSize: 23)),
                                          //     subtitle: Text(
                                          //       "Sunrise   : ${WeatherDataCalculation.convertTimestampToTime(weatherByCityController.sunriseTime.toString())}  \nSunset    : ${WeatherDataCalculation.convertTimestampToTime(weatherByCityController.sunSet.toString())}\nPressure : ${weatherByCityController.pressure} hpa",
                                          //       style: TextStyle(
                                          //         color: Colors.white
                                          //             .withOpacity(0.5),
                                          //       ),
                                          //     ),
                                          //   ),