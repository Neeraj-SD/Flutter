import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecase/post_login.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final PostLogin postLogin;
  AuthCubit({required this.postLogin}) : super(AuthInitial());

  Future<void> login() async {
    emit(Loading());
    final response = await postLogin(NoParams());
    response.fold((failure) => print(failure), (_) => emit(Authenticated()));
    emit(Authenticated());
  }
}
