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
    if (tokens.isLoading || tokens.value == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (tokens.hasError) {
      return Center(
        child: Text('Error: ${tokens.error}'),
      );
    }
    return GridView(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 5 / 4,
      ),
      children: AnimateList(
        interval: const Duration(milliseconds: 100),
        effects: [const FadeEffect()],
        children: [
          const AddTokenCard(),
          for (final token in tokens.value!) TokenCard(token: token),
        ],
      ),
    );
  }
}
