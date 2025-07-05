import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikn_task/features/auth/domain/usecase/login_usecase.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../core/utils/validators.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final SecureStorage storage;

  AuthCubit({
    required this.loginUseCase,
    required this.storage,
  }) : super(AuthInitial());

  void login({required String username, required String password}) async {
    // Validate
    final usernameError = Validators.validateNotEmpty(username);
    final passwordError = Validators.validateNotEmpty(password);
    if (usernameError != null) {
      emit(AuthFailure(usernameError));
      return;
    }
    if (passwordError != null) {
      emit(AuthFailure(passwordError));
      return;
    }

    emit(AuthLoading());
    final result = await loginUseCase(
      LoginParams(username: username, password: password),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }
}
