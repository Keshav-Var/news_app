import 'package:flutter/material.dart';
import 'package:news_app/core/uttils/params.dart';
import 'package:news_app/features/splash/domain/is_online_usecase.dart';

enum SplashStatus { initial, loading, online, offline }

class SplashProvider with ChangeNotifier {
  final IsOnlineUsecase isOnlineUsecase;
  SplashStatus _status = SplashStatus.initial;

  SplashProvider({required this.isOnlineUsecase});

  SplashStatus get status => _status;

  Future<void> checkConnection() async {
    _status = SplashStatus.loading;
    notifyListeners();

    final connectivity = await isOnlineUsecase.call(NoParams());
    _status =
        connectivity.fold(
              (failure) => throw Exception("Unexpected error"),
              (result) => result,
            )
            ? SplashStatus.online
            : SplashStatus.offline;

    notifyListeners();
  }
}
