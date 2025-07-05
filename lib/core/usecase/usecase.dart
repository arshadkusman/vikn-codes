import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// [Params] is a holder for method arguments; use `NoParams` if none.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
