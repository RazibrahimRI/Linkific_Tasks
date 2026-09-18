import 'package:floor/floor.dart';

@entity
class Category {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'category_name')
  final String name;

  Category({this.id, required this.name});

  Category copyWith({int? id, String? name}) {
    return Category(id: id ?? this.id, name: name ?? this.name);
  }
}