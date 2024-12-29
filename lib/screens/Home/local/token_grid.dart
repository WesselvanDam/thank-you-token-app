import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:thank_you_token/providers/token_provider.dart';
import 'package:thank_you_token/screens/Home/local/first_token_prompt.dart';
import 'package:thank_you_token/screens/Home/local/not_authorised_prompt.dart';
import 'package:thank_you_token/widgets/add_token_card.dart';
import 'package:thank_you_token/widgets/token_card.dart';

class TokenGrid extends ConsumerWidget {
  const TokenGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = ref.watch(tokensProvider);
    return tokens.when(
      data: (data) {
        if (data.isEmpty) {
          return SliverToBoxAdapter(
            child: const FirstTokenPrompt(key: ValueKey('newToken'),)
                .animate()
                .fadeIn(duration: const Duration(seconds: 1)),
          );
        }
        return SliverGrid.builder(
          findChildIndexCallback: (key) =>
              data.indexWhere((element) => element.name == key.toString()) + 1,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 5 / 4,
          ),
          itemBuilder: (context, index) {
            final item = index == 0
                ? const AddTokenCard(
                    key: ValueKey(0),
                  )
                : TokenCard(
                    token: data[index - 1],
                    key: ValueKey(data[index - 1].name),
                  );
            return item.animate().fadeIn();
          },
          itemCount: data.length + 1,
        );
      },
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
      error: (error, stackTrace) {
        return SliverToBoxAdapter(
          child: const NotAuthorisedPrompt(key: ValueKey('notAuthorised'))
              .animate()
              .fadeIn(duration: const Duration(seconds: 1)),
        );
      },
    );
  }
}
