class Category {
  final int? id;
  final String name;
  Category({this.id, required this.name});

  Map<String, dynamic> toMap() => {if (id != null) 'id': id, 'name': name};

  factory Category.fromMap(Map<String, dynamic> map) =>
      Category(id: map['id'] as int?, name: map['name'] as String);
}

class Note {
  final int? id;
  final String title;
  final String content;
  final int? categoryId;
  final String createdAt;
  final String? categoryName; // only set when read via JOIN

  Note({
    this.id,
    required this.title,
    required this.content,
    this.categoryId,
    required this.createdAt,
    this.categoryName,
  });

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'title': title,
    'content': content,
    'category_id': categoryId,
    'created_at': createdAt,
  };

  factory Note.fromMap(Map<String, dynamic> map) => Note(
    id: map['id'] as int?,
    title: map['title'] as String,
    content: map['content'] as String,
    categoryId: map['category_id'] as int?,
    createdAt: map['created_at'] as String,
  );

  factory Note.fromJoinedMap(Map<String, dynamic> map) => Note(
    id: map['id'] as int?,
    title: map['title'] as String,
    content: map['content'] as String,
    categoryId: map['category_id'] as int?,
    createdAt: map['created_at'] as String,
    categoryName: map['category_name'] as String?,
  );

  Note copyWith({String? title, String? content, int? categoryId}) => Note(
    id: id,
    title: title ?? this.title,
    content: content ?? this.content,
    categoryId: categoryId ?? this.categoryId,
    createdAt: createdAt,
  );
}
