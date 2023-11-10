import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
import 'package:weather_app/screen/weather_Screen.dart';

import 'controller/location_Method_controller.dart';
import 'controller/weather_Data_Controller.dart';
 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
       initialBinding: GetXBindings(),
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:   WeatherScrewen(),
    );
  }
}

class GetXBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationMethodController());
    Get.put(WeatherDataController());
 
  }

}