import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DirectoryHelper {
  const DirectoryHelper._();

  static Directory? _cacheDir;
  static Directory? _docDir;

  /// Without trailing slash
  static String get cachPath => _cacheDir?.path ?? '';
  static String get documentPath => _docDir?.path ?? '';

  static Future<void> init() async {
    _cacheDir = await getApplicationCacheDirectory();
    _docDir = await getApplicationDocumentsDirectory();
  }
}
