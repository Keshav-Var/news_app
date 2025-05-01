import 'package:news_app/features/news/data/models/news_model.dart';

abstract class LocalDataRepository {
  Future<List<NewsModel>> fectchSavedNews();
  Future<bool> deleteNews(int id);
  Future<bool> saveNews(NewsModel news);
  Future<bool> checkNews(NewsModel news);
}
