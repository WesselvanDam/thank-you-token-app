import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thank_you_token/providers/user_provider.dart';
import 'package:thank_you_token/services/router/routes.dart';

final routerProvider = StateProvider<GoRouter>((ref) {
  final isLoggedIn = ValueNotifier<bool>(ref.read(userProvider) != null);

  ref
    ..onDispose(isLoggedIn.dispose)
    ..listen(
      userProvider,
      (_, user) => isLoggedIn.value = user != null,
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
      final onPathRequiringAuthentication = state.fullPath != LoginRoute().location;
      if (onPathRequiringAuthentication && !isLoggedIn.value) {
        return LoginRoute().location;
      }     
      return null;
    },
    refreshListenable: isLoggedIn,
  );
});
