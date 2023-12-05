import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/weather_by_city_controller.dart';
import 'package:weather_app/widgets/info_widget.dart';
import 'package:weather_app/widgets/listTile_ByCity_widget.dart';
import '../constants.dart';
import '../controller/location_Method_controller.dart';
import '../controller/weather_Data_Controller.dart';
import '../methods/weather_data_calculation.dart';
import '../widgets/SearchButton_widget.dart';
import '../widgets/components/horizontal_container.dart';
import '../widgets/footer_widget.dart';
import '../widgets/search_city_widget.dart';

class WeatherScrewen extends StatefulWidget {
  const WeatherScrewen({Key? key}) : super(key: key);

  @override
  State<WeatherScrewen> createState() => _WeatherScrewenState();
}

class _WeatherScrewenState extends State<WeatherScrewen> {
  String currentDate = DateFormat("d MMMM").format(DateTime.now());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherDataController>(builder: (weatherDataController) {
      return Scaffold(
        backgroundColor: Colors.blue.withOpacity(0.2),
        appBar: AppBar(
            backgroundColor: const Color(0xff061827),
            elevation: 0,
            toolbarHeight: 100,
            title: SearchCardWidget(
              controller: _searchController,
              function: () {},
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SearchButtonWidget(
                    function: () {
                      Get.find<WeatherByCityDataController>()
                          .getWeatherByCityInfo(
                              _searchController.text.trim().toString());
                      // print(_searchController.text);
                    },
                  )),
            ],
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
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder<WeatherByCityDataController>(
                          builder: (weatherByCityController) {
                        return weatherByCityController.showCity
                            ? weatherByCityController
                                    .weatherByCityDataInProgress
                                ? Center(
                                    child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: CircularProgressIndicator(
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                  ))
                                : SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Card(
                                          color: Colors.white.withOpacity(0.1),
                                          child: weatherByCityController
                                                  .hasError
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  child: Text(
                                                    weatherByCityController
                                                        .errorMsg,
                                                    style: const TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 18),
                                                  ),
                                                )
                                              : ListTileByCity(
                                                  title: _searchController.text
                                                      .trim(),
                                                  subtitle:
                                                      "Sunrise   : ${WeatherDataCalculation.convertTimestampToTime(weatherByCityController.sunriseTime.toString())}  \nSunset    : ${WeatherDataCalculation.convertTimestampToTime(weatherByCityController.sunSet.toString())}\nPressure : ${weatherByCityController.pressure} hpa",
                                                  trailing:
                                                      weatherByCityController
                                                          .tempConverter)),
                                    ),
                                  )
                            : SizedBox();
                      }),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: Text(
                                    //   Get.find<LocationMethodController>().currentAddress .toString(),
                                    Get.find<LocationMethodController>()
                                            .currentAddress ??
                                        'N/A',
                                    style: const TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  currentDate,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(155, 255, 255, 255)),
                                ),
                              ],
                            ),
                            const Spacer(),
                            GetBuilder<LocationMethodController>(
                                builder: (locationMethodController) {
                              return IconButton(
                                  onPressed: () async {
                                    locationMethodController
                                        .getCurrentPosition();

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
                      const SizedBox(
                        height: 15,
                      ),
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
                          visibility:
                              weatherDataController.visibility.toString(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                                  label: weatherDataController.windDirection,
                                  value:
                                      weatherDataController.windSpeedformated,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                            width: double.infinity,
                            child: FooterWidget(
                                lastUpdateTime: "${weatherDataController.dt}")),
                      ),
                    ],
                  ),
                );
        }),
      );
    });
  }
}
