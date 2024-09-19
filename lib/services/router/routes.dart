import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thank_you_token/screens/Details/details_screen.dart';
import 'package:thank_you_token/screens/Home/home_screen.dart';
import 'package:thank_you_token/screens/Login/login_screen.dart';
import 'package:thank_you_token/services/router/local/details_page.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

// Create a mixin that overrides buildPage for a fade transition
mixin FadeRoute on GoRouteData {
  @override
  Page buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: build(context, state),
    );
  }
}

mixin MaterialPage on GoRouteData {
  // Wrap the buildPage method to return a MaterialPage. We cannot override
  // buildPage because it needs to be customised by the routes themselves.
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with FadeRoute {
  LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@TypedGoRoute<HomeRoute>(path: '/', routes: [
  TypedGoRoute<TokenDetailsRoute>(path: 'token/:id'),
])
class HomeRoute extends GoRouteData {
  HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Material(child: HomeScreen());
  }
}

class TokenDetailsRoute extends GoRouteData {
  TokenDetailsRoute({required this.id});

  final String id;

  // Redirect to the home page if the token is not found
  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (id.isEmpty ) {
      return HomeRoute().location;
    }
    return null;
  }


  @override
  Page buildPage(BuildContext context, GoRouterState state) {
    return const DetailsPage(child: DetailsScreen());
  }
}
