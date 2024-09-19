import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thank_you_token/main.dart';
import 'package:thank_you_token/providers/user_provider.dart';
import 'package:thank_you_token/services/router/routes.dart';
import 'package:thank_you_token/utils/extensions.dart';

final routerProvider = StateProvider<GoRouter>((ref) {
  final isLoggedIn = ValueNotifier<bool>(initialLogIn);

  ref
    ..onDispose(isLoggedIn.dispose)
    ..listen(
      userProvider,
      (_, next) => isLoggedIn.value = next.valueOrNull != null,
    );

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation:
        isLoggedIn.value ? HomeRoute().location : LoginRoute().location,
    routes: $appRoutes,
    redirect: (context, state) {
      final onLogin = state.fullPath == LoginRoute().location;
      if (onLogin && isLoggedIn.value) {
        return HomeRoute().location;
      }
      final onPathRequiringAuth = state.fullPath != LoginRoute().location;
      if (onPathRequiringAuth && !isLoggedIn.value) {
        return LoginRoute().location;
      }
      if (state.fullPath?.isEmpty ?? true) {
        return HomeRoute().location;
      }
      return null;
    },
    refreshListenable: isLoggedIn,
  );
});
