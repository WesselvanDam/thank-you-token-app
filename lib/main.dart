import 'package:thank_you_token/utils/extensions.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thank_you_token/services/auth/auth_service.dart';
import 'package:thank_you_token/services/router/router.dart';

late final bool initialLogIn;

void main() async {
  setPathUrlStrategy();
  initialLogIn = await googleSignIn.signInSilently() != null;
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Thank You Token App',
      theme: themeData(context),
      routerConfig: router,
    );
  }
}

ThemeData themeData(BuildContext context) {
  const bodyFamily = 'AtkinsonHyperlegible';
  const headlineFamily = 'HurmeGeometricSans';
  TextTheme textTheme = Theme.of(context).textTheme.apply(
        fontFamily: bodyFamily,
      );
  textTheme = textTheme.copyWith(
    headlineSmall: textTheme.headlineSmall?.copyWithFamily(headlineFamily),
    headlineMedium: textTheme.headlineMedium?.copyWithFamily(headlineFamily),
    headlineLarge: textTheme.headlineLarge?.copyWithFamily(headlineFamily),
    displaySmall: textTheme.displaySmall?.copyWithFamily(headlineFamily),
    displayMedium: textTheme.displayMedium?.copyWithFamily(headlineFamily),
    displayLarge: textTheme.displayLarge?.copyWithFamily(headlineFamily),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.tytBlue),
    textTheme: textTheme,
  );
}
