import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/uttils/params.dart';
import 'package:news_app/core/uttils/usecase.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/repositories/news_repo.dart';

class FetchTopTenNews implements UseCase<List<NewsEntity>, CategoryParams> {
  final NewsRepository newsRepository;
  FetchTopTenNews({required this.newsRepository});

  @override
  Future<Either<Failure, List<NewsEntity>>> call(CategoryParams param) async {
    final result = await newsRepository.fetchToptenNews(param.category);
    return result.fold((failure) => left(failure), (value) => right(value));
  }
}
