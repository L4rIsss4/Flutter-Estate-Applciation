import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emlak_project/data/entity/konutBilgisi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/konutbilgisi_daorepository.dart';

abstract class AdminPageState{}


class AdminPageInitial extends AdminPageState {}


class AdminPageUrunlerListelendi extends AdminPageState{
  final List<Konut> konutListesi;
  AdminPageUrunlerListelendi(this.konutListesi);
}
class AdminPageUrunlerListelenemedi extends AdminPageState{}

class AdminPageCubit extends Cubit<AdminPageState> {
    AdminPageCubit(): super(AdminPageInitial());
    StreamSubscription<List<Konut>>? _KonutSubscription;

    final konutDaoRepository _konutRepo = konutDaoRepository();

    void konutlariListele() {
      _KonutSubscription = _konutRepo.getKonut().listen((konutListesi) {
        emit(AdminPageUrunlerListelendi(konutListesi));
      });
    }

   Future <void> konutsil(konutId) async{
      await _konutRepo.konutSil(konutId);
   }

    Future<void> konutGuncelle(Konut guncellenmisKonut) async {
      try {
        // Belirli bir belgeyi güncellemek için document ID'yi al
        final String konutId = guncellenmisKonut.konut_id;
        _konutRepo.konutGuncelle(
            konutId: konutId,
            konut_ad: guncellenmisKonut.konut_ad,
            konutAciklama: guncellenmisKonut.konut_aciklama,
            konutKonum: guncellenmisKonut.konut_konum,
            konutFiyat: guncellenmisKonut.konut_Fiyat,
            konutMetrekare: guncellenmisKonut.konut_metrekare,
            konutOdaSayisi: guncellenmisKonut.konut_odasayisi,
            konutYasi: guncellenmisKonut.konut_yasi,
            konutIlanTarihi: guncellenmisKonut.konut_ilantarihi,
            konutIlanSahibi: guncellenmisKonut.konut_ilansahibi);
        print("Konut başarıyla güncellendi");
      } catch (e) {
        print("Konut güncellenirken hata oluştu: $e");
      }
    }

    void konutAra(String keyword) async {
      try {
        // Tüm konutları al
        final List<Konut> tumKonutlar = await _konutRepo.getKonut().first; // aşağıda bu da tanımlanacak

        // Arama filtresi (büyük/küçük harf duyarsız)
        final List<Konut> filtrelenmis = tumKonutlar.where((konut) {
          final lowerKeyword = keyword.toLowerCase();
          return konut.konut_ad.toLowerCase().contains(lowerKeyword) ||
              konut.konut_aciklama.toLowerCase().contains(lowerKeyword) ||
              konut.konut_konum.toLowerCase().contains(lowerKeyword);
        }).toList();

        emit(AdminPageUrunlerListelendi(filtrelenmis));
      } catch (e) {
        emit(AdminPageUrunlerListelenemedi());
        print("Arama sırasında hata oluştu: $e");
      }
    }



}