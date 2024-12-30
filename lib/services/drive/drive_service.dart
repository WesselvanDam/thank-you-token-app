import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;
import 'package:image_picker/image_picker.dart';
import 'package:thank_you_token/models/token.dart';

final scopes = [
  'https://www.googleapis.com/auth/userinfo.profile',
  DriveApi.driveAppdataScope
];
const fields = 'id, name, description, properties, thumbnailLink, createdTime';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId:
      '261520608365-72hv2nusnvam645c2dqp4gd8ti1fs7vi.apps.googleusercontent.com',
  scopes: scopes,
);

class DriveServiceApi {
  DriveServiceApi();

  Future<GoogleSignInAccount?> signInSilently() async {
    return _googleSignIn.signInSilently();
  }

  Future<GoogleSignInAccount?> signOut() async {
    return _googleSignIn.disconnect();
  }

  Stream<GoogleSignInAccount?> onCurrentUserChanged() {
    return _googleSignIn.onCurrentUserChanged;
  }

  Future<bool> isAppAuthorised() async {
    return _googleSignIn
        .canAccessScopes(scopes)
        .then((isAuthorised) => isAuthorised)
        .catchError((error) => false);
  }

  Future<bool> requestAuthorisation() async {
    return _googleSignIn
        .requestScopes(scopes)
        .then((isAuthorisedNow) => isAuthorisedNow)
        .catchError((_) => false);
  }

  Future<auth.AuthClient> getClient() async {
    final client = await _googleSignIn.authenticatedClient();
    if (client == null) {
      throw Exception('Client is null');
    }
    return client;
  }

  Future<List<Token>> fetchTokens() async {
    final client = await getClient();
    final api = DriveApi(client);

    final files = await api.files.list(
      spaces: 'appDataFolder',
      $fields: 'files($fields)',
    );
    return files.files!.map((file) => Token.fromFile(file)).toList();
  }

  Future<Token> _fetchToken({String? id, String? name}) async {
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
      return Token.fromFile(file);
    }).catchError((error) {
      debugPrint("Error: $error");
      return _fetchToken(name: name);
    });
  }

  Future<Token> updateToken(Token token) async {
    final client = await getClient();
    final api = DriveApi(client);
    final file = File();
    file.properties = token.propertiesToJson();
    file.description = token.encodeDescription();
    return api.files.update(file, token.id, $fields: fields).then((file) {
      return Token.fromFile(file);
    }).catchError((error) {
      debugPrint("Error: $error");
      return _fetchToken(id: token.id);
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
