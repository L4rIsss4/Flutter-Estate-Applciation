import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/kisiler_daorepository.dart';


class LoginCubit extends Cubit<String?> {
  LoginCubit() : super(null);

  final AuthRepository _repo = AuthRepository();

  Future<void> login(String email, String sifre) async {
    bool success = await _repo.loginUser(email, sifre);
    if (success) {
      String? role = await _repo.getUserRole(); // "admin" veya "user"
      emit(role);
    } else {
      emit(null);
    }
  }
}

