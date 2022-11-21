import 'package:analog_clock_test/data/model/alarm_model.dart';
import 'package:charts_flutter_new/flutter.dart' as chart;
import 'package:flutter/material.dart';

class ChartModal extends StatelessWidget {
  final List<AlarmModel> listAlarm;

  const ChartModal({required this.listAlarm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<chart.Series<AlarmModel, String>> series = [
      chart.Series(
        id: 'alarm-notif',
        data: listAlarm,
        fillColorFn: (_, __) => chart.ColorUtil.fromDartColor(Colors.blue),
        patternColorFn: (_, __) => chart.ColorUtil.fromDartColor(Colors.white),
        areaColorFn: (_, __) => chart.ColorUtil.fromDartColor(Colors.white),
        seriesColor: chart.Color.fromHex(code: 'FFFFFFF'),
        domainFn: (AlarmModel series, _) => series.notif!,
        measureFn: (AlarmModel series, _) => series.second,
        colorFn: (_, __) => chart.ColorUtil.fromDartColor(
          const Color(0xFF0E3993),
        ),
      )
    ];

    Widget renderBarChartTitle() => const Expanded(
          child: Text(
            'Alarm Response Chart',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          height: 400,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: const Icon(Icons.close),
                    onTap: () => Navigator.pop(context),
                  ),
                  renderBarChartTitle(),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(child: chart.BarChart(series, animate: true))
            ],
          ),
        ),
      ),
    );
  }
}
