import 'package:checklistapp/helper/directory_helper.dart';
import 'package:checklistapp/models/entities/todo.entity.dart';
import 'package:checklistapp/objectbox.g.dart';

class DB {
  const DB._();
  static const _objBoxFolderName = 'dbbox';
  static Store? _store;
  static Store? get store => _store;

  //Boxes
  static Box<Todo>? _todoBox;
  static Box<Todo> get todoBox => _todoBox != null
      ? _todoBox!
      : throw Exception('_userBox is not assigned');

  static init() async {
    _store = openStore(
      directory: '${DirectoryHelper.documentPath}/$_objBoxFolderName',
    );
    _todoBox = store!.box<Todo>();
  }
}
