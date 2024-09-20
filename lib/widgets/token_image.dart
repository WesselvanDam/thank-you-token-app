import 'package:flutter/material.dart';
import 'package:thank_you_token/models/token.dart';

class TokenImage extends StatelessWidget {
  const TokenImage(this.token, {super.key, this.borderRadius = 12});

  final Token token;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
      ),
      child: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        width: double.infinity,
        child: Image.network(token.thumbnailLink.replaceAll('=s220', '=s720'),
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                wasSynchronouslyLoaded
                    ? child
                    : AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                        child: child,
                      ),
            gaplessPlayback: true,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Center(
                  child: Image.asset(
                    'assets/images/glyph_white.png',
                    width: 80,
                    height: 80,
                    color: Theme.of(context)
                        .colorScheme
                        .onErrorContainer
                        .withOpacity(0.2),
                  ),
                )),
      ),
    );
  }
}
