import 'dart:math';

import 'package:analog_clock_test/utils/constants.dart';
import 'package:flutter/material.dart';

class ClockDialPainter extends CustomPainter {
  ClockDialPainter();

  final hourTickLength = 0.0;
  final minuteTickLength = 5.0;

  final hourTickWidth = 3.0;
  final minuteTickWidth = 1.5;

  final Paint tickPaint = Paint()..color = Colors.white.withOpacity(0.7);

  @override
  void paint(Canvas canvas, Size size) {
    late double tickLength;
    late double angle = 2 * pi / 60;
    final radius = size.width / 2;
    double fontSize = (radius) / 40 * 8 * 0.7;
    canvas.save();

    canvas.translate(radius, radius);

    for (var i = 0; i < 60; i++) {
      tickLength = (i % 5 == 0) ? hourTickLength : minuteTickLength;
      tickPaint.strokeWidth = (i % 5 == 0) ? hourTickWidth : minuteTickWidth;
      canvas.drawLine(
          Offset(0.0, -radius), Offset(0.0, -radius + tickLength), tickPaint);

      canvas.rotate(angle);
    }
    _paintHourText(canvas, radius, fontSize);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  final TextPainter _hourTextPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  double _getRadians(double angle) => angle * pi / 180;
  double _paintHourText(Canvas canvas, double radius, double fontSize) {
    double maxTextHeight = 0;
    for (var i = 0; i < 12; i++) {
      final _angle = i * 30.0;
      canvas.save();
      double hourNumberX = cos(_getRadians(_angle)) * radius;
      double hourNumberY = sin(_getRadians(_angle)) * radius;
      canvas.translate(hourNumberX, hourNumberY);
      int intHour = i + 3;
      if (intHour > 12) intHour = intHour - 12;

      String hourText = hourNumbers[intHour - 1];
      _hourTextPainter.text = TextSpan(
        text: hourText,
        style: TextStyle(fontSize: fontSize, color: Colors.white),
      );
      _hourTextPainter.layout();

      if (_hourTextPainter.height > maxTextHeight) {
        maxTextHeight = _hourTextPainter.height;
      }
      _hourTextPainter.paint(
        canvas,
        Offset(-_hourTextPainter.width / 2, -_hourTextPainter.height / 2),
      );
      canvas.restore();
    }

    return maxTextHeight;
  }
}
