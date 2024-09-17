import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thank_you_token/screens/Details/details_screen.dart';
import 'package:thank_you_token/screens/Home/home_screen.dart';
import 'package:thank_you_token/screens/Login/login_screen.dart';
import 'package:thank_you_token/screens/Shell/shell_screen.dart';

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

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with FadeRoute {
  LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@TypedShellRoute<ShellRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(path: '/', routes: [
      TypedGoRoute<TokenDetailsRoute>(path: 'token/:id'),
    ]),
  ],
)
class ShellRoute extends ShellRouteData {
  ShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return HeroControllerScope(
      controller: MaterialApp.createMaterialHeroController(),
      child: ShellScreen(child: navigator),
    );
  }
}

class HomeRoute extends GoRouteData {
  HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

class TokenDetailsRoute extends GoRouteData {
  TokenDetailsRoute({required this.id});

  final String id;

  @override
  Page buildPage(BuildContext context, GoRouterState state) {
    return const DetailsPage(child: DetailsScreen());
  }
}

class DetailsPage<T> extends Page<T> {
  const DetailsPage({required this.child});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 600;
    if (!isWide) {
      return ModalBottomSheetRoute<T>(
        settings: this,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.9,
              minChildSize: 0.5,
              maxChildSize: 1,
              expand: false,
              builder: (context, scrollController) => SingleChildScrollView(
                    controller: scrollController,
                    child: child,
                  ));
        },
      );
    }
    return RawDialogRoute<T>(
      settings: this,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: 400,
              height: double.infinity,
              child: FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  )
                      .chain(CurveTween(curve: Curves.easeOutCubic))
                      .animate(animation),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    child: ColoredBox(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: SingleChildScrollView(child: child),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
