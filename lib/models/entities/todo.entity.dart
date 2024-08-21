import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {
  @Id()
  int id;
  String title;
  bool isCompleted;
  bool isPrioritized;
  @PropertyType(type: PropertyType.date)
  DateTime? createdDate;

  Todo({
    this.id = 0,
    this.title = '',
    this.isCompleted = false,
    this.isPrioritized = false,
    this.createdDate,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.id == id &&
        other.title == title &&
        other.isCompleted == isCompleted &&
        other.isPrioritized == isPrioritized &&
        other.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        isCompleted.hashCode ^
        isPrioritized.hashCode ^
        createdDate.hashCode;
  }
}
