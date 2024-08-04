import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:googleapis/drive/v3.dart';

part 'token_metadata.freezed.dart';

@freezed
class TokenPartialInfo with _$TokenPartialInfo {
  const TokenPartialInfo._();
  const factory TokenPartialInfo({
    required final bool isFrom,
    final String? name,
    final DateTime? date,
    final String? message,
  }) = _TokenPartialInfo;

  factory TokenPartialInfo.fromInfo(File file) {
    return TokenPartialInfo(
      isFrom: true,
      name: file.properties?['from_name'],
      date: file.properties?['from_date'] != null
          ? DateTime.tryParse(file.properties!['from_date']!)
          : file.createdTime,
      message: Map.castFrom(jsonDecode(file.description ?? '{}'))['from_message'],
    );
  }

  factory TokenPartialInfo.toInfo(File file) {
    return TokenPartialInfo(
      isFrom: false,
      name: file.properties?['to_name'],
      date: DateTime.tryParse(file.properties?['to_date'] ?? ''),
      message: Map.castFrom(jsonDecode(file.description ?? '{}'))['to_message'],
    );
  }

  Map<String, String> propertiesToJson() {
    return {
      if (isFrom) 'from_name': name ?? '',
      if (isFrom) 'from_date': date?.toIso8601String() ?? '',
      if (!isFrom) 'to_name': name ?? '',
      if (!isFrom) 'to_date': date?.toIso8601String() ?? '',
    };
  }
}
