// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userSetting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      anniversary: (json['anniversary'] as Timestamp).toDate(),
      birthday: (json['birthday'] as Timestamp).toDate(),
      frequency: json['frequency'] as int,
      gender: json['gender'] as String,
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'anniversary': instance.anniversary,
      'birthday': instance.birthday,
      'frequency': instance.frequency,
      'gender': instance.gender,
      'userName': instance.userName,
    };
