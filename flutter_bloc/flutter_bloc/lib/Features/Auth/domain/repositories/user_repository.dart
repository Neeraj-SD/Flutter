import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

abstract class UserRepository {
  Future<Either<Failure, NoParams>> postLogin();
}
