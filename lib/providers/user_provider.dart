import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thank_you_token/services/auth/auth_service.dart';

// If there is an initial login, the user is googleSignIn.currentUser. Return
// that, but afterwards listen to googleSignIn.onCurrentUserChanged and return
// the new user.
final userProvider = StreamProvider<GoogleSignInAccount?>(
  (ref) => StreamGroup.merge([
    Stream.value(googleSignIn.currentUser),
    googleSignIn.onCurrentUserChanged
  ]),
);
