import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PartnerData {
  String gender;
  String name;
  String nickname;
  DateTime? nameDay;
  DateTime? anniversary;
  DateTime? birtDay;
  DateTime? importantDay;

  PartnerData({
    required this.gender,
    required this.name,
    required this.nickname,
    required this.nameDay,
    required this.anniversary,
    required this.importantDay,
  });

  factory PartnerData.fromJson(Map<String, dynamic> json) =>
      _$PartnerDataFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerDataToJson(this);
}

PartnerData _$PartnerDataFromJson(Map<String, dynamic> json) {
  return PartnerData(
    gender: json['gender'] as String,
    name: json['name'] as String,
    nickname: json['nickname'] as String,
    nameDay: DateTime.parse(json['nameday'] as String),
    anniversary: DateTime.parse(json['anniversary'] as String),
    importantDay: DateTime.parse(json['importantDay'] as String),
  );
}

Map<String, dynamic> _$PartnerDataToJson(PartnerData instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'name': instance.name,
      'nickname': instance.nickname,
      // 'nameday': instance.nameday.toIso8601String(),
      // 'anniversary': instance.anniversary.toIso8601String(),
      // 'importantDay': instance.importantDay.toIso8601String(),
    };
