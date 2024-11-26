import 'package:flutter/material.dart';

class TextWidget {
  static Widget buildTextWidget({
    required String text,
    required TextStyle textStyle,
  }) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
