import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/kisiler_daorepository.dart';


abstract class PasswordReset {}

class PasswordResetInitial extends PasswordReset{}

class PasswordResetEmailSended extends PasswordReset{}

class PasswordResetEmailFailed extends PasswordReset{}

class PasswordResetEmaiNotFounded extends PasswordReset{}



class PasswordResetCubit extends Cubit<PasswordReset> {
  PasswordResetCubit() : super(PasswordResetInitial());

  final AuthRepository _repo = AuthRepository();

  Future<void> sendPasswordResetEmail (String email) async {
    try {
      bool emailExists = await _repo.getUserEmail(email);

      if (emailExists) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        emit(PasswordResetEmailSended());
      } else {
        emit(PasswordResetEmaiNotFounded());
      }
    } catch (e) {
      emit(PasswordResetEmailFailed());
      print("Şifre Sıfırlama Maili Gönderilemedi : $e" );
    }
  }


  Future<void> logout() async{
     await _repo.signOut();

  }







}