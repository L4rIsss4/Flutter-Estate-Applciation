import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/konutbilgisi_daorepository.dart';



abstract class AdminPageNewBuildState {}

class AdminPageNewBuildInitial extends AdminPageNewBuildState {}

class AdminPageNewBuildLoading extends AdminPageNewBuildState {}

class AdminPageNewBuildSuccess extends AdminPageNewBuildState {}

class AdminPageNewBuildFailure extends AdminPageNewBuildState {
  final String errorMessage;

  AdminPageNewBuildFailure(this.errorMessage);
}

class AdminPageNewBuildCubit extends Cubit<AdminPageNewBuildState> {

  AdminPageNewBuildCubit() : super(AdminPageNewBuildInitial());

  final _repo = konutDaoRepository();


  Future<void> konutEkle(
      File imageFile,
      String konut_aciklama,
      String konut_ad,
      String konut_konum,
      String konut_fiyat,
      String konut_metrekare,
      String konut_odasayisi,
      String konut_yasi,
      String konut_ilantarihi,
      String konut_ilansahibi,
      ) async {
    emit(AdminPageNewBuildLoading());

    try {
      final imageUrl = await _repo.cloudinaryUpload(imageFile);

      if (imageUrl != null) {
        await _repo.yeniKonutKayit(
          konutAciklama: konut_aciklama,
          konut_ad: konut_ad,
          konutKonum: konut_konum,
          konutFiyat: konut_fiyat,
          konutMetrekare: konut_metrekare,
          konutOdaSayisi: konut_odasayisi,
          konutYasi: konut_yasi,
          konutIlanTarihi: konut_ilantarihi,
          konutIlanSahibi: konut_ilansahibi,
          konutResimUrl: imageUrl,
        );
        emit(AdminPageNewBuildSuccess());
      } else {
        emit(AdminPageNewBuildFailure("Görsel yüklenemedi"));
      }
    } catch (e) {
      emit(AdminPageNewBuildFailure("Hata oluştu: $e"));
    }
  }

}
