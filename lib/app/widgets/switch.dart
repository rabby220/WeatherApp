import 'package:flutter/material.dart';

class SwitchWidget {
  static Widget buildSwitch({
    bool value = false,
    required ValueChanged<bool> onChanged,
  }) {
    return Switch(
      value: value,
      onChanged: onChanged,
    );
  }
}
