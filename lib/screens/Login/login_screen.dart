import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in_web/web_only.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static const focusFraction = 680 / 1920;
  static const imageAspectRatio = 1920 / 1080;

  double calculateAlignmentX(BoxConstraints constraints, double contentWidth) {
    final width = constraints.maxWidth - contentWidth;
    final height = constraints.maxHeight;

    final imageWidth = height * imageAspectRatio;
    final focusWidth = imageWidth * focusFraction;

    if (focusWidth > (width / 2)) {
      return -1 + ((((2 * focusWidth) - width) / imageWidth));
    } else {
      return -1;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 440;
          double contentWidth = constraints.maxWidth > 800 ? 420 : 300;
          if (isWideScreen) {
            double alignmentX = calculateAlignmentX(constraints, contentWidth);
            return Center(
              child: buildWideScreenLayout(alignmentX, contentWidth),
            );
          }
          return buildColumnLayout();
        },
      ),
    );
  }

  Widget buildColumnLayout() {
    return content();
  }

  Widget buildWideScreenLayout(double alignmentX, double contentWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: SizedBox(
            height: double.infinity,
            child: Image.asset(
              'assets/images/banner.jpg',
              fit: BoxFit.cover,
              alignment: Alignment(alignmentX, 0),
            ).animate().fadeIn(duration: const Duration(milliseconds: 300)),
          ),
        ),
        SizedBox(
          width: contentWidth,
          child: content(),
        ),
      ],
    );
  }

  Widget content() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset('assets/images/logo-colour-sub.png')
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 300)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      'A Thank You Token is a small object with little intrinsic value which you gift to someone after a meaningful interaction, as a way to express your gratitude. Read more at ',
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'thank-you-token.nl',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(
                              Uri.parse('https://www.thank-you-token.nl'));
                        },
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'You can use this app to save the stories behind your tokens. Sign in with your Google account to get started.',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 44,
              child: renderButton(
                configuration: GSIButtonConfiguration(
                  type: GSIButtonType.standard,
                  theme: GSIButtonTheme.filledBlue,
                  size: GSIButtonSize.large,
                  text: GSIButtonText.signinWith,
                  shape: GSIButtonShape.pill,
                  logoAlignment: GSIButtonLogoAlignment.center,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => launchUrl(
                  Uri.parse('https://www.thank-you-token.nl/privacy')),
              child: const Text('Privacy policy'),
            ),
          ],
        ),
      ),
    );
  }
}
