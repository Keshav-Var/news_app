import 'package:flutter/material.dart';
import 'package:news_app/core/uttils/params.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/usecases/delete_news.dart';
import 'package:news_app/features/news/domain/usecases/fetch_saved_news.dart';

class SavedNewsScreenProvider extends ChangeNotifier {
  String _error = "";
  bool _isLoading = true;
  bool _isError = false;
  final FetchSavedNews fetchSavedNews;
  final DeleteNews deleteNews;

  SavedNewsScreenProvider({
    required this.fetchSavedNews,
    required this.deleteNews,
  });

  List<NewsEntity>? _savedNews;
  List<NewsEntity>? get savedNews => _savedNews;
  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get error => _error;

  void fetch() async {
    _isLoading = true;
    _isError = false;
    notifyListeners();
    final result = await fetchSavedNews.call(NoParams());
    result.fold(
      (failure) {
        _isError = true;
        _error = failure.message;
      },
      (result) {
        _savedNews = result;
      },
    );
    _isLoading = false;
    notifyListeners();
  }

  Future<void> delete(int id) async {
    _isLoading = true;
    notifyListeners();

    final result = await deleteNews.call(DeleteParam(id));
    result.fold(
      (failure) {
        _isError = true;
        _error = failure.message;
      },
      (_) {
        _savedNews?.removeWhere((item) => item.id == id);
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
