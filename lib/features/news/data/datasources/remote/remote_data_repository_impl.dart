import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/network/client_api.dart';
import 'package:news_app/features/news/data/datasources/remote/remote_data_repository.dart';
import 'package:news_app/features/news/data/models/news_model.dart';

class RemoteDataRepositoryImpl implements RemoteDataRepository {
  final ClientApi clientApi;
  RemoteDataRepositoryImpl({required this.clientApi});
  @override
  Future<Either<Failure, List<NewsModel>>> fetchByCatagory(
    String catagory,
  ) async {
    final response = await clientApi.get(
      "top-headlines",
      queryParams: {"country": "us", "category": catagory},
    );
    // print("response get it : \n" + response.toString());
    return response.fold((failure) => left(failure), (data) {
      return right(
        (data["articles"] as List)
            .map((article) => NewsModel.fromJson(article))
            .toList(),
      );
    });
  }

  @override
  Future<Either<Failure, List<NewsModel>>> fetchToptenNews(
    String catagory,
  ) async {
    final response = await clientApi.get(
      "top-headlines",
      queryParams: {"country": "us", "pageSize": 5, "category": catagory},
    );
    // print("response get it : \n" + response.toString());
    return response.fold((failure) => left(failure), (data) {
      return right(
        (data["articles"] as List)
            .map((article) => NewsModel.fromJson(article))
            .toList(),
      );
    });
  }

  @override
  Future<Either<Failure, List<NewsModel>>> fetcharticles() async {
    final response = await clientApi.get(
      "everything",
      queryParams: {"q": "general", "language": "en"},
    );
    // print("response get it : \n" + response.toString());
    return response.fold((failure) => left(failure), (data) {
      return right(
        (data["articles"] as List)
            .map((article) => NewsModel.fromJson(article))
            .toList(),
      );
    });
  }
}
