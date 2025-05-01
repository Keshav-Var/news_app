import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/uttils/params.dart';
import 'package:news_app/core/uttils/usecase.dart';
import 'package:news_app/features/news/domain/repositories/news_repo.dart';

class DeleteNews implements UseCase<bool, DeleteParam> {
  final NewsRepository newsRepository;
  DeleteNews({required this.newsRepository});

  @override
  Future<Either<Failure, bool>> call(DeleteParam param) async {
    final result = await newsRepository.deleteNews(param.id);
    return result.fold((failure) => left(failure), (value) => right(value));
  }
}
