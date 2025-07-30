import 'package:emlak_project/data/entity/konutBilgisi.dart';
import 'package:emlak_project/ui/cubit/mainPageCubit.dart';
import 'package:emlak_project/ui/views/pages/MainPage/mainpageKonutDetails.dart';
import 'package:emlak_project/ui/views/viewUIsettings/viewUIsettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../cubit/adminpageCubit.dart';
import '../AdminPage/AdminPageKonutDetails.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    context.read<mainPageCubit>().konutlariYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainThemeColor,

        title: isSearching
            ? TextField(
                decoration: InputDecoration(
                  hintText: "Ara",
                  hintStyle: TextStyle(color: mainWriteColor),
                ),
                style: TextStyle(color: mainWriteColor),
                onChanged: (aramaSonucu) {
                  context.read<AdminPageCubit>().konutAra(aramaSonucu);
                },
              )
            : Image.asset("assets/images/logo.png", width: 50, height: 50),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                    });
                    context.read<AdminPageCubit>().konutlariListele();
                  },
                  icon: const Icon(Icons.clear, color: Colors.white),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: const Icon(Icons.search, color: Colors.white),
                ),
        ],
        centerTitle: false,
      ),

      backgroundColor: secondaryThemeColor, // Arka plan rengi
      body: BlocBuilder<AdminPageCubit, AdminPageState>(
        builder: (context, state) {
          if (state is AdminPageUrunlerListelendi) {
            final konutListesi = state.konutListesi;
            return ListView.builder(
              itemCount: konutListesi.length,
              itemBuilder: (context, indeks) {
                var konut = konutListesi[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MainPageKonutDetails(konut: konut),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Card(
                        color: Colors.white,
                        shadowColor: Colors.black,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Konut Adı
                              Text(
                                konut.konut_ad,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const SizedBox(height: 10),

                              // Fotoğraf ve bilgiler
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      konut.konut_resim_url ?? "",
                                      width: 140,
                                      height: 140,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Açıklama: ${konut.konut_aciklama ?? "Bilgi yok"}",
                                          style: const TextStyle(fontSize: 14),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Konum: ${konut.konut_konum ?? "Bilinmiyor"}",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Fiyat: ${NumberFormat("#,##0", "tr_TR").format(int.tryParse(konut.konut_Fiyat ?? "0"))} ₺",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Çöp kutusu - sağ üst köşe
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
