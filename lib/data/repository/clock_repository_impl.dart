import 'package:analog_clock_test/data/repository/src/clock_local_data_source.dart';
import 'package:analog_clock_test/data/repository/src/clock_remote_data_source.dart';
import 'package:analog_clock_test/domain/repository/clock_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ClockRepository)
class ClockRepositoryImpl implements ClockRepository {
  final ClockRemoteDataSource _remoteDataSource;
  final ClockLocalDataSource _localDataSource;

  const ClockRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
  );

  @override
  void getData() {
    final myList = [];

    if (myList.isEmpty) {
      _remoteDataSource.callRemoteData();
    } else {
      _localDataSource.callLocalData();
    }
  }
}
