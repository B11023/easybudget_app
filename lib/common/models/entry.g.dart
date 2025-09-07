// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EntryImpl _$$EntryImplFromJson(Map<String, dynamic> json) => _$EntryImpl(
      entryId: (json['entryId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      category: json['category'] as String,
      entryType: json['entryType'] as String,
      amount: (json['amount'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      note: json['note'] as String,
    );

Map<String, dynamic> _$$EntryImplToJson(_$EntryImpl instance) =>
    <String, dynamic>{
      'entryId': instance.entryId,
      'userId': instance.userId,
      'category': instance.category,
      'entryType': instance.entryType,
      'amount': instance.amount,
      'createdAt': instance.createdAt.toIso8601String(),
      'note': instance.note,
    };
