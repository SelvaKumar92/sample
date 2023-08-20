abstract class Failure {
  final String? message;
  final String code;
  final String data;

  Failure({this.message = '', this.code = '', this.data = ''});

  @override
  String toString() => message ?? '';
}

class ServerFailure extends Failure {
  ServerFailure({String? message = ''}) : super(message: message);
}

