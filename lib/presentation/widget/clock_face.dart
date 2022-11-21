import 'package:analog_clock_test/presentation/bloc/clock_bloc.dart';
import 'package:analog_clock_test/presentation/painter/clock_dial_painter.dart';
import 'package:analog_clock_test/presentation/widget/hour_hand.dart';
import 'package:analog_clock_test/presentation/widget/minute_hand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClockFace extends StatelessWidget {
  final DateTime dateTime;

  const ClockFace({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/background.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black26,
            ),
            child: renderClockComponents(context),
          ),
        ),
      ),
    );
  }

  Widget renderClockComponents(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: CustomPaint(painter: ClockDialPainter()),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                MinuteHand(
                  minute: dateTime.minute,
                  second: dateTime.second,
                ),
                if (context.select(
                    (ClockBloc bloc) => bloc.state.movingHourMinuteHand.first))
                  HourHand(
                    minute: dateTime.minute,
                    hour: dateTime.hour,
                  ),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 10.0,
              height: 10.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
