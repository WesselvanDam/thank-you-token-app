import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thank_you_token/models/token.dart';
import 'package:thank_you_token/services/drive/drive_service.dart';

part 'token_provider.g.dart';

@Riverpod(keepAlive: true)
class Tokens extends _$Tokens {
  @override
  FutureOr<List<Token>> build() async {
    return DriveServiceApi().fetchTokens();
  }

  Future<bool> addToken(XFile image) async {
    return DriveServiceApi()
        .addToken(image)
        .then((token) => update((tokens) => [token, ...tokens]))
        .then((_) => true)
        .catchError((error) => false);
  }

  Future<bool> updateToken(Token token) async {
    return update((tokens) {
      final index = tokens.indexWhere((t) => t.id == token.id);
      tokens[index] = token;
      return tokens;
    }).then((_) => DriveServiceApi().updateToken(token)).then((updatedToken) {
      debugPrint('Updated Token equals Token: ${updatedToken == token}');
      debugPrint("Updated Token: $updatedToken");
      debugPrint("Token: $token");
      return updatedToken == token;
    }).catchError((error) => false);
  }

  Future<bool> deleteToken(Token token) async {
    return update((tokens) => tokens..remove(token))
        .then((_) => DriveServiceApi().deleteToken(token))
        .then((_) => true)
        .catchError((error) => false);
  }
}
