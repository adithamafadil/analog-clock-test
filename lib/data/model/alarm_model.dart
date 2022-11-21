import 'package:freezed_annotation/freezed_annotation.dart';
part 'alarm_model.g.dart';
part 'alarm_model.freezed.dart';

@freezed
class AlarmModel with _$AlarmModel {
  const factory AlarmModel({
    required int second,
    required String dateTime,
    String? notif,
  }) = _AlarmModel;

  factory AlarmModel.fromJson(Map<String, dynamic> json) =>
      _$AlarmModelFromJson(json);
}
