import 'package:dartz/dartz.dart';
import '../../domain/repositories/user_repository.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepositoryImpl implements UserRepository {
  final GoogleSignIn _googleSignIn;

  UserRepositoryImpl(this._googleSignIn);
  @override
  Future<Either<Failure, NoParams>> postLogin() async {
    try {
      print('ggogle auth started..');
      final response = await _googleSignIn.signIn();
      print(response);
      return Right(NoParams());
    } catch (ex) {
      return Left(LoginFailure());
    }
  }
}
