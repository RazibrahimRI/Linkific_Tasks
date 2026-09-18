import 'package:floor/floor.dart';
import 'category.dart';

@Entity(
  tableName: 'note',
  foreignKeys: [
    ForeignKey(
      childColumns: ['category_id'],
      parentColumns: ['id'],
      entity: Category,
      onDelete: ForeignKeyAction.setNull, // matches sqflite version
    ),
  ],
  indices: [Index(value: ['category_id'])],
)
class Note {
  @PrimaryKey(autoGenerate: true) // bare @primaryKey does NOT autoincrement
  final int? id;

  @ColumnInfo(name: 'title')
  final String title;

  @ColumnInfo(name: 'content')
  final String content;

  @ColumnInfo(name: 'category_id')
  final int? categoryId;

  @ColumnInfo(name: 'created_at')
  final int createdAt;

  Note({
    this.id,
    required this.title,
    required this.content,
    this.categoryId,
    required this.createdAt,
  });

  Note copyWith({int? id, String? title, String? content, int? categoryId, int? createdAt}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}