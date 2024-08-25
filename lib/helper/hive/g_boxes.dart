import "package:checklistapp/helper/hive/general_storage.dart";
import "package:hive_flutter/hive_flutter.dart";

class GBoxes {
  GBoxes._();

  static Future<void> initialize() async {
    await Hive.initFlutter();
    _registerAdapters();
    await _openBoxes();
  }

  static void _registerAdapters() {}

  static Future<void> _openBoxes() async {
    await Hive.openBox(GeneralStorage.name);
  }

  static Future<void> dispose() async {}
}
