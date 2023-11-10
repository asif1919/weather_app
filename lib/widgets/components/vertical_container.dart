import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
  

class VerticalContainer extends StatelessWidget {
  final String label, value;
  final String imagePath;

  const VerticalContainer(
      {super.key,
      required this.label,
      required this.value,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          SizedBox(height: 10,),
          Text(
            label,
            style: lightTitleTextStyle,
          ),
          Text(
            value,
            style: titleTextStyle,
          ),
        ],
      ),
    );
  }
}
