import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thank_you_token/services/auth/auth_service.dart';

final userProvider = StreamProvider<GoogleSignInAccount?>(
  (ref) => googleSignIn.onCurrentUserChanged,
);
