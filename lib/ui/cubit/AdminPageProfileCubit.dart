import 'package:emlak_project/data/repo/kisiler_daorepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AdminPageProfileState {}

class AdminPageProfileCubitInitial extends AdminPageProfileState {}

class AdminPageProfilePhotoChanged extends AdminPageProfileState {}

class AdminPagePasswordChanged extends AdminPageProfileState {}

class AdminPageProfileCubit extends Cubit<AdminPageProfileState> {
  AdminPageProfileCubit() : super(AdminPageProfileCubitInitial());

  final _repo = AuthRepository();

  Future<void> SifreSifirla(email) async {
    try {
      await _repo.sendPasswordResetEmail(email);
      emit(AdminPagePasswordChanged());
    } catch (e) {
      print("Hata Tespit Edildi : $e");
    }
  }

}
