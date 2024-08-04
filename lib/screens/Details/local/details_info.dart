import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:thank_you_token/models/token_metadata.dart';
import 'package:thank_you_token/screens/Details/edit_provider.dart';
import 'package:thank_you_token/widgets/details_icon.dart';
import 'package:thank_you_token/widgets/details_name.dart';

class DetailsInfo extends ConsumerWidget {
  const DetailsInfo(this.info, {super.key});

  final TokenPartialInfo info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(tokenEditProvider.select((value) => value == null))
        ? showInfo(context, ref)
        : editInfo(context, ref);
  }

  Widget showInfo(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: DetailsIcon(info),
          title: DetailsName(info),
          subtitle: (!info.isFrom && info.date == null)
              ? null
              : Text(
                  info.date == null
                      ? 'Not yet given'
                      : DateFormat.yMMMd().format(info.date!),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(info.message ?? 'No description added'),
        )
      ],
    );
  }

  Widget editInfo(BuildContext context, WidgetRef ref) {
    return FocusTraversalGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: DetailsIcon(info),
            title: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                maxLength: 50,
                controller: TextEditingController(text: info.name),
                onChanged: (value) {
                  ref.read(tokenEditProvider.notifier).updateInfo(
                        info.isFrom,
                        (info) => info.copyWith(name: value),
                      );
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  border: InputBorder.none,
                  hintText: 'Name',
                  filled: true,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: OutlinedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: info.date ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      ref.read(tokenEditProvider.notifier).updateInfo(
                            info.isFrom,
                            (info) => info.copyWith(date: date),
                          );
                    }
                  },
                  child: Consumer(builder: (context, ref, child) {
                    return Text(ref.watch(tokenEditProvider.select((value) {
                      final date = (info.isFrom ? value?.fromInfo : value?.toInfo)!.date;
                      return date == null
                            ? 'Select a date'
                            : DateFormat.yMMMd().format(value!.fromInfo.date!);
                    })));
                  }),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                minLines: 1,
                maxLines: 8,
                controller: TextEditingController(text: info.message),
                onChanged: (value) {
                  ref.read(tokenEditProvider.notifier).updateInfo(
                        info.isFrom,
                        (info) => info.copyWith(message: value),
                      );
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: InputBorder.none,
                  hintText: 'Description',
                  filled: true,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
