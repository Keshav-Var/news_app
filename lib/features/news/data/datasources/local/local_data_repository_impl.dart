import 'package:news_app/features/news/data/datasources/local/local_data_repository.dart';
import 'package:news_app/features/news/data/models/news_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataRepositoryImpl implements LocalDataRepository {
  final Database db;
  LocalDataRepositoryImpl({required this.db});
  @override
  Future<bool> deleteNews(int id) async {
    final result = await db.delete(
      'saved_notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result > 0;
  }

  @override
  Future<List<NewsModel>> fectchSavedNews() async {
    final result = await db.query('saved_notes');
    return result.map((news) => NewsModel.fromJson(news)).toList();
  }

  @override
  Future<bool> saveNews(NewsModel news) async {
    await db.insert('saved_notes', news.toJson());
    return true;
  }

  @override
  Future<bool> checkNews(NewsModel news) async {
    String url = news.url ?? "";
    final result = await db.query(
      'saved_notes',
      where: 'url = ?',
      whereArgs: [url],
    );

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
