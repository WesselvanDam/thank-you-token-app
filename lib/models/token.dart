import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:thank_you_token/models/token_metadata.dart';

part 'token.freezed.dart';

@freezed
class Token with _$Token {
  const Token._();
  const factory Token({
    required String id,
    required String name,
    required String thumbnailLink,
    required DateTime createdTime,
    required TokenPartialInfo fromInfo,
    required TokenPartialInfo toInfo,
  }) = _Token;

  factory Token.fromFile(File file, {String? accessToken}) {
    return Token(
      id: file.id!,
      name: file.name!,
      thumbnailLink: file.thumbnailLink!,
      createdTime: file.createdTime ?? DateTime.now(),
      fromInfo: TokenPartialInfo.fromInfo(file),
      toInfo: TokenPartialInfo.toInfo(file),
    );
  }

  Map<String, String> propertiesToJson() {
    return {
      ...fromInfo.propertiesToJson(),
      ...toInfo.propertiesToJson(),
    };
  }

  String encodeDescription() {
    return jsonEncode({
      'from_message': fromInfo.message,
      'to_message': toInfo.message,
    });
  }
}
