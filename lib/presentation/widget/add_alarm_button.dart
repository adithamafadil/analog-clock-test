import 'package:analog_clock_test/di/inject.dart';
import 'package:analog_clock_test/presentation/bloc/clock_bloc.dart';
import 'package:analog_clock_test/utils/notification_api_listener.dart';
import 'package:analog_clock_test/utils/time_format.dart';
import 'package:flutter/material.dart';

class AddAlarmButton extends StatelessWidget {
  final ClockState clockState;
  AddAlarmButton({Key? key, required this.clockState}) : super(key: key);

  final notif = inject<NotificationApiListener>();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.alarm_add),
      label: const Text('Add Alarm', style: TextStyle(color: Colors.white)),
      onPressed: (clockState.amPmTime.contains(true))
          ? () async {
              notif.showNotificationSchedule(
                title: 'Hi User!',
                body: 'Your alarm is active!',
                payload: getDateTime(
                  isAm: clockState.amPmTime.first,
                  dateTime: clockState.dateTime,
                ).toString(),
                scheduleDate: getDateTime(
                  isAm: clockState.amPmTime.first,
                  dateTime: clockState.dateTime,
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Alarm set on ${getDateTimeFormat(
                    isAm: clockState.amPmTime.first,
                    dateTime: clockState.dateTime,
                  )}',
                ),
              ));
            }
          : null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }
}
