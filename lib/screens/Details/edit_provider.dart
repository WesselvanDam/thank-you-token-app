import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thank_you_token/models/token.dart';
import 'package:thank_you_token/models/token_metadata.dart';

part 'edit_provider.g.dart';

@riverpod
class TokenEdit extends _$TokenEdit {
  @override
  Token? build() => null;

  void setToken(Token? token) {
    state = token;
  }

  void updateInfo(
      bool isFrom, TokenPartialInfo Function(TokenPartialInfo info) update) {
    state = isFrom
        ? state!.copyWith(fromInfo: update(state!.fromInfo))
        : state!.copyWith(toInfo: update(state!.toInfo));
  }
}
