import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:thank_you_token/providers/token_provider.dart';
import 'package:thank_you_token/providers/user_provider.dart';
import 'package:thank_you_token/screens/Home/local/token_grid.dart';
import 'package:thank_you_token/services/auth/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).value;

    return DynMouseScroll(
      builder: (context, controller, physics) => CustomScrollView(
        controller: controller,
        physics: physics,
        slivers: [
          SliverAppBar.large(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/glyph_color.png',
                gaplessPlayback: true,
              ),
            ),
            title: Text(
              'Welcome, ${user?.displayName?.split(' ').first ?? 'Guest'}',
            ),
            actions: actions(ref),
          ),
          const TokenGrid(),
        ],
      ),
    );
  }

  List<Widget> actions(WidgetRef ref) => [
        PopupMenuButton<String>(
          popUpAnimationStyle: AnimationStyle(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 400),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onSelected: (value) {
            switch (value) {
              case 'Sign out':
                googleSignIn.disconnect();
              case 'Refresh':
                ref.invalidate(tokensProvider);
              case 'About':
                launchUrl(Uri.parse('https://thank-you-token.nl'));
            }
          },
          itemBuilder: (BuildContext context) {
            return {
              ('Sign out', Icons.logout),
              ('Refresh', Icons.refresh),
              ('About', Icons.info),
            }.map((choice) {
              return PopupMenuItem<String>(
                value: choice.$1,
                child: Row(
                  children: [
                    Icon(choice.$2),
                    const SizedBox(width: 8),
                    Text(choice.$1),
                  ],
                ),
              );
            }).toList();
          },
        ),
      ];
}
