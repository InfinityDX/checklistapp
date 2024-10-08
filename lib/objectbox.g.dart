// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;

import 'models/entities/todo.entity.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 2882872732570341199),
      name: 'Todo',
      lastPropertyId: const obx_int.IdUid(5, 140991530453188496),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 9057156242718843492),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 3885328361757900816),
            name: 'title',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 712174171201439891),
            name: 'isCompleted',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 580769704256216521),
            name: 'createdDate',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 140991530453188496),
            name: 'isPrioritized',
            type: 1,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
obx.Store openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) {
  return obx.Store(getObjectBoxModel(),
      directory: directory,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(1, 2882872732570341199),
      lastIndexId: const obx_int.IdUid(0, 0),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    Todo: obx_int.EntityDefinition<Todo>(
        model: _entities[0],
        toOneRelations: (Todo object) => [],
        toManyRelations: (Todo object) => {},
        getId: (Todo object) => object.id,
        setId: (Todo object, int id) {
          object.id = id;
        },
        objectToFB: (Todo object, fb.Builder fbb) {
          final titleOffset = fbb.writeString(object.title);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addBool(2, object.isCompleted);
          fbb.addInt64(3, object.createdDate?.millisecondsSinceEpoch);
          fbb.addBool(4, object.isPrioritized);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final createdDateValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 10);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final isCompletedParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 8, false);
          final isPrioritizedParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 12, false);
          final createdDateParam = createdDateValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(createdDateValue);
          final object = Todo(
              id: idParam,
              title: titleParam,
              isCompleted: isCompletedParam,
              isPrioritized: isPrioritizedParam,
              createdDate: createdDateParam);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [Todo] entity fields to define ObjectBox queries.
class Todo_ {
  /// See [Todo.id].
  static final id = obx.QueryIntegerProperty<Todo>(_entities[0].properties[0]);

  /// See [Todo.title].
  static final title =
      obx.QueryStringProperty<Todo>(_entities[0].properties[1]);

  /// See [Todo.isCompleted].
  static final isCompleted =
      obx.QueryBooleanProperty<Todo>(_entities[0].properties[2]);

  /// See [Todo.createdDate].
  static final createdDate =
      obx.QueryDateProperty<Todo>(_entities[0].properties[3]);

  /// See [Todo.isPrioritized].
  static final isPrioritized =
      obx.QueryBooleanProperty<Todo>(_entities[0].properties[4]);
}
