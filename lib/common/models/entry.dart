import 'package:freezed_annotation/freezed_annotation.dart';

part 'entry.freezed.dart';
part 'entry.g.dart';

@freezed
abstract class Entry with _$Entry {
  const factory Entry({
    int? entryId,
    int? userId,
    required String category,
    required String entryType,
    required int amount,
    required DateTime createdAt,
    String? note,
  }) = _Entry;

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
}
