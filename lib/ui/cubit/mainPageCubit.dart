import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emlak_project/data/entity/konutBilgisi.dart';
import 'package:emlak_project/data/repo/konutbilgisi_daorepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class mainPageCubit extends Cubit<List<Konut>> {
  mainPageCubit() : super(<Konut>[]);
  final _konutRepo = konutDaoRepository();
  final _collectionKonut = FirebaseFirestore.instance.collection("konutData");

  Future<void> konutlariYukle() async {
    _collectionKonut.snapshots().listen((event) {
      var konutListesi = <Konut>[];
      var documents = event.docs;
      for (var document in documents) {
        var key = document.id;
        var data = document.data();
        var konut = Konut.fromJson(data, key);
        konutListesi.add(konut);
      }
      emit(konutListesi);
    });
  }

  Future<void> konutAra(String aramaKelimesi) async {
    _collectionKonut.snapshots().listen((event) {
      var konutListesi = <Konut>[];
      var documents = event.docs;
      for (var document in documents) {
        var key = document.id;
        var data = document.data();
        var konut = Konut.fromJson(data, key);

        if (konut.konut_ad.toLowerCase().contains(
          aramaKelimesi.toLowerCase(),
        )) {
          konutListesi.add(konut);
        }
      }
      emit(konutListesi);
    });
  }

  Future<void> konutSil(String konut_id) async {
    await _konutRepo.konutSil(konut_id);
  }
}
