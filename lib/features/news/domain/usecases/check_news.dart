import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/uttils/params.dart';
import 'package:news_app/core/uttils/usecase.dart';
import 'package:news_app/features/news/domain/repositories/news_repo.dart';

class CheckNews extends UseCase<bool, SaveParam> {
  final NewsRepository newsRepository;

  CheckNews({required this.newsRepository});
  @override
  Future<Either<Failure, bool>> call(SaveParam param) async {
    return await newsRepository.checkNews(param.news);
  }
}
