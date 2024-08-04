import 'package:flutter/material.dart';
import 'package:thank_you_token/models/token_metadata.dart';

class DetailsName extends StatelessWidget {
  const DetailsName(this.info, {super.key});

  final TokenPartialInfo info;

  @override
  Widget build(BuildContext context) {
    final empty = (info.name == null || info.name!.isEmpty);
    if (empty) {
      return info.isFrom ? const Text('Made by you') : const Text('Not yet given');
    } else {
      return Text(info.name!);
    }
  }
}
