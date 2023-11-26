import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userSetting.g.dart';

@JsonSerializable()
class UserData {
  @JsonKey(name: 'birthday', fromJson: _timestampToDateTime, toJson: _dateTimeToTimestamp)
  final DateTime anniversary;

  @JsonKey(name: 'anniversary', fromJson: _timestampToDateTime, toJson: _dateTimeToTimestamp)
  final DateTime birthday;

  @JsonKey(name: 'frequency')
  final int frequency;

  @JsonKey(name: 'gender')
  final String gender;

  @JsonKey(name: 'userName')
  final String userName;

  UserData({
    required this.anniversary,
    required this.birthday,
    required this.frequency,
    required this.gender,
    required this.userName,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  static DateTime _timestampToDateTime(Timestamp timestamp) => timestamp.toDate();
  static Timestamp _dateTimeToTimestamp(DateTime dateTime) => Timestamp.fromDate(dateTime);
}