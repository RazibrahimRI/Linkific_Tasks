import 'dart:async';
import 'package:floor/floor.dart';

import 'note.dart';
import 'category.dart';
import 'note_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'category_dao.dart';

part 'app_database.g.dart';

final migration1to2 = Migration(1, 2, (database) async {
  await database.execute(
    'CREATE TABLE IF NOT EXISTS `Category` '
        '(`id` INTEGER PRIMARY KEY AUTOINCREMENT, `category_name` TEXT NOT NULL)',
  );
  await database.execute('ALTER TABLE `note` ADD COLUMN `category_id` INTEGER');
  await database.execute(
    'CREATE INDEX IF NOT EXISTS `index_note_category_id` ON `note` (`category_id`)',
  );
});

@Database(version: 2, entities: [Note, Category])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;
  CategoryDao get categoryDao;
}