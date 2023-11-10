import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weather_app/controller/weather_Data_Controller.dart';

import '../widgets/snackbar_message.dart';

class LocationMethodController extends GetxController {
  String? _currentAddress;
  Position? _currentPosition;
  bool _locationInProgress = false;
  bool nothing = false;

  bool get locationInProgress => _locationInProgress;
  String? get currentAddress => _currentAddress;
  Position? get currentPosition => _currentPosition;





  // --------------------------------------------- Location Permission Handeling

  Future<bool> _handleLocationPermission() async {
    final context = Get.context;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

   // --------------------------------------------- Location Permission Handeling Ends





  Future<void> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool serviceRequested = await Geolocator.openLocationSettings();
      if (serviceRequested) {
        _getCurrentPositionMethods();
         showSnackBarMessage(Get.context!,'Permission Granted');
        debugPrint('Location service already enabled');
        update();
      } else {
        // Handle the case where the user does not enable the location service
         showSnackBarMessage(Get.context!,'Permission not given');
        debugPrint('Location service not enabled');
      }
    } else {
      _getCurrentPositionMethods();
       showSnackBarMessage(Get.context!,'Permission Granted');
      debugPrint('Location service already enabled');
      update();
    }
  }




  Future<void> _getCurrentPositionMethods() async {
    _locationInProgress = true;
    update();
    final hasPermission = await _handleLocationPermission();
    _locationInProgress = false;
    if (!hasPermission) {
      update();
      return;
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;

      //---------------------------------------- Location Adress and getting Weather Data

      _getAddressFromLatLng(_currentPosition!)
          .then((value) => Get.find<WeatherDataController>().getWeatherInfo(
              currentPosition!.latitude.toDouble(),
              currentPosition!.longitude.toDouble()))
          .then((value) =>
              Get.find<WeatherDataController>().weatherDataInProgress
                  ? nothing
                  : update());

      //---------------------------------------- Location Adress and getting Weather Data Ends         
    }).catchError((e) {
      update();
      debugPrint(e);
    });
  }





  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      _currentAddress = '${place.subAdministrativeArea}';
      //_currentAddress =
      //  '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      update();
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
