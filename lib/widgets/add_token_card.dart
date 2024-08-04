import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thank_you_token/providers/token_provider.dart';

class AddTokenCard extends ConsumerStatefulWidget {
  const AddTokenCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTokenCardState();
}

class _AddTokenCardState extends ConsumerState<AddTokenCard> {
  bool isAsync = false;

  void _handleAddToken() {
    if (isAsync) return;
    setState(() => isAsync = true);
    ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((image) async {
      if (image != null) {
        await ref.read(tokensProvider.notifier).addToken(image);
      }
    }).then((_) => setState(() => isAsync = false));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleAddToken(),
      child: Card.outlined(
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: ColoredBox(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Center(
                      child: Image.asset(
                        'assets/images/glyph_white.png',
                        width: 80,
                        height: 80,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      )
                    ),
                  ),
                ),
              ),
              if (isAsync)
                const LinearProgressIndicator(),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 80),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    Text('Add a new token'),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
