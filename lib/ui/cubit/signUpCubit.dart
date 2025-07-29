// STATE TANIMI:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/kisi.dart';
import '../../data/repo/kisiler_daorepository.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {}

// CUBIT:
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final AuthRepository _repo = AuthRepository();

  Future<void> signUp(String ad, String soyad, String email, String sifre, String tel) async {
    try {
      Kisiler yeniKisi = Kisiler(
        kisi_id: "",
        kisi_ad: ad,
        kisi_soyad: soyad,
        kisi_eposta: email,
        kisi_tel: tel,

      );

      await _repo.signUpUser(yeniKisi, sifre);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure());
    }
  }

  Future <void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }
  Future<void> currentUser() async {
    await _repo.getCurrentUser();
  }
}
