import 'package:analog_clock_test/presentation/widget/clock_face.dart';
import 'package:flutter/material.dart';

class ClockWidget extends StatelessWidget {
  final DateTime dateTime;

  const ClockWidget({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) => Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClockFace(dateTime: dateTime),
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue[400],
          boxShadow: const [
            BoxShadow(
              offset: Offset(0.0, 1.0),
              blurStyle: BlurStyle.normal,
              blurRadius: 3.0,
              spreadRadius: -4,
            )
          ],
        ),
      );
}
