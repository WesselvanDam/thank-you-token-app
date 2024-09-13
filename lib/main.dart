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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.tytBlue),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
