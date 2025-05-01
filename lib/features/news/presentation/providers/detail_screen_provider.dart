import 'package:flutter/material.dart';
import 'package:news_app/core/uttils/params.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/usecases/check_news.dart';
import 'package:news_app/features/news/domain/usecases/save_news.dart';

class DetailScreenProvider extends ChangeNotifier {
  final SaveNews saveNews;
  final CheckNews checkNews;

  bool _isSaved = false;
  bool get isSaved => _isSaved;

  DetailScreenProvider({required this.saveNews, required this.checkNews});

  Future<void> checkIfNewsSaved(NewsEntity news) async {
    final result = await checkNews.call(SaveParam(news: news));
    result.fold(
      (failure) => _isSaved = false,
      (isSavedResult) => _isSaved = isSavedResult,
    );
    notifyListeners();
  }

  Future<void> toggleSaveNews(NewsEntity news) async {
    if (_isSaved) return;
    final result = await saveNews.call(SaveParam(news: news));
    result.fold((failure) => null, (isSavedResult) => _isSaved = isSavedResult);
    notifyListeners();
  }
}
