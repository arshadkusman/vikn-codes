abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.msg);
}

class CacheFailure extends Failure {
  CacheFailure(super.msg);
}
