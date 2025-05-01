import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/news/data/models/news_model.dart';

abstract class RemoteDataRepository {
  Future<Either<Failure, List<NewsModel>>> fetcharticles();
  Future<Either<Failure, List<NewsModel>>> fetchToptenNews(String catagory);
  Future<Either<Failure, List<NewsModel>>> fetchByCatagory(String catagory);
}
