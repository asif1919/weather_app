import 'package:flutter/material.dart';
 
import 'package:weather_app/constants.dart';

class CurrentTempWidget extends StatelessWidget {
  const CurrentTempWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .6,
      child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              
             // 'assets/weather/${globalController.weatherIconCode()}.png',
              'assets/weather/03n.png',
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // globalController.currentTemperature(),
                  "22.2",
                  style: largeTextStyle,
                ),
                Text(
                  '°C',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            Text(
             // globalController.weatherDescription(),
             "haze",
              style: titleTextStyle,
            ),
          ],
        ),
      );
     
  }
}
