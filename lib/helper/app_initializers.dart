import 'package:checklistapp/helper/directory_helper.dart';
import 'package:checklistapp/helper/hive/g_boxes.dart';
import 'package:checklistapp/services/db.dart';

class AppInitializers {
  const AppInitializers._();

  static Future<void> init() async {
    await DirectoryHelper.init();
    await DB.init();
    await GBoxes.initialize();
  }
}
