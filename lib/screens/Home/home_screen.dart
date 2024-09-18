import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thank_you_token/models/token.dart';
import 'package:thank_you_token/providers/token_provider.dart';
import 'package:thank_you_token/providers/user_provider.dart';
import 'package:thank_you_token/services/auth/auth_service.dart';
import 'package:thank_you_token/widgets/add_token_card.dart';
import 'package:thank_you_token/widgets/token_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider).value;
    final tokens = ref.watch(tokensProvider);

    return WebSmoothScroll(
      controller: _scrollController,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar.large(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/glyph_color.png'),
            ),
            title: Text(
              'Welcome, ${user?.displayName?.split(' ').first ?? 'Guest'}',
            ),
            actions: actions(),
          ),
          tokenGrid(tokens),
        ],
      ),
    );
  }

  List<Widget> actions() => [
        PopupMenuButton<String>(
          popUpAnimationStyle: AnimationStyle(curve: Curves.easeInOut),
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

  Widget tokenGrid(AsyncValue<List<Token>> tokens) {
    return tokens.when(
        data: (data) => SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 5 / 4,
              ),
              itemBuilder: (context, index) => index == 0
                  ? const AddTokenCard()
                  : TokenCard(token: data[index - 1]),
              itemCount: data.length + 1,
            ),
        loading: () => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'If this takes too long, try refreshing by tapping the refresh icon. You may have blocked automatic popups.',
                        style: Theme.of(context).textTheme.labelLarge,
                      ).animate().fadeIn(delay: const Duration(seconds: 2)),
                    ),
                  ],
                ),
              ),
            ),
        error: (error, stackTrace) => SliverFillRemaining(
              child: Center(
                child: Text('Error: $error'),
              ),
            ));
  }
}
