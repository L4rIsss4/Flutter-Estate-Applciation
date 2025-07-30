
class Konut {
  String konut_ad;
  String konut_id;
  String konut_aciklama;
  String konut_konum;
  String konut_Fiyat;
  String konut_metrekare;
  String konut_odasayisi;
  String konut_yasi;
  String konut_ilantarihi;
  String konut_ilansahibi;
  String? konut_resim_url;



  Konut (
      {
        required this.konut_id,
        required this.konut_ad,
        required this.konut_aciklama,
        required this.konut_konum,
        required this.konut_Fiyat,
        required this.konut_metrekare,
        required this.konut_odasayisi,
        required this.konut_yasi,
        required this.konut_ilantarihi,
        required this.konut_ilansahibi,
        this.konut_resim_url,
      }
      );




  factory Konut.fromJson (Map <dynamic,dynamic> json, String key) {
    return Konut(
        konut_id: key,
        konut_ad: json["konut_ad"] as String,
        konut_aciklama: json["konut_aciklama"] as String,
        konut_konum: json["konut_konum"] as String,
        konut_Fiyat: json["konut_Fiyat"] as String,
        konut_metrekare: json["konut_metrekare"] as String,
        konut_odasayisi: json["konut_odasayisi"] as String,
        konut_yasi: json["konut_yasi"] as String,
        konut_ilantarihi: json["konut_ilantarihi"] as String,
        konut_ilansahibi: json["konut_ilansahibi"] as String,
       konut_resim_url: json["konut_resim_url"] as String,

    );
  }

}
