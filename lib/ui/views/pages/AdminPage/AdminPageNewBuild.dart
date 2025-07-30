import 'dart:io';
import 'package:emlak_project/ui/cubit/AdminPageNewBuildCubit.dart';
import 'package:flutter/material.dart';
import 'package:emlak_project/ui/views/viewUIsettings/viewUIsettings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AdminPageNewBuild extends StatefulWidget {
  const AdminPageNewBuild({super.key});

  @override
  State<AdminPageNewBuild> createState() => _AdminPageNewBuildState();
}

class _AdminPageNewBuildState extends State<AdminPageNewBuild> {
  final TextEditingController _ilanIsmiController = TextEditingController();
  final TextEditingController _aciklamaController = TextEditingController();
  final TextEditingController _konumController = TextEditingController();
  final TextEditingController _fiyatController = TextEditingController();
  final TextEditingController _metrekareController = TextEditingController();
  final TextEditingController _odaController = TextEditingController();
  final TextEditingController _binaYasiController = TextEditingController();
  String? _secilenKimden;
  DateTime? _ilanTarihi;
  List<File> _seciliFotograflar = [];

  void _formuTemizle() {
    _ilanIsmiController.clear();
    _aciklamaController.clear();
    _konumController.clear();
    _fiyatController.clear();
    _metrekareController.clear();
    _odaController.clear();
    _binaYasiController.clear();
    _ilanTarihi = null;
    _secilenKimden = null;
    _seciliFotograflar.clear();
    setState(() {});
  }

  Future<void> _tarihSec(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _ilanTarihi = picked;
      });
    }
  }

  Future<void> _fotografSec() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _seciliFotograflar =
            pickedFiles.map((xfile) => File(xfile.path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainThemeColor,
      appBar: AppBar(
        backgroundColor: mainThemeColor,
        iconTheme: IconThemeData(color: secondaryThemeColor),
        title: Text(
          "Yeni İlan Ekle",
          style: TextStyle(color: mainWriteColor, fontFamily: "Pacifico"),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 10),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: mainThemeColor,
              child: Image.asset("assets/images/logo.png", width: 50, height: 50),
            ),
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.white24),
          ListTile(
            leading: Icon(Icons.title, color: Colors.white),
            title: TextField(
              controller: _ilanIsmiController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "İlan Başlığı",
                hintStyle: TextStyle(color: Colors.white60),
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(color: Colors.white24),
          ListTile(
            leading: Icon(Icons.description, color: Colors.white),
            title: TextField(
              controller: _aciklamaController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Açıklama",
                hintStyle: TextStyle(color: Colors.white60),
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(color: Colors.white24),
          ListTile(
            leading: Icon(Icons.location_on, color: Colors.white),
            title: TextField(
              controller: _konumController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Konum",
                hintStyle: TextStyle(color: Colors.white60),
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(color: Colors.white24),
          ListTile(
            leading: Icon(Icons.attach_money, color: Colors.white),
            title: TextField(
              controller: _fiyatController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Fiyat (₺)",
                hintStyle: TextStyle(color: Colors.white60),
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(color: Colors.white24),
          ListTile(
            leading: Icon(Icons.square_foot, color: Colors.white),
            title: TextField(
              controller: _metrekareController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Metrekare",
                hintStyle: TextStyle(color: Colors.white60),
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(color: Colors.white24),
          ListTile(
            leading: Icon(Icons.bed, color: Colors.white),
            title: TextField(
              controller: _odaController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Oda Sayısı (örn: 2+1)",
                hintStyle: TextStyle(color: Colors.white60),
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(color: Colors.white24),
          ListTile(
            leading: Icon(Icons.apartment, color: Colors.white),
            title: TextField(
              controller: _binaYasiController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Bina Yaşı",
                hintStyle: TextStyle(color: Colors.white60),
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(color: Colors.white24),
          ListTile(
            leading: Icon(Icons.calendar_today, color: Colors.white),
            title: Text(
              _ilanTarihi != null
                  ? "İlan Tarihi: ${_ilanTarihi!.toLocal().toString().split(" ")[0]}"
                  : "İlan Tarihi Seçilmedi",
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: Icon(Icons.date_range, color: Colors.white),
              onPressed: () => _tarihSec(context),
            ),
          ),
          Divider(color: Colors.white24),
          ListTile(
            leading: Icon(Icons.person, color: Colors.white),
            title: DropdownButtonFormField<String>(
              dropdownColor: mainThemeColor,
              decoration: InputDecoration.collapsed(hintText: "Kimden"),
              hint: Text("Kimden", style: TextStyle(color: Colors.white60)),
              value: _secilenKimden,
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.white,
              items: ['Sahibinden', 'Emlakçı']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => _secilenKimden = value),
            ),
          ),
          Divider(color: Colors.white24),
          const SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.photo_library, color: Colors.white),
            title: Text("Fotoğraf Seç", style: TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: Icon(Icons.add_a_photo, color: Colors.white),
              onPressed: _fotografSec,
            ),
          ),
          if (_seciliFotograflar.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _seciliFotograflar.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _seciliFotograflar[index],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          const SizedBox(height: 20),

          /// ✅ İlan Kaydet + Sıfırla Butonları
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_seciliFotograflar.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Lütfen en az 1 fotoğraf seçin.")),
                      );
                      return;
                    }

                    final ilkFoto = _seciliFotograflar.first;

                    await context.read<AdminPageNewBuildCubit>().konutEkle(
                      ilkFoto,
                      _aciklamaController.text,
                      _ilanIsmiController.text,
                      _konumController.text,
                      _fiyatController.text,
                      _metrekareController.text,
                      _odaController.text,
                      _binaYasiController.text,
                      _ilanTarihi?.toIso8601String() ?? '',
                      _secilenKimden ?? '',
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("✅ İlan başarıyla kaydedildi."),
                        backgroundColor: Colors.green,
                      ),
                    );

                    _formuTemizle();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: mainThemeColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("İlanı Kaydet"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _formuTemizle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade100,
                    foregroundColor: Colors.red.shade800,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("Sıfırla"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}