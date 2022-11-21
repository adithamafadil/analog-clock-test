import 'package:analog_clock_test/data/model/alarm_model.dart';
import 'package:analog_clock_test/di/inject.dart';
import 'package:analog_clock_test/presentation/bloc/clock_bloc.dart';
import 'package:analog_clock_test/presentation/widget/add_alarm_button.dart';
import 'package:analog_clock_test/presentation/widget/chart_modal.dart';
import 'package:analog_clock_test/presentation/widget/clock_widget.dart';
import 'package:analog_clock_test/presentation/widget/set_alarm_widget.dart';
import 'package:analog_clock_test/utils/notification_api_listener.dart';
import 'package:analog_clock_test/utils/time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  final notif = inject<NotificationApiListener>();

  @override
  void initState() {
    notif.init();
    listenNotification();
    super.initState();
  }

  void listenNotification() =>
      notif.listener.stream.listen(onClickNotification);

  void onClickNotification(String? payload) async {
    final alarm = AlarmModel(
        notif: DateFormat('hh:mm:ss a yyyy-MM-dd')
            .format(DateTime.parse(payload!)),
        second: DateTime.now().difference(DateTime.parse(payload)).inSeconds,
        dateTime: DateTime.now().toString());

    showChart(context, alarm);
  }

  void showChart(BuildContext context, AlarmModel alarm) async =>
      await showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (BuildContext context) => SingleChildScrollView(
          child: ChartModal(listAlarm: [alarm]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClockBloc, ClockState>(
      builder: (context, clockState) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ClockWidget(dateTime: getInitialDate()),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: SetAlarmWidget(clockState: clockState),
              ),
              const SizedBox(height: 15),
              AddAlarmButton(clockState: clockState),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
