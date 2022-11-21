import 'package:flutter/material.dart';

enum ClockTextVariant {
  textSwitch;

  bool get isTextSwitchVariant => this == textSwitch;
}

class ClockText extends StatelessWidget {
  final String text;
  final ClockTextVariant? variant;
  const ClockText({
    Key? key,
    required this.text,
    this.variant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style(),
    );
  }

  TextStyle? style() {
    if (variant?.isTextSwitchVariant ?? false) {
      return const TextStyle(fontWeight: FontWeight.w500, fontSize: 15);
    }
    return null;
  }
}
