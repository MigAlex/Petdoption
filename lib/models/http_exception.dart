class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {	//do wypiswania informacji o danym bledzie
    return message;
  }
}