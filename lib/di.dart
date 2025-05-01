import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/local_database/local_database.dart';
import 'package:news_app/core/network/client_api.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/core/uttils/constants.dart';
import 'package:news_app/features/news/data/datasources/local/local_data_repository.dart';
import 'package:news_app/features/news/data/datasources/local/local_data_repository_impl.dart';
import 'package:news_app/features/news/data/datasources/remote/remote_data_repository.dart';
import 'package:news_app/features/news/data/datasources/remote/remote_data_repository_impl.dart';
import 'package:news_app/features/news/data/repositories/news_repo_impl.dart';
import 'package:news_app/features/news/domain/repositories/news_repo.dart';
import 'package:news_app/features/news/domain/usecases/check_news.dart';
import 'package:news_app/features/news/domain/usecases/delete_news.dart';
import 'package:news_app/features/news/domain/usecases/fetch_articles.dart';
import 'package:news_app/features/news/domain/usecases/fetch_by_catagory.dart';
import 'package:news_app/features/news/domain/usecases/fetch_saved_news.dart';
import 'package:news_app/features/news/domain/usecases/fetch_top_ten_news.dart';
import 'package:news_app/features/news/domain/usecases/save_news.dart';
import 'package:news_app/features/news/presentation/providers/detail_screen_provider.dart';
import 'package:news_app/features/news/presentation/providers/home_screen_provider.dart';
import 'package:news_app/features/news/presentation/providers/saved_news_screen_provider.dart';
import 'package:news_app/features/splash/domain/is_online_usecase.dart';
import 'package:news_app/features/splash/presentation/providers/splash_provider.dart';
import 'package:news_app/skeleton/bottom_navigation_provider.dart';
import 'package:sqflite/sqflite.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //providers
  sl.registerFactory(
    () => DetailScreenProvider(saveNews: sl.call(), checkNews: sl.call()),
  );
  sl.registerFactory(
    () => SavedNewsScreenProvider(
      fetchSavedNews: sl.call(),
      deleteNews: sl.call(),
    ),
  );
  sl.registerFactory(
    () => HomeScreenProvider(
      fetchArticles: sl.call(),
      fetchByCatagory: sl.call(),
      fetchTopTenNews: sl.call(),
    ),
  );
  sl.registerFactory(() => BottomNavigationProvider());
  sl.registerFactory(() => SplashProvider(isOnlineUsecase: sl.call()));

  //usecases
  sl.registerLazySingleton(() => CheckNews(newsRepository: sl.call()));
  sl.registerLazySingleton(() => IsOnlineUsecase(networkInfo: sl.call()));
  sl.registerLazySingleton(() => DeleteNews(newsRepository: sl.call()));
  sl.registerLazySingleton(() => FetchArticles(newsRepository: sl.call()));
  sl.registerLazySingleton(() => FetchByCatagory(newsRepository: sl.call()));
  sl.registerLazySingleton(() => FetchSavedNews(newsRepository: sl.call()));
  sl.registerLazySingleton(() => FetchTopTenNews(newsRepository: sl.call()));
  sl.registerLazySingleton(() => SaveNews(newsRepository: sl.call()));

  //repository
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepoImpl(
      localDataRepository: sl.call(),
      remoteDataRepository: sl.call(),
    ),
  );

  //datasource repository
  sl.registerLazySingleton<LocalDataRepository>(
    () => LocalDataRepositoryImpl(db: sl.call()),
  );
  sl.registerLazySingleton<RemoteDataRepository>(
    () => RemoteDataRepositoryImpl(clientApi: sl.call()),
  );

  //core
  final Database localDB = await LocalDatabase.instance.database;
  sl.registerLazySingleton(() => localDB);
  sl.registerLazySingleton(() => ClientApi(baseUrl: baseUrl));
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: Connectivity()),
  );
}
