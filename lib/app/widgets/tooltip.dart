import 'package:flutter/material.dart';

import '../utils/appText.dart';

class ToolTipWidget {
  static Widget buildToolTip({
    required String toolMessage,
    required Widget child,
  }) {
    return Tooltip(
      message: toolMessage,
      triggerMode: TooltipTriggerMode.tap,
      height: 24,
      showDuration: const Duration(milliseconds: 1000),
      textStyle: AppText.nameWithCountryTextStyle,
      child: child,
    );
  }
}
