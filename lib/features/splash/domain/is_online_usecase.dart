import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/core/uttils/params.dart';
import 'package:news_app/core/uttils/usecase.dart';

class IsOnlineUsecase implements UseCase<bool, NoParams> {
  final NetworkInfo networkInfo;

  IsOnlineUsecase({required this.networkInfo});
  @override
  Future<Either<Failure, bool>> call(NoParams param) async {
    final result = await networkInfo.isConnected();
    return result.fold((failure) => left(failure), (result) => right(result));
  }
}
