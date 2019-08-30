class HttpException implements Exception {
  final String someMessage;

  HttpException(this.someMessage);

  @override
  String toString() {
    return someMessage;   //do wypiswania informacji o danym bledzie
  }
}