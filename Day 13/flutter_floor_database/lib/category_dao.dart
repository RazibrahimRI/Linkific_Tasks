import 'package:floor/floor.dart';
import 'category.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM Category ORDER BY category_name ASC')
  Future<List<Category>> findAllCategoriesOnce();

  @Query('SELECT * FROM Category ORDER BY category_name ASC')
  Stream<List<Category>> watchAllCategories();

  @insert
  Future<int> insertCategory(Category category);

  @update
  Future<int> updateCategory(Category category);

  @delete
  Future<int> deleteCategory(Category category);
}