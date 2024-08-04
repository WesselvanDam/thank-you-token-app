import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thank_you_token/models/token.dart';
import 'package:thank_you_token/providers/token_provider.dart';
import 'package:thank_you_token/screens/Details/edit_provider.dart';
import 'package:thank_you_token/screens/Details/local/details_info.dart';
import 'package:thank_you_token/utils/extensions.dart';
import 'package:thank_you_token/widgets/token_image.dart';

class DetailsScreen extends ConsumerWidget {
  const DetailsScreen({super.key});

  void _handleEdit(WidgetRef ref, Token token) {
    ref.read(tokenEditProvider.notifier).setToken(token);
  }

  void _handleSave(WidgetRef ref) {
    ref.read(tokensProvider.notifier).updateToken(ref.read(tokenEditProvider)!);
    ref.read(tokenEditProvider.notifier).setToken(null);
  }

  void _handleDelete(BuildContext context, WidgetRef ref, Token token) {
    ref.read(tokensProvider.notifier).deleteToken(token);
    context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = GoRouterState.of(context).pathParameters['id'];
    final token = ref.watch(tokensProvider.select((state) => state.asData?.value
        .firstWhereOrNull((element) => element.name == name)));

    final isEditing =
        ref.watch(tokenEditProvider.select((value) => value != null));

    if (token == null) {
      return const SizedBox();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TokenImage(token, borderRadius: 24),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            if (isEditing)
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                onPressed: () => _handleSave(ref),
              )
            else
              ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
                onPressed: () => _handleEdit(ref, token),
              ),
            OutlinedButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text('Delete'),
              onPressed: () => _handleDelete(context, ref, token),
            ),
          ],
        ),
        Column(
          children: [
            DetailsInfo(token.fromInfo),
            const Divider(indent: 24, endIndent: 24),
            DetailsInfo(token.toInfo),
          ],
        ),
      ],
    );
  }
}
