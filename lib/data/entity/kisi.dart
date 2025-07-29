class Kisiler {
  String kisi_id;
  String kisi_ad;
  String kisi_soyad;
  String kisi_tel;
  String kisi_eposta;
  String? kisi_photo;


  Kisiler({
    required this.kisi_id,
    required this.kisi_ad,
    required this.kisi_tel,
    required this.kisi_eposta,
    required this.kisi_soyad,
    this.kisi_photo

  });

  Map<String, dynamic> toJson() => {
    "kisi_ad": kisi_ad,
    "kisi_soyad": kisi_soyad,
    "kisi_tel": kisi_tel,
    "kisi_eposta": kisi_eposta,
    "kisi_photo" : kisi_photo

  };


  factory Kisiler.fromJson(Map<String, dynamic> json, String id) {
    return Kisiler(
      kisi_id: id,
      kisi_ad: json["kisi_ad"],
      kisi_tel: json["kisi_tel"],
      kisi_soyad: json["kisi_soyad"],
      kisi_eposta: json["kisi_eposta"],
      kisi_photo: json["kisi_photo"],

    );
  }
}



