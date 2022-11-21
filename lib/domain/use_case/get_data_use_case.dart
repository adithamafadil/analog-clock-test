import 'package:analog_clock_test/domain/repository/clock_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDataUsecase {
  final ClockRepository _repository;
  const GetDataUsecase(this._repository);

  void call() => _repository.getData();
}
