import "package:hive_flutter/hive_flutter.dart";

class GeneralStorage {
  GeneralStorage._();
  static const String name = 'appStorage';

  //method for general storage
  static Box<dynamic> hiveBox = Hive.box(name);

  static Future<void> put(String key, dynamic value) async {
    await hiveBox.put(key, value);
  }

  static T get<T>(String key, {T? defaultValue}) {
    return hiveBox.get(key, defaultValue: defaultValue) as T;
  }

  static Future<void> delete(String key) async {
    await hiveBox.delete(key);
  }

  static Future<void> clear() async {
    await hiveBox.clear();
  }
}
