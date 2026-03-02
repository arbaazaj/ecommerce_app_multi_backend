class ServerException implements Exception {
  final String message;
  const ServerException([this.message = "A server error occurred"]);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = "A cache error occurred"]);

  @override
  String toString() => message;
}
