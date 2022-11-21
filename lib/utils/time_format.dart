import 'package:intl/intl.dart';

String getTimeHourFormat({
  required DateTime dateTime,
  required bool isHourHandMoved,
}) =>
    isHourHandMoved ? DateFormat('hh').format(dateTime) : '00';

String getTimeMinuteFormat({
  required DateTime dateTime,
  required bool isMinuteHandMoved,
}) =>
    isMinuteHandMoved ? DateFormat('mm').format(dateTime) : '00';

DateTime getInitialDate() {
  final dateTime = DateTime.now();
  return DateTime(dateTime.year, dateTime.month, dateTime.day, 12, 00);
}

String getDateTimeFormat({
  required bool isAm,
  required DateTime dateTime,
}) =>
    DateFormat('yyyy-MM-dd hh:mm a').format(
      getDateTime(isAm: isAm, dateTime: dateTime),
    );

DateTime getDateTime({required bool isAm, required DateTime dateTime}) =>
    DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.hour > (isAm ? dateTime.hour : dateTime.hour + 12)
          ? dateTime.day + 1
          : dateTime.hour == (isAm ? dateTime.hour : dateTime.hour + 12) &&
                  dateTime.minute >= dateTime.minute &&
                  dateTime.second > 0
              ? dateTime.day + 1
              : dateTime.day,
      isAm ? dateTime.hour : dateTime.hour + 12,
      dateTime.minute,
    );
