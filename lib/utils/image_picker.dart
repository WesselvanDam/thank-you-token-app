import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thank_you_token/providers/token_provider.dart';
import 'package:thank_you_token/utils/authorisation_check.dart';

Future<bool?> addTokenSequence(BuildContext context, WidgetRef ref) async {
  return imagePicker(context).then((pickedImage) {
    if (pickedImage == null) return null;

    return imageCropper(context, pickedImage, 16 / 9)
        .then((croppedImage) async {
      if (croppedImage == null) return null;
      if (!(await checkAuthorisation(context) ?? false)) return null;

      return ref.read(tokensProvider.notifier).addToken(pickedImage);
    });
  });
}

/// A utility function that allows the user to pick an image from their gallery.
Future<XFile?> imagePicker(BuildContext context) => ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 2000, maxHeight: 2000)
        .then((image) {
      if (image == null) {
        return null;
      }

      // Check if the image is actually an image on web
      if (image.mimeType?.startsWith('image') != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an image file.'),
          ),
        );
        return null;
      }
      return image;
    });

/// A utility function that allows the user to crop an image on mobile.
Future<XFile?> imageCropper(
  BuildContext context,
  XFile image,
  double? aspectRatio,
) async {
  return ImageCropper().cropImage(
    sourcePath: image.path,
    aspectRatio: aspectRatio == null
        ? null
        : CropAspectRatio(ratioX: aspectRatio, ratioY: 1),
    uiSettings: [
      WebUiSettings(context: context, viewwMode: WebViewMode.mode_1),
    ],
  ).then(
    (croppedFile) => croppedFile == null
        ? null
        : XFile(
            croppedFile.path,
            mimeType: image.mimeType,
          ),
  );
}
