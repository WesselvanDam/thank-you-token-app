import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thank_you_token/providers/token_provider.dart';
import 'package:thank_you_token/providers/user_provider.dart';
import 'package:thank_you_token/services/auth/auth_service.dart'
    show googleSignIn;
import 'package:google_sign_in/google_sign_in.dart';

class ShellScreen extends ConsumerWidget {
  const ShellScreen({super.key, required this.child});

  final Widget child;

  Future<void> _handleSignOut() => googleSignIn.disconnect();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).value;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Image.asset('assets/images/glyph_color.png'),
        ),
        title: const Text('Thank You Token'),
        actions: [
          if (user != null)
            GoogleUserCircleAvatar(
              identity: user,
            ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleSignOut,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(tokensProvider),
          )
        ],
      ),
      body: child,
    );
  }
}
