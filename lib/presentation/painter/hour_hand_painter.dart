import 'dart:math';

import 'package:flutter/material.dart';

class HourHandPainter extends CustomPainter {
  final Paint hourHandPaint;
  final int hours;
  final int minutes;

  HourHandPainter({required this.hours, required this.minutes})
      : hourHandPaint = Paint() {
    hourHandPaint.color = const Color.fromARGB(255, 238, 238, 238);
    hourHandPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();
    canvas.translate(radius, radius);

    // Calculate rotation if 12
    canvas.rotate(hours >= 12
        ? 2 * pi * ((hours - 12) / 12 + (minutes / 720))
        : 2 * pi * ((hours / 12) + (minutes / 720)));

    Path lineHour = Path();

    // Draw hour hand stem
    lineHour.moveTo(-2.0, -radius + radius / 2.8);
    lineHour.lineTo(-1.0, 10.0);
    lineHour.lineTo(2.0, 10.0);
    lineHour.lineTo(1.0, -radius + radius / 2.8);
    lineHour.close();

    canvas.drawPath(lineHour, hourHandPaint);
    canvas.drawShadow(lineHour, Colors.black, 4.0, false);

    canvas.restore();
  }

  @override
  bool shouldRepaint(HourHandPainter oldDelegate) => true;
}
