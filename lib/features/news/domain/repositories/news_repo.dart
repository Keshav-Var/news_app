import 'package:dartz/dartz.dart';

import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsEntity>>> fetcharticles();
  Future<Either<Failure, List<NewsEntity>>> fetchSavedNews();
  Future<Either<Failure, List<NewsEntity>>> fetchToptenNews(String catagory);
  Future<Either<Failure, List<NewsEntity>>> fetchByCatagory(String catagory);
  Future<Either<Failure, bool>> saveNews(NewsEntity news);
  Future<Either<Failure, bool>> deleteNews(int id);
  Future<Either<Failure, bool>> checkNews(NewsEntity news);
}
