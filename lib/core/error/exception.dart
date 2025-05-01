class ServerException implements Exception {}

class ChacheException implements Exception {}

class NoInternetExpection implements Exception {
  final String message;
  NoInternetExpection({this.message = "No Internet Connection."});
}
