import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/uttils/params.dart';
import 'package:news_app/core/uttils/usecase.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/repositories/news_repo.dart';

class FetchArticles implements UseCase<List<NewsEntity>, NoParams> {
  final NewsRepository newsRepository;
  FetchArticles({required this.newsRepository});

  @override
  Future<Either<Failure, List<NewsEntity>>> call(NoParams param) async {
    final result = await newsRepository.fetcharticles();
    return result.fold((failure) => left(failure), (value) => right(value));
  }
}
