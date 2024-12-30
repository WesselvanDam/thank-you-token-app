import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thank_you_token/services/drive/drive_service.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class User extends _$User {
  @override
  GoogleSignInAccount? build() {
    final initialUser = ref.watch(initialUserProvider);
    if (initialUser != null) {
      return initialUser;
    } else {
      DriveServiceApi().onCurrentUserChanged().listen((user) {
        state = user;
      });
      return null;
    }
  }
}

@Riverpod(keepAlive: true)
GoogleSignInAccount? initialUser(InitialUserRef ref) => null;
