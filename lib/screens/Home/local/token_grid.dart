import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thank_you_token/providers/token_provider.dart';
import 'package:thank_you_token/widgets/add_token_card.dart';
import 'package:thank_you_token/widgets/token_card.dart';

class TokenGrid extends ConsumerWidget {
  const TokenGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = ref.watch(tokensProvider);
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
                        'If this takes too long, try refreshing via the menu. You may have blocked automatic popups.',
                        style: Theme.of(context).textTheme.labelLarge,
                      ).animate().fadeIn(delay: const Duration(seconds: 3)),
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
