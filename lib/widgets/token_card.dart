import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thank_you_token/models/token.dart';
import 'package:thank_you_token/models/token_metadata.dart';
import 'package:thank_you_token/services/router/routes.dart';
import 'package:thank_you_token/widgets/details_icon.dart';
import 'package:thank_you_token/widgets/details_name.dart';
import 'package:thank_you_token/widgets/token_image.dart';

class TokenCard extends ConsumerWidget {
  const TokenCard({super.key, required this.token});

  final Token token;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => TokenDetailsRoute(id: token.name).go(context),
      child: Card(
        elevation: 8,
        child: Column(
          children: [
            Expanded(child: TokenImage(token)),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CardInfo(token.fromInfo),
                  ),
                  Expanded(
                    child: CardInfo(token.toInfo),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  const CardInfo(this.info, {super.key});

  final TokenPartialInfo info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetailsIcon(info),
        DetailsName(info),
        if (info.date != null)
          Text(
            DateFormat.yMMMd().format(info.date!),
            style: Theme.of(context).textTheme.labelSmall,
          )
      ],
    );
  }
}
