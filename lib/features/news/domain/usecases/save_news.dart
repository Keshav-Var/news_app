import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/uttils/params.dart';
import 'package:news_app/core/uttils/usecase.dart';
import 'package:news_app/features/news/domain/repositories/news_repo.dart';

class SaveNews implements UseCase<bool, SaveParam> {
  final NewsRepository newsRepository;

  SaveNews({required this.newsRepository});

  @override
  Future<Either<Failure, bool>> call(SaveParam param) async {
    final result = await newsRepository.saveNews(param.news);
    return result.fold((failure) => left(failure), (value) => right(value));
  }
}
