// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userSetting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      anniversary: UserData._timestampToDateTime(json['birthday'] as Timestamp),
      birthday: UserData._timestampToDateTime(json['anniversary'] as Timestamp),
      frequency: json['frequency'] as int,
      gender: json['gender'] as String,
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'birthday': UserData._dateTimeToTimestamp(instance.anniversary),
      'anniversary': UserData._dateTimeToTimestamp(instance.birthday),
      'frequency': instance.frequency,
      'gender': instance.gender,
      'userName': instance.userName,
    };
