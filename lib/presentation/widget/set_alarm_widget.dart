import 'package:analog_clock_test/presentation/bloc/clock_bloc.dart';
import 'package:analog_clock_test/presentation/widget/clock_text.dart';
import 'package:analog_clock_test/utils/time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetAlarmWidget extends StatelessWidget {
  final ClockState clockState;
  const SetAlarmWidget({Key? key, required this.clockState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${getTimeHourFormat(
            dateTime: clockState.dateTime,
            isHourHandMoved: clockState.hourHandHasMoved,
          )}:${getTimeMinuteFormat(
            dateTime: clockState.dateTime,
            isMinuteHandMoved: clockState.minuteHandHasMoved,
          )}',
          style: const TextStyle(
            fontSize: 50,
            color: Color(0xFF0E3993),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        ToggleButtons(
          isSelected: clockState.movingHourMinuteHand,
          constraints: const BoxConstraints(minHeight: 30, minWidth: 100),
          selectedColor: const Color(0xFF0E3993),
          children: const [
            ClockText(
              text: 'Set Hour',
              variant: ClockTextVariant.textSwitch,
            ),
            ClockText(
              text: 'Set Minute',
              variant: ClockTextVariant.textSwitch,
            ),
          ],
          onPressed: (int index) => context.read<ClockBloc>().add(
              SetHandToMoveEvent(isMovingHourHand: index == 0 ? true : false)),
        ),
        ToggleButtons(
          isSelected: clockState.amPmTime,
          constraints: const BoxConstraints(minHeight: 30, minWidth: 100),
          selectedColor: const Color(0xFF0E3993),
          children: const [
            ClockText(
              text: 'AM',
              variant: ClockTextVariant.textSwitch,
            ),
            ClockText(
              text: 'PM',
              variant: ClockTextVariant.textSwitch,
            ),
          ],
          onPressed: (int index) => context
              .read<ClockBloc>()
              .add(SetAmOrPmEvent(isAmTime: index == 0 ? true : false)),
        ),
      ],
    );
  }
}
