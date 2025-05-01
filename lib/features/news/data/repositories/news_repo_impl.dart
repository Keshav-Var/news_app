import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/exception.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/news/data/datasources/local/local_data_repository.dart';
import 'package:news_app/features/news/data/datasources/remote/remote_data_repository.dart';
import 'package:news_app/features/news/data/models/news_model.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/repositories/news_repo.dart';

class NewsRepoImpl implements NewsRepository {
  final LocalDataRepository localDataRepository;
  final RemoteDataRepository remoteDataRepository;

  NewsRepoImpl({
    required this.localDataRepository,
    required this.remoteDataRepository,
  });

  @override
  Future<Either<Failure, bool>> deleteNews(int id) async {
    try {
      return right(await localDataRepository.deleteNews(id));
    } on ChacheException {
      return left(ChacheFailure("Chache Failure."));
    } catch (e) {
      return left(ChacheFailure("Chache Exception."));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> fetchSavedNews() async {
    try {
      final newsModelList = await localDataRepository.fectchSavedNews();
      List<NewsEntity> news =
          newsModelList.map((model) => model.toEntity()).toList();
      return right(news);
    } on ChacheException {
      return left(ChacheFailure("Chache Failure."));
    } catch (e) {
      // print(e.toString());
      return left(ChacheFailure("Chache Exception."));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> fetchToptenNews(
    String catagory,
  ) async {
    final result = await remoteDataRepository.fetchToptenNews(catagory);
    return result.fold(
      (failure) => left(failure),
      (newsModelList) =>
          right(newsModelList.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> fetcharticles() async {
    final result = await remoteDataRepository.fetcharticles();
    return result.fold(
      (failure) => left(failure),
      (newsModelList) =>
          right(newsModelList.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, bool>> saveNews(NewsEntity news) async {
    try {
      return right(
        await localDataRepository.saveNews(NewsModel.fromEntity(news)),
      );
    } on ChacheException {
      return left(ChacheFailure("Chache Failure."));
    } catch (e) {
      return left(ChacheFailure("Chache Exception."));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> fetchByCatagory(
    String catagory,
  ) async {
    final result = await remoteDataRepository.fetchByCatagory(catagory);
    return result.fold(
      (failure) => left(failure),
      (newsModelList) =>
          right(newsModelList.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, bool>> checkNews(NewsEntity news) async {
    try {
      return right(
        await localDataRepository.checkNews(NewsModel.fromEntity(news)),
      );
    } on ChacheException {
      return left(ChacheFailure("Chache Failure."));
    } catch (e) {
      return left(ChacheFailure("Chache Exception."));
    }
  }
}
