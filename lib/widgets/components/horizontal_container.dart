import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
 

class HorizontalContainer extends StatelessWidget {
  final String label, value;
  final String imagePath;

  const HorizontalContainer(
      {super.key,
      required this.label,
      required this.value,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            imagePath,
            width: 40,
            height: 40,
          ),
          Column(
            children: [
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
        ],
      ),
    );
  }
}
