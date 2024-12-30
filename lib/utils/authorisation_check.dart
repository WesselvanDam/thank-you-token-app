import 'package:flutter/material.dart';
import 'package:thank_you_token/services/drive/drive_service.dart';

Future<bool?> checkAuthorisation(BuildContext context) async {
  return DriveServiceApi().isAppAuthorised().then(
    (isAuthorised) {
      if (isAuthorised) return true;
      return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SizedBox(
            width: 400,
            child: AlertDialog(
              title: const Text('Reconnect to Drive'),
              content: const Text(
                'Your connection to Google Drive has expired. Please reconnect to continue.'
                '\n\nGoogle Drive requires apps to have users reconnect periodically for security reasons.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => DriveServiceApi().requestAuthorisation().then(
                    (isAuthorised) => Navigator.of(context).pop(isAuthorised),
                  ),
                  child: const Text('Reconnect'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
