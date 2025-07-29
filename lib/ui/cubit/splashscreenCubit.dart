import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/kisiler_daorepository.dart';

abstract class SplashScreenState{}

class SplashScreenInitial extends SplashScreenState{}

class SplashScreenLoaded extends SplashScreenState{
  final String rol;
  SplashScreenLoaded(this.rol);
}

class SplashScreenFailed extends SplashScreenState{}
class SplashScreenCubit extends Cubit<SplashScreenState> {

  SplashScreenCubit() : super(SplashScreenInitial());

  final _splashScreenRepo = AuthRepository();

  Future<void> kullaniciRolGetir(String email) async {
    try {
      final rol = await _splashScreenRepo.SplashScreenDatas(email);
      emit(SplashScreenLoaded(rol));
    } catch (e) {
      print("Hata Tespit Edildi : $e");
      emit(SplashScreenFailed());
    }
  }
}
