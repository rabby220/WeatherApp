import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:weather_app/app/utils/appColor.dart';

Widget LoadingIndicatorIcon() {
  return Center(
    child: SizedBox(
      height: 70.0,
      width: 70.0,
      child: LoadingIndicator(
        colors: [
          AppColor.redColor,
          AppColor.orangeColor,
          AppColor.yellowColor,
          AppColor.greenColor,
          AppColor.blueColor,
          AppColor.indigoColor,
          AppColor.purpleColor,
        ],
        indicatorType: Indicator.ballRotateChase,
      ),
    ),
  );
}
