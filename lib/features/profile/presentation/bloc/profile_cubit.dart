import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikn_task/core/usecase/usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfile;
  final LogoutUseCase logoutUc;

  ProfileCubit({required this.getProfile, required this.logoutUc})
      : super(ProfileInitial());

  void loadProfile() async {
    emit(ProfileLoading());
    final result = await getProfile(NoParams());
    result.fold(
      (f) => emit(ProfileFailure(f.message)),
      (p) => emit(ProfileLoaded(p)),
    );
  }

  void logout() async {
    await logoutUc(NoParams());
    // Navigate back to login
    emit(ProfileInitial());
  }
}
