part of 'clock_bloc.dart';

@freezed
class ClockEvent with _$ClockEvent {
  const factory ClockEvent.setHourEvent({required int hour}) = SetHourEvent;

  const factory ClockEvent.setMinuteEvent({required int minute}) =
      SetMinuteEvent;

  const factory ClockEvent.setHandToMoveEvent({
    required bool isMovingHourHand,
  }) = SetHandToMoveEvent;

  const factory ClockEvent.setAmOrPmEvent({required bool isAmTime}) =
      SetAmOrPmEvent;
}
