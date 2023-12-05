import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../methods/network_Calls_methods.dart';
import '../methods/weather_data_calculation.dart';
import '../models/error_model.dart';
import '../models/weather_By_CityModel.dart';
import '../models/weather_Model.dart';

class WeatherByCityDataController extends GetxController {
  String? temperature = "0.0";
  String? sunriseTime = "0.0";
  String? sunSet = "0.0";
  String? wind = "0.0";
  String? windSpeed = "0.0";
  String? realFeel = "0.0";
  String? pressure = "0.0";
  String? humidity = "0.0";
  String? visibility = "0.0";
  bool hasError = false;
  String errorMsg = "";

  var dt = 0;

  var tempConverter = "0.0";

  var windDirection = "North";
  var windSpeedformated = "0.0";

  WeatherByCityModel _weatherByCityModel = WeatherByCityModel();
  GotError _gotError =  GotError();
  bool _weatherByCityDataInProgress = false;
  bool get weatherByCityDataInProgress => _weatherByCityDataInProgress;
  bool showCity = false;

  

  // var lat = 24.0122;
  // var long = 89.2468;

  getWeatherByCityInfo(var city ) async {
    _weatherByCityDataInProgress = true;
     hasError = false;
     showCity = true;
    update();
    final response2 = await NetworkCaller.getRequestByCity(
       city: city
    );
    _weatherByCityDataInProgress = false;
    if (response2.isSuccess) {

      _weatherByCityModel = WeatherByCityModel.fromJson(response2.returnData);
       //debugPrint(response2 as String?);
      //-----------------------getting Data

      if (_weatherByCityModel.main != null) {
        temperature = _weatherByCityModel.main!.temp?.toString();
        realFeel = _weatherByCityModel.main!.feelsLike != null
            ? _weatherByCityModel.main!.feelsLike!.round().toString()
            : "0";
        pressure = _weatherByCityModel.main!.pressure?.toString();
        humidity = _weatherByCityModel.main!.humidity?.toString();
        dt = _weatherByCityModel.dt!;
      }
      

      if (_weatherByCityModel.sys != null) {
        sunriseTime = _weatherByCityModel.sys!.sunrise?.toString();
        sunSet = _weatherByCityModel.sys!.sunset?.toString();
      }

      if (_weatherByCityModel.wind != null) {
        wind = _weatherByCityModel.wind!.deg?.toString();
        windSpeed = _weatherByCityModel.wind!.speed?.toString();
      }

      if (_weatherByCityModel.visibility != null) {
        visibility = _weatherByCityModel.visibility?.toString();
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
      hasError = true;
          _gotError = GotError.fromJson(response2.returnData);
      errorMsg = _gotError.message.toString();
      update();
    }
  }
}
