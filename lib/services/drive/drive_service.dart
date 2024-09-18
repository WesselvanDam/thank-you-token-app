import 'package:flutter/foundation.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;
import 'package:image_picker/image_picker.dart';
import 'package:thank_you_token/models/token.dart';
import 'package:thank_you_token/services/auth/auth_service.dart';

final scopes = [DriveApi.driveAppdataScope];
const fields = 'id, name, description, properties, thumbnailLink, createdTime';

class DriveServiceApi {
  DriveServiceApi();

  Future<bool> isAppAuthorised() async {
    final isAuthorised = await googleSignIn.canAccessScopes(scopes);
    if (isAuthorised) return true;
    return googleSignIn.requestScopes(scopes).then((isAuthorisedNow) {
      debugPrint("Request result: $isAuthorisedNow");
      return isAuthorisedNow;
    });
  }

  Future<auth.AuthClient> getClient() async {
    final client = await googleSignIn.authenticatedClient();
    if (client == null) {
      throw Exception('Client is null');
    }
    return client;
  }

  Future<List<Token>> fetchTokens() async {
    final isAuthorised = await isAppAuthorised();
    debugPrint("Is Authorised now: $isAuthorised");
    if (!isAuthorised) {
      throw Exception(
          'You have not authorised the app to access your Google Drive');
    }

    final client = await getClient();
    final api = DriveApi(client);

    final files = await api.files.list(
      spaces: 'appDataFolder',
      $fields: 'files($fields)',
    );
    final accessToken = client.credentials.accessToken.data;
    return files.files!
        .map((file) => Token.fromFile(file, accessToken: accessToken))
        .toList();
  }

  Future<Token> fetchToken({String? id, String? name}) async {
    final client = await getClient();
    final api = DriveApi(client);
    if (id != null) {
      final File file = await api.files.get(id, $fields: fields) as File;
      return Token.fromFile(file);
    }
    final files = await api.files.list(
      spaces: 'appDataFolder',
      q: "name = '$name'",
      $fields: 'files($fields)',
    );
    if (files.files!.isEmpty) {
      throw Exception('Token not found');
    }
    return Token.fromFile(files.files!.first);
  }

  Future<Token> addToken(XFile image) async {
    final client = await getClient();
    final api = DriveApi(client);
    debugPrint("Mime Type: ${image.mimeType}");
    final name = '${DateTime.now().millisecondsSinceEpoch}';
    return api.files
        .create(
      File(
        name: name,
        parents: ['appDataFolder'],
        mimeType: image.mimeType!,
      ),
      $fields: fields,
      uploadMedia: Media(image.openRead(), null, contentType: image.mimeType!),
      uploadOptions: ResumableUploadOptions(),
    )
        .then((file) {
      debugPrint("Upload success: $file");
      return Token.fromFile(file);
    }).catchError((error) {
      debugPrint("Error: $error");
      return fetchToken(name: name);
    });
  }

  Future<Token> updateToken(Token token) async {
    final client = await getClient();
    final api = DriveApi(client);
    final file = File();
    file.properties = token.propertiesToJson();
    file.description = token.encodeDescription();
    debugPrint("File properties: ${file.properties}");
    return api.files.update(file, token.id, $fields: fields).then((file) {
      debugPrint("Updated File: $file");
      return Token.fromFile(file);
    }).catchError((error) {
      debugPrint("Error: $error");
      return fetchToken(id: token.id);
    });
  }

  Future<bool> deleteToken(Token token) async {
    final client = await getClient();
    final api = DriveApi(client);
    return api.files
        .delete(token.id)
        .then((_) => true)
        .catchError((_) => false);
  }
}
