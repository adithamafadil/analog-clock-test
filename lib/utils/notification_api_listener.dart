import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as time_zone;

@lazySingleton
class NotificationApiListener {
  final notification = FlutterLocalNotificationsPlugin();
  final listener = BehaviorSubject<String?>();

  Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const initializationSettings =
        InitializationSettings(android: android, iOS: ios);
    await notification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async =>
          listener.add(payload.payload),
    );
  }

  Future showNotificationSchedule({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleDate,
  }) async =>
      notification.zonedSchedule(
        id,
        title,
        body,
        time_zone.TZDateTime.from(scheduleDate, time_zone.local),
        await notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

  Future notificationDetails() async {
    const sound = 'alarm_sound.wav';
    return const NotificationDetails(
        iOS: DarwinNotificationDetails(sound: sound),
        android: AndroidNotificationDetails(
          'notifAlarmChannel',
          'notif-alarm-channel',
          channelDescription: '-',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('alarm_sound'),
          enableVibration: true,
        ));
  }

  void cancel() => notification.cancelAll();
}
