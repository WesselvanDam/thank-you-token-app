import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thank_you_token/utils/image_picker.dart';

class FirstTokenPrompt extends ConsumerStatefulWidget {
  const FirstTokenPrompt({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FirstTokenPromptState();
}

class _FirstTokenPromptState extends ConsumerState<FirstTokenPrompt> {
  bool isAsync = false;

  void _handleAddToken() {
    if (isAsync) return;
    setState(() => isAsync = true);
    addTokenSequence(context, ref).then((_) => setState(() => isAsync = false));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/store_illustration.png',
                height: 810 * (400 / 1080),
                width: 400,
              ),
              const SizedBox(height: 24),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: "Create your first token!",
                  style: Theme.of(context).textTheme.headlineSmall,
                  children: [
                    TextSpan(
                      text:
                          '\n\nFirst, take a picture of your token. Next, tap the button below to add it to your collection.',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    TextSpan(
                      text: ' Read more.',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => showMoreInfo(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              isAsync 
                ? const CircularProgressIndicator()
                : FilledButton.icon(
                  icon: const Icon(Icons.add),
                  onPressed: () => _handleAddToken(),
                  label: const Text('Add token'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showMoreInfo(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.info),
        title: const Text('Adding a token'),
        content: const SizedBox(
          width: 400,
          child: Text(
            'A token is stored as a single image, which you can pick from your gallery. '
            'After selecting and cropping the image, it gets added to your collection. '
            'Next, you can write down the story behind the token: who gave it to you, '
            'when, and why. Once you have given the token away again, you can add the '
            'story behind that exchange as well.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
