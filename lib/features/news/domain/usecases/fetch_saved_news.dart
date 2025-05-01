import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/uttils/params.dart';
import 'package:news_app/core/uttils/usecase.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/repositories/news_repo.dart';

class FetchSavedNews implements UseCase<List<NewsEntity>, NoParams> {
  final NewsRepository newsRepository;
  FetchSavedNews({required this.newsRepository});

  @override
  Future<Either<Failure, List<NewsEntity>>> call(NoParams param) async {
    final result = await newsRepository.fetchSavedNews();
    return result.fold((failure) => left(failure), (value) => right(value));
  }
}
