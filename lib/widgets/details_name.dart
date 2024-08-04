import 'package:flutter/material.dart';
import 'package:thank_you_token/models/token_metadata.dart';

class DetailsName extends StatelessWidget {
  const DetailsName(this.info, {super.key});

  final TokenPartialInfo info;

  @override
  Widget build(BuildContext context) {
    if (info.isFrom) {
      return info.name == null ? const Text('Made by you') : Text(info.name!);
    } else {
      return info.name == null ? const Text('Not yet given') : Text(info.name!);
    }
  }
}
