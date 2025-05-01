import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/uttils/constants.dart';

class ClientApi {
  final Dio dio;
  ClientApi({required String baseUrl})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'x-api-key': apiKey, 'Content-Type': 'application/json'},
        ),
      );

  Future<Either<Failure, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure("Unexpected Error: $e"));
    }
  }

  Future<Either<Failure, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final Response response = await dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return right(response.data);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Unexpected Error $e"));
    }
  }

  Failure _handleDioError(DioException error) {
    // print("❌ Dio Error Caught:");
    // print("Type: ${error.type}");
    // print("Message: ${error.message}");
    // print("Status Code: ${error.response?.statusCode}");
    // print("Response Data: ${error.response?.data}");

    if (error.type == DioExceptionType.connectionTimeout) {
      return ServerFailure("Connection timeout");
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return ServerFailure("Receive timeout");
    } else if (error.type == DioExceptionType.badResponse) {
      return ServerFailure(
        "Server error: ${error.response?.statusCode} ${error.response?.statusMessage}",
      );
    } else {
      return ServerFailure("Unexpected Dio error: ${error.message}");
    }
  }
}
