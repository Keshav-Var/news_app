import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/uttils/params.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/usecases/fetch_articles.dart';
import 'package:news_app/features/news/domain/usecases/fetch_by_catagory.dart';
import 'package:news_app/features/news/domain/usecases/fetch_top_ten_news.dart';

class HomeScreenProvider extends ChangeNotifier {
  final FetchArticles fetchArticles;
  final FetchByCatagory fetchByCatagory;
  final FetchTopTenNews fetchTopTenNews;

  int _selectedTab = 0;
  bool _isLoading = false;
  List<NewsEntity> _topHeadlines = [];
  List<NewsEntity> _newList = [];
  String? _errorMessage;

  HomeScreenProvider({
    required this.fetchArticles,
    required this.fetchByCatagory,
    required this.fetchTopTenNews,
  });

  int get selectedTab => _selectedTab;
  bool get isLoading => _isLoading;
  List<NewsEntity> get topHeadlines => _topHeadlines;
  List<NewsEntity> get newsList => _newList;
  String? get errorMessage => _errorMessage;

  void onTabChanged(int index, String category) {
    _selectedTab = index;
    fetchNewsByCategory(category);
    notifyListeners();
  }

  Future<void> fetchTopHeadlines(String category) async {
    _setLoading(true);
    // print("started");
    final result = await fetchTopTenNews(CategoryParams(category));
    // print("end");
    _handleResult(result, isTopHeadlines: true);
  }

  Future<void> fetchAllArticles() async {
    _setLoading(true);
    // print("start");
    final result = await fetchArticles(NoParams());
    // print("end");
    _handleResult(result);
  }

  Future<void> fetchNewsByCategory(String category) async {
    _setLoading(true);
    // print("start");
    final result = await fetchByCatagory(CategoryParams(category));
    // print("end");
    _handleResult(result);
  }

  void _handleResult(
    Either<Failure, List<NewsEntity>> result, {
    bool isTopHeadlines = false,
  }) {
    result.fold(
      (failure) {
        // print("error in fecting data");
        _errorMessage = failure.message;
        if (isTopHeadlines) {
          _topHeadlines = [];
        } else {
          _newList = [];
        }
      },
      (data) {
        _errorMessage = null;
        if (isTopHeadlines) {
          // print("headlines fetched");
          _topHeadlines = data;
        } else {
          // print("news fetched");
          _newList = data;
        }
      },
    );
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
