import 'package:checklistapp/helper/directory_helper.dart';
import 'package:checklistapp/services/db.dart';

class AppInitializers {
  const AppInitializers._();

  static init() async {
    await DirectoryHelper.init();
    await DB.init();
  }
}
