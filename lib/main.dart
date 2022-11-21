import 'package:analog_clock_test/presentation/bloc/clock_bloc.dart';
import 'package:analog_clock_test/di/inject.dart';
import 'package:analog_clock_test/presentation/screen/clock_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/data/latest.dart' as time_zone;

Future<void> main() async {
  // Initialize timeZone for notification schedule
  time_zone.initializeTimeZones();

  // Ensure native modules initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await configureDependencies();

  // Initialize ClockBloc
  runApp(
    BlocProvider(
      create: (context) => inject<ClockBloc>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: Scaffold(body: ClockScreen()),
      );
}
