import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thank_you_token/providers/token_provider.dart';
import 'package:thank_you_token/providers/user_provider.dart';
import 'package:thank_you_token/screens/Home/local/token_grid.dart';
import 'package:thank_you_token/services/auth/auth_service.dart';
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

  Future<void> _handleSignOut() => googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider).value;
    return WebSmoothScroll(
      controller: _scrollController,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar.large(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/glyph_color.png',
              ),
            ),
            title: Text(
                'Welcome, ${user?.displayName?.split(' ').first ?? 'Guest'}'),
            actions: [
              IconButton(
                tooltip: "Sign out",
                icon: const Icon(Icons.logout),
                onPressed: _handleSignOut,
              ),
              IconButton(
                tooltip: "Refresh",
                icon: const Icon(Icons.refresh),
                onPressed: () => ref.invalidate(tokensProvider),
              )
            ],
          ),
          const SliverFillRemaining(child: TokenGrid()),
        ],
      ),
    );
  }
}
