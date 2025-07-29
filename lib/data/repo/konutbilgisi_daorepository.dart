import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emlak_project/data/entity/konutBilgisi.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
class konutDaoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference collectionKonut =
  FirebaseFirestore.instance.collection("konutData");


  Stream<List<Konut>> getKonut() {
    return collectionKonut.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Konut.fromJson(doc.data() as Map<String, dynamic>, doc.id)).toList());
  }


  Future<void> yeniKonutKayit({
    required String konutAciklama,
    required String konut_ad,
    required String konutKonum,
    required String konutFiyat,
    required String konutMetrekare,
    required String konutOdaSayisi,
    required String konutYasi,
    required String konutIlanTarihi,
    required String konutIlanSahibi,
    String? konutResimUrl,
  }) async {
    try {
      var yeniKonut = <String, dynamic>{
        "konut_aciklama": konutAciklama,
        "konut_ad" : konut_ad,
        "konut_konum": konutKonum,
        "konut_Fiyat": konutFiyat,
        "konut_metrekare": konutMetrekare,
        "konut_odasayisi": konutOdaSayisi,
        "konut_yasi": konutYasi,
        "konut_ilantarihi": konutIlanTarihi,
        "konut_ilansahibi": konutIlanSahibi,
        if (konutResimUrl != null) "konut_resim_url": konutResimUrl,
      };

      final docRef = await collectionKonut.add(yeniKonut);
      await docRef.update({"konut_id": docRef.id});
    } catch (e) {
      print("Kayıt sırasında hata oluştu: $e");
    }
  }

  Future<void> uploadImageAndSaveToFirebase({
    required File imageFile,
    required String konut_ad,
    required String konutAciklama,
    required String konutKonum,
    required String konutFiyat,
    required String konutMetrekare,
    required String konutOdaSayisi,
    required String konutYasi,
    required String konutIlanTarihi,
    required String konutIlanSahibi,
  }) async {
    final imageUrl = await cloudinaryUpload(imageFile);

    if (imageUrl != null) {
      await yeniKonutKayit(
        konutAciklama: konutAciklama,
         konut_ad : konut_ad,
        konutKonum: konutKonum,
        konutFiyat: konutFiyat,
        konutMetrekare: konutMetrekare,
        konutOdaSayisi: konutOdaSayisi,
        konutYasi: konutYasi,
        konutIlanTarihi: konutIlanTarihi,
        konutIlanSahibi: konutIlanSahibi,
        konutResimUrl: imageUrl,
      );
    } else {
      print("Görsel yüklenemedi, kayıt yapılmadı.");
    }
  }


  Future<void> konutGuncelle({
    required String konutId,
    required String konut_ad,
    required String konutAciklama,
    required String konutKonum,
    required String konutFiyat,
    required String konutMetrekare,
    required String konutOdaSayisi,
    required String konutYasi,
    required String konutIlanTarihi,
    required String konutIlanSahibi,
    String? konutResimUrl,
  }) async {
    try {
      var guncellenenKonut = {
        "konut_aciklama": konutAciklama,
        "konut_ad" : konut_ad,
        "konut_konum": konutKonum,
        "konut_Fiyat": konutFiyat,
        "konut_metrekare": konutMetrekare,
        "konut_odasayisi": konutOdaSayisi,
        "konut_yasi": konutYasi,
        "konut_ilantarihi": konutIlanTarihi,
        "konut_ilansahibi": konutIlanSahibi,
        if (konutResimUrl != null) "konut_resim_url": konutResimUrl,
      };

      await collectionKonut.doc(konutId).update(guncellenenKonut);
    } catch (e) {
      print("Güncelleme sırasında hata oluştu: $e");
    }
  }


  Future<void> konutSil(String konutId) async {
    try {
      await collectionKonut.doc(konutId).delete();
    } catch (e) {
      print("Silme sırasında hata oluştu: $e");
    }
  }

  Future<String?> cloudinaryUpload(File imageFile) async {
    final String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME']!;
    final String uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET']!;
    final Uri url =
    Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final resData = await http.Response.fromStream(response);
        final data = json.decode(resData.body);
        return data['secure_url'];
      } else {
        print('Cloudinary yükleme başarısız: HTTP ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Cloudinary hata: $e');
      return null;
    }
  }
}
