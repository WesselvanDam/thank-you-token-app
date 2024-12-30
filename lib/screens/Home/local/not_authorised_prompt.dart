import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thank_you_token/providers/token_provider.dart';
import 'package:thank_you_token/services/drive/drive_service.dart';

class NotAuthorisedPrompt extends ConsumerWidget {
  const NotAuthorisedPrompt({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset(
              'assets/images/app_illustration.png',
              height: 810 * (400 / 1080),
              width: 400,
            ),
            const SizedBox(height: 24),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: "Connect to Drive",
                style: Theme.of(context).textTheme.headlineSmall,
                children: [
                  TextSpan(
                    text:
                        '\n\nConnect this app to Google Drive to give it access to your tokens. '
                        'You will have to do this every time you use the app.',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  TextSpan(
                    text: ' Read more.',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => showMoreInfo(context, ref),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              icon: const Icon(Icons.lock_open),
              onPressed: () => DriveServiceApi().requestAuthorisation().then(
                  (isAuthorised) =>
                      isAuthorised ? ref.invalidate(tokensProvider) : null),
              label: const Text('Authorise'),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> showMoreInfo(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.info),
          title: const Text('Authorisation'),
          content: const SizedBox(
            width: 400,
            child: Text(
              'The Thank You Token App stores tokens in your own Google Drive. '
              'This way, you can access your tokens from any device, while keeping '
              'them private. The app only has access to the folder it creates in '
              'your Drive. You can revoke access at any time in your Google Account settings.'
              '\n\nDue to the way Google handles authorisation, you have to give the app '
              'access to your Drive every time you use the app.'
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
