import 'package:analog_clock_test/presentation/bloc/clock_bloc.dart';
import 'package:analog_clock_test/presentation/painter/minute_hand_painter.dart';
import 'package:analog_clock_test/utils/rotation_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MinuteHand extends StatefulWidget {
  final int minute;
  final int second;

  const MinuteHand({super.key, required this.minute, required this.second});

  @override
  _MinuteHandState createState() => _MinuteHandState();
}

class _MinuteHandState extends State<MinuteHand>
    with SingleTickerProviderStateMixin {
  late double wheelSize;
  double degree = 0;
  int _valueChoose = 0;
  late double radius;
  late AnimationController ctrl;
  @override
  void initState() {
    super.initState();
    wheelSize = 300;
    radius = wheelSize / 2;
    ctrl = AnimationController.unbounded(vsync: this);
    degree = 0;
    ctrl.value = degree;
  }

  _panUpdateHandler(DragUpdateDetails d) {
    bool onTop = d.localPosition.dy <= radius;
    bool onLeftSide = d.localPosition.dx <= radius;
    bool onRightSide = !onLeftSide;
    bool onBottom = !onTop;

    bool panUp = d.delta.dy <= 0.0;
    bool panLeft = d.delta.dx <= 0.0;
    bool panRight = !panLeft;
    bool panDown = !panUp;

    double yChange = d.delta.dy.abs();
    double xChange = d.delta.dx.abs();

    double verticalRotation = (onRightSide && panDown) || (onLeftSide && panUp)
        ? yChange
        : yChange * -1;
    double horizontalRotation =
        (onTop && panRight) || (onBottom && panLeft) ? xChange : xChange * -1;
    double rotationalChange = verticalRotation + horizontalRotation;
    double _value = degree + (rotationalChange / 5);

    setState(() {
      degree = _value > 0 ? _value : 0;
      ctrl.value = degree;
      double a = degree < 360 ? degree.roundToDouble() : degree - 360;
      double degrees = roundToBase(a.roundToDouble(), 5);
      _valueChoose = degrees ~/ 6 == 60 ? 0 : degrees ~/ 6;
      BlocProvider.of<ClockBloc>(context).add(
        SetMinuteEvent(minute: _valueChoose),
      );
    });
  }

  _panEndHandler(DragEndDetails d) {
    double a = degree < 360 ? degree.roundToDouble() : degree - 360;
    ctrl
        .animateTo(roundToBase(a.roundToDouble(), 10),
            duration: const Duration(milliseconds: 551),
            curve: Curves.easeOutBack)
        .whenComplete(() => setState(() {
              degree = roundToBase(a.roundToDouble(), 10);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _panUpdateHandler,
      onPanEnd: _panEndHandler,
      child: Container(
        height: radius * 2,
        width: radius * 2,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.transparent,
        ),
        child: Align(
          alignment: const Alignment(0, 0),
          child: AnimatedBuilder(
            animation: ctrl,
            builder: (ctx, w) => Transform.rotate(
              angle: degreeToRadians(ctrl.value),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: CustomPaint(
                  painter: MinuteHandPainter(
                    minutes: widget.minute,
                    seconds: widget.second,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
