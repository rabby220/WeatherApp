import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'appColor.dart';

class AppText {
  // Title displayed when there is no internet connection.
  static const String noInternetTitleText = "No Internet";

  // Subtitle message displayed when the user is not connected to the internet.
  static const String noInternetSubtitleText = "Please connect to the internet";

  // Title displayed when the device successfully connects to the internet.
  static const String internetTitleText = "Connected";

  // Subtitle message displayed when the user is connected to the internet.
  static const String internetSubtitleText =
      "You are connected to the internet";

  /// Degree Symbol of Celsius and Fahrenheit text
  /*static const String celsiusDegreeSymbolText = "\u2103";*/
  static const String celsiusDegreeSymbolText = "°C";
  static const String kiloMeterPerHourText = "km/h";
  static const String percentageText = "%";
  static const String fahrenheitDegreeSymbolText = "\u2109";

  ///Build a text style
  static TextStyle nameWithCountryTextStyle = GoogleFonts.sairaCondensed(
    fontSize: 25.0,
    color: AppColor.whiteColor,
  );

  static TextStyle nameWithCountryTextStyle1 = GoogleFonts.sairaCondensed(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    color: AppColor.blackColor,
  );

  static TextStyle lightNameWithCountryTextStyle = GoogleFonts.sairaCondensed(
    fontSize: 25.0,
    color: AppColor.blackColor,
  );

  ///Build a text style
  static TextStyle degreeTextStyle = GoogleFonts.lilitaOne(
    fontSize: 90.0,
    fontWeight: FontWeight.bold,
    color: AppColor.whiteColor,
  );
}
