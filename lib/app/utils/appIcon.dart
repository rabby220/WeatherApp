import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIcon {
  //When user back offline show will this icon
  static IconData wifiOffIcon = Icons.wifi_off;
  //When user back online show will this icon
  static IconData wifiIcon = Icons.wifi;

  static IconData humidityIcon = FontAwesomeIcons.droplet; // Humidity
  static IconData windSpeedIcon = FontAwesomeIcons.wind; // Wind Speed
  static IconData feelsLikeIcon =
      FontAwesomeIcons.temperatureHalf; // Feels Like

  //  temperature icon
  static IconData temperatureIcon =
      FontAwesomeIcons.temperatureHigh;

}
