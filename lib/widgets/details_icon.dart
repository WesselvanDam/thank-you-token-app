import 'package:flutter/material.dart';
import 'package:thank_you_token/models/token_metadata.dart';
import 'package:thank_you_token/utils/extensions.dart';

class DetailsIcon extends StatelessWidget {
  const DetailsIcon(this.info, {super.key});

  final TokenPartialInfo info;

  @override
  Widget build(BuildContext context) {
    if (info.isFrom) {
      return info.name == null
          ? const Icon(Icons.circle_outlined, color: CustomColors.tytYellow)
          : const Icon(Icons.call_received, color: CustomColors.tytBlue);
    } else {
      return info.name == null
          ? const Icon(Icons.question_mark, color: CustomColors.tytRed)
          : const Icon(Icons.call_made, color: CustomColors.tytGreen);
    }
  }
}
