// ignore_for_file: use_build_context_synchronously

import 'package:emlak_project/data/entity/konutBilgisi.dart';
import 'package:emlak_project/ui/cubit/adminpageCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdminpageKonutDetails extends StatefulWidget {
  final Konut konut;
  const AdminpageKonutDetails({super.key, required this.konut});

  @override
  State<AdminpageKonutDetails> createState() => _AdminpageKonutDetailsState();
}

class _AdminpageKonutDetailsState extends State<AdminpageKonutDetails> {
  bool isEditing = false;
  LatLng? konum;

  late final TextEditingController adController;
  late final TextEditingController aciklamaController;
  late final TextEditingController konumController;
  late final TextEditingController fiyatController;
  late final TextEditingController resimController;
  late final TextEditingController ilanKimden;
  late final TextEditingController ilanTarihi;
  late final TextEditingController konutMetrekare;
  late final TextEditingController konutOdasayisi;
  late final TextEditingController konutYasi;

  @override
  void initState() {
    super.initState();
    adController = TextEditingController(text: widget.konut.konut_ad);
    aciklamaController = TextEditingController(text: widget.konut.konut_aciklama);
    konumController = TextEditingController(text: widget.konut.konut_konum);
    fiyatController = TextEditingController(text: widget.konut.konut_Fiyat);
    resimController = TextEditingController(text: widget.konut.konut_resim_url);
    ilanKimden = TextEditingController(text: widget.konut.konut_ilansahibi);
    ilanTarihi = TextEditingController(text: widget.konut.konut_ilantarihi);
    konutMetrekare = TextEditingController(text: widget.konut.konut_metrekare);
    konutOdasayisi = TextEditingController(text: widget.konut.konut_odasayisi);
    konutYasi = TextEditingController(text: widget.konut.konut_yasi);
    getCoordinatesFromAddress(konumController.text);
  }

  Future<void> getCoordinatesFromAddress(String adres) async {
    try {
      final locations = await locationFromAddress(adres);
      if (locations.isNotEmpty) {
        setState(() {
          konum = LatLng(locations.first.latitude, locations.first.longitude);
        });
      }
    } catch (e) {
      debugPrint("Konum alınamadı: $e");
    }
  }

  void kaydet(Konut guncellenmisKonut) {
    context.read<AdminPageCubit>().konutGuncelle(guncellenmisKonut);
    setState(() => isEditing = false);
  }

  void iptalEt() {
    setState(() {
      isEditing = false;
      adController.text = widget.konut.konut_ad;
      aciklamaController.text = widget.konut.konut_aciklama ?? "";
      konumController.text = widget.konut.konut_konum ?? "";
      fiyatController.text = widget.konut.konut_Fiyat ?? "";
      resimController.text = widget.konut.konut_resim_url ?? "";
    });
  }

  Widget bilgiAlani({required String label, required String value, IconData? icon}) {
    return Row(
      children: [
        if (icon != null) Icon(icon, color: Colors.grey),
        if (icon != null) const SizedBox(width: 4),
        Expanded(child: Text("$label: $value", style: const TextStyle(fontSize: 16))),
      ],
    );
  }

  Widget bilgiTextField({required TextEditingController controller, required String label, TextInputType? type}) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(labelText: label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.konut.konut_ad),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.close : Icons.edit),
            onPressed: () => setState(() => isEditing = !isEditing),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fotoğraf
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: resimController.text.isNotEmpty
                  ? Image.network(resimController.text, height: 230, width: double.infinity, fit: BoxFit.cover)
                  : Container(
                height: 230,
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.image, size: 80)),
              ),
            ),
            if (isEditing) bilgiTextField(controller: resimController, label: "Resim URL"),
            const SizedBox(height: 20),
            isEditing
                ? bilgiTextField(controller: adController, label: "Konut Adı")
                : Text(adController.text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            isEditing
                ? bilgiTextField(controller: fiyatController, label: "Fiyat (₺)", type: TextInputType.number)
                : Text("${fiyatController.text} ₺", style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            isEditing
                ? bilgiTextField(controller: konumController, label: "Konum")
                : bilgiAlani(label: "Konut Adresi", value: konumController.text, icon: Icons.location_on),
            const SizedBox(height: 12),
            isEditing
                ? bilgiTextField(controller: konutMetrekare, label: "Metrekare")
                : bilgiAlani(label: "Metrekare", value: konutMetrekare.text, icon: Icons.square_foot),
            const SizedBox(height: 12),
            isEditing
                ? bilgiTextField(controller: konutOdasayisi, label: "Oda Sayısı")
                : bilgiAlani(label: "Oda Sayısı", value: konutOdasayisi.text, icon: Icons.bed),
            const SizedBox(height: 20),
            isEditing
                ? bilgiTextField(controller: ilanKimden, label: "İlan Sahibi")
                : bilgiAlani(label: "İlan Sahibi", value: ilanKimden.text, icon: Icons.person),
            const SizedBox(height: 20),
            isEditing
                ? bilgiTextField(controller: ilanTarihi, label: "İlan Tarihi")
                : bilgiAlani(label: "İlan Tarihi", value: ilanTarihi.text, icon: Icons.date_range),
            const SizedBox(height: 20),
            const Text("Açıklama", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            isEditing
                ? TextField(
              controller: aciklamaController,
              maxLines: 6,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Açıklama girin..."),
            )
                : Text(aciklamaController.text, style: const TextStyle(fontSize: 15, height: 1.5)),
            const SizedBox(height: 20),
            const Text("Haritadaki Konumu", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            konum != null
                ? SizedBox(
              height: 250,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(target: konum!, zoom: 15),
                markers: {
                  Marker(
                    markerId: const MarkerId("konum"),
                    position: konum!,
                    infoWindow: InfoWindow(title: adController.text),
                  ),
                },
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
              ),
            )
                : const Center(child: Text("Konum haritada gösterilemiyor")),
            if (isEditing) ...[
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final guncellenmisKonut = Konut(
                          konut_id: widget.konut.konut_id,
                          konut_ad: adController.text,
                          konut_aciklama: aciklamaController.text,
                          konut_konum: konumController.text,
                          konut_Fiyat: fiyatController.text,
                          konut_resim_url: resimController.text,
                          konut_ilansahibi: ilanKimden.text,
                          konut_ilantarihi: ilanTarihi.text,
                          konut_metrekare: konutMetrekare.text,
                          konut_odasayisi: konutOdasayisi.text,
                          konut_yasi: konutYasi.text,
                        );
                        kaydet(guncellenmisKonut);
                      },
                      icon: const Icon(Icons.save),
                      label: const Text("Kaydet"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: iptalEt,
                      icon: const Icon(Icons.cancel),
                      label: const Text("İptal"),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
