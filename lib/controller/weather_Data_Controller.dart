import 'package:get/get.dart';

import '../methods/network_Calls_methods.dart';
import '../methods/weather_data_calculation.dart';
import '../models/weather_Model.dart';

class WeatherDataController extends GetxController {
  String? temperature = "0.0";
  String? sunriseTime = "0.0";
  String? sunSet = "0.0";
  String? wind = "0.0";
  String? windSpeed = "0.0";
  String? realFeel = "0.0";
  String? pressure = "0.0";
  String? humidity = "0.0";
  String? visibility = "0.0";
  String? icon = "01d";
  var dt = 0;

  var tempConverter = "0.0";

  var windDirection = "North";
  var windSpeedformated = "0.0";

  WeatherModel _weatherModel = WeatherModel();
  bool _weatherDataInProgress = false;
  bool get weatherDataInProgress => _weatherDataInProgress;

  // var lat = 24.0122;
  // var long = 89.2468;

  getWeatherInfo(var lat, var long) async {
    _weatherDataInProgress = true;
    update();
    final response = await NetworkCaller.getRequest(
      lat: lat.toString(),
      long: long.toString(),
    );
    _weatherDataInProgress = false;
    if (response.isSuccess) {
      _weatherModel = WeatherModel.fromJson(response.returnData);

      //-----------------------getting Data

      if (_weatherModel.main != null) {
        temperature = _weatherModel.main!.temp?.toString();
        realFeel = _weatherModel.main!.feelsLike != null
            ? _weatherModel.main!.feelsLike!.round().toString()
            : "0";
        pressure = _weatherModel.main!.pressure?.toString();
        humidity = _weatherModel.main!.humidity?.toString();
        dt = _weatherModel.dt!;
      }
      if (_weatherModel.weather != null && _weatherModel.weather!.isNotEmpty) {
        icon = _weatherModel.weather![0].icon ?? "01d";
      }

      if (_weatherModel.sys != null) {
        sunriseTime = _weatherModel.sys!.sunrise?.toString();
        sunSet = _weatherModel.sys!.sunset?.toString();
      }

      if (_weatherModel.wind != null) {
        wind = _weatherModel.wind!.deg?.toString();
        windSpeed = _weatherModel.wind!.speed?.toString();
      }

      if (_weatherModel.visibility != null) {
        visibility = _weatherModel.visibility?.toString();
      }

      if (temperature != null) {
        double temperatureInKelvin = double.parse(temperature!);
        tempConverter = "${(temperatureInKelvin - 273.15).round()}°C";
      } else {
        tempConverter = "0.0";
      }

      update();
      windDirection = WeatherDataCalculation.getWindDirection(wind.toString());
      windSpeedformated =
          WeatherDataCalculation.convertSpeed(windSpeed.toString());
      update();

      // print(temperature);
      // print(sunriseTime);
      // print(sunSet);
      // print(wind);
      // print(windSpeed);
      // print(realFeel);
      // print(pressure);
      // print(humidity);
      // print(visibility);
      // print(tempConverter);
    } else {
      update();
    }
  }
}
