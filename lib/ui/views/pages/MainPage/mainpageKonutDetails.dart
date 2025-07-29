// ignore_for_file: use_build_context_synchronously

import 'package:emlak_project/data/entity/konutBilgisi.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MainPageKonutDetails extends StatefulWidget {
  final Konut konut;
  const MainPageKonutDetails({super.key, required this.konut});

  @override
  State<MainPageKonutDetails> createState() => _MainPageKonutDetailsState();
}

class _MainPageKonutDetailsState extends State<MainPageKonutDetails> {
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

  Widget bilgiAlani({required String label, required String value, IconData? icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) Icon(icon, color: Colors.grey),
        if (icon != null) const SizedBox(width: 4),
        Expanded(
          child: Text(
            "$label: $value",
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.konut.konut_ad)),
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
            const SizedBox(height: 20),
            Text(adController.text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text("${fiyatController.text} ₺", style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            bilgiAlani(label: "Konut Adresi", value: konumController.text, icon: Icons.location_on),
            const SizedBox(height: 12),
            bilgiAlani(label: "Metrekare", value: konutMetrekare.text, icon: Icons.square_foot),
            const SizedBox(height: 12),
            bilgiAlani(label: "Oda Sayısı", value: konutOdasayisi.text, icon: Icons.bed),
            const SizedBox(height: 20),
            bilgiAlani(label: "İlan Sahibi", value: ilanKimden.text, icon: Icons.person),
            const SizedBox(height: 20),
            bilgiAlani(label: "İlan Tarihi", value: ilanTarihi.text, icon: Icons.date_range),
            const SizedBox(height: 20),
            const Text("Açıklama", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(aciklamaController.text, style: const TextStyle(fontSize: 15, height: 1.5)),
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
          ],
        ),
      ),
    );
  }
}
