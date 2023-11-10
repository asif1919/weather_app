import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widgets/info_widget.dart';
import '../constants.dart';
import '../controller/location_Method_controller.dart';
import '../controller/weather_Data_Controller.dart';
import '../methods/weather_data_calculation.dart';
import '../widgets/components/horizontal_container.dart';
import '../widgets/footer_widget.dart';

class WeatherScrewen extends StatefulWidget {
  const WeatherScrewen({Key? key}) : super(key: key);

  @override
  State<WeatherScrewen> createState() => _WeatherScrewenState();
}

class _WeatherScrewenState extends State<WeatherScrewen> {
  String currentDate = DateFormat("d MMMM").format(DateTime.now());
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherDataController>(builder: (weatherDataController) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          toolbarHeight: 100,
          title: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      //   Get.find<LocationMethodController>().currentAddress .toString(),
                      Get.find<LocationMethodController>().currentAddress ??
                          'N/A',
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  Text(
                    currentDate,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(155, 255, 255, 255)),
                  ),
                ],
              ),
              const Spacer(),
              GetBuilder<LocationMethodController>(
                  builder: (locationMethodController) {
                return IconButton(
                    onPressed: () async {
                      locationMethodController.getCurrentPosition();

                   
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ));
              }),
            ],
          ),
        ),
        body: GetBuilder<LocationMethodController>(
            builder: (locationMethodController) {
          return locationMethodController.locationInProgress
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      CircularProgressIndicator(color: Colors.white),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              "Please check your internet connection or try again",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: InfoWidget(
                        sunriseTime:
                            weatherDataController.sunriseTime.toString(),
                        sunSet: weatherDataController.sunSet.toString(),
                      //  wind: weatherDataController.wind.toString(),
                       // windSpeed: weatherDataController.windSpeed.toString(),
                        realFeel: weatherDataController.realFeel.toString(),
                        pressure: weatherDataController.pressure.toString(),
                        humidity: weatherDataController.humidity.toString(),
                        visibility: weatherDataController.visibility.toString(),
                      ),
                    ),
                    const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                       
                        Column(
                          children: [
                            Text(
                              weatherDataController.temperature != null &&
                                      weatherDataController.temperature != ''
                                  ? weatherDataController.tempConverter
                                  : '0.0',
                              style: const TextStyle(
                                  fontSize: 55, color: Colors.white),
                            ),
                            SizedBox(
                              width: 150,
                              child: HorizontalContainer(
                                // 0 degrees (North): Wind is coming from the north.
                                // 90 degrees (East): Wind is coming from the east.
                                // 180 degrees (South): Wind is coming from the south.
                                // 270 degrees (West): Wind is coming from the west.
                                label:weatherDataController. windDirection,
                                value:weatherDataController. windSpeedformated,
                                imagePath: ImageAssets.wind,
                              ),
                            ),
                          ],
                        ),
                         Image.asset(
                            "assets/weather/${weatherDataController.icon}.png"),
                        const SizedBox(),
                      ],
                    ),
                    const SizedBox(),
                    const SizedBox(),
                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                          width: double.infinity,
                          child: FooterWidget(
                              lastUpdateTime: "${weatherDataController.dt}")),
                    ),
                  ],
                );
        }),
      );
    });
  }
}
