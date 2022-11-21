import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'clock_event.dart';
part 'clock_state.dart';
part 'clock_bloc.freezed.dart';

@lazySingleton
class ClockBloc extends Bloc<ClockEvent, ClockState> {
  ClockBloc() : super(ClockState.initial()) {
    on<ClockEvent>(_mapEvent);
  }

  Future<void> _mapEvent(ClockEvent events, Emitter<ClockState> emit) async {
    await events.map(
      setHourEvent: (event) => _handleSetHourEvent(event, emit),
      setMinuteEvent: (event) => _handleSetMinuteEvent(event, emit),
      setHandToMoveEvent: (event) => _handleSetHandToMoveEvent(event, emit),
      setAmOrPmEvent: (event) => _handleSetAmOrPmEvent(event, emit),
    );
  }

  Future<void> _handleSetHourEvent(
    SetHourEvent event,
    Emitter<ClockState> emit,
  ) async {
    final DateTime dateTime = state.dateTime;
    final DateTime newDateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      event.hour,
      dateTime.minute,
    );

    emit(state.copyWith(dateTime: newDateTime, hourHandHasMoved: true));
  }

  Future<void> _handleSetMinuteEvent(
    SetMinuteEvent event,
    Emitter<ClockState> emit,
  ) async {
    final DateTime dateTime = state.dateTime;
    final DateTime newDateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      event.minute,
    );

    emit(state.copyWith(dateTime: newDateTime, minuteHandHasMoved: true));
  }

  Future<void> _handleSetHandToMoveEvent(
    SetHandToMoveEvent event,
    Emitter<ClockState> emit,
  ) async {
    final result = event.isMovingHourHand ? [true, false] : [false, true];
    emit(state.copyWith(movingHourMinuteHand: result));
  }

  Future<void> _handleSetAmOrPmEvent(
    SetAmOrPmEvent event,
    Emitter<ClockState> emit,
  ) async {
    final result = event.isAmTime ? [true, false] : [false, true];
    emit(state.copyWith(amPmTime: result));
  }
}
