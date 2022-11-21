part of 'clock_bloc.dart';

@freezed
class ClockState with _$ClockState {
  const factory ClockState({
    required List<bool> amPmTime,
    required List<bool> movingHourMinuteHand,
    required DateTime dateTime,
    required bool hourHandHasMoved,
    required bool minuteHandHasMoved,
  }) = _ClockState;

  factory ClockState.initial() => ClockState(
        dateTime: DateTime.now(),
        hourHandHasMoved: false,
        minuteHandHasMoved: false,
        amPmTime: [false, false],
        movingHourMinuteHand: [true, false],
      );
}
