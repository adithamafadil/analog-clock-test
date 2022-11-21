import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'inject.config.dart';

final inject = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async => inject.init();
