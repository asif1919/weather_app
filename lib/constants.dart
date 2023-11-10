import 'package:flutter/material.dart';
//--------------------image path
class ImageAssets {
  static const sunrise = 'assets/icons/sunrise.png';
  static const sunset = 'assets/icons/sunset.png';
  static const wind = 'assets/icons/wind.png';
  static const feelsLike = 'assets/icons/feelslike.png';
}


class AppColor {
  static const defaultAppColor = Colors.blue;
  static const lightTextColor = Colors.white70;
}

//--------------------text styles
const largeTextStyle = TextStyle(
  fontSize: 60,
);

const mediumTextStyle = TextStyle(
  fontSize: 36,
);

const headingTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

const titleTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: AppColor.lightTextColor,
);

const lightTitleTextStyle = TextStyle(
  fontSize: 14,
  color: AppColor.lightTextColor,
);

const bodyTextStyle = TextStyle(
  fontSize: 12,
);

const lightBodyTextStyle = TextStyle(
  fontSize: 14,
  color: AppColor.lightTextColor,
);
