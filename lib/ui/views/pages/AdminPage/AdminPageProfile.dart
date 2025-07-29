import 'package:emlak_project/ui/views/login.dart';

import 'package:emlak_project/ui/views/pages/AdminPage/AdminPageProfilePhoto.dart';
import 'package:emlak_project/ui/views/pages/AdminPage/AdminPasswordChange.dart';

import 'package:emlak_project/ui/views/viewUIsettings/viewUIsettings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/signUpCubit.dart';

class AdminPageProfile extends StatefulWidget {
  const AdminPageProfile({super.key});

  @override
  State<AdminPageProfile> createState() => _AdminPageProfileState();
}
class _AdminPageProfileState extends State<AdminPageProfile> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainThemeColor,
      appBar: AppBar(
        backgroundColor: mainThemeColor,
        title: Image.asset("assets/images/logo.png", scale: 15),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: secondaryThemeColor.withAlpha(50),
                    child: Icon(Icons.person, size: 60, color: secondaryThemeColor),
                  ),
                  const SizedBox(height: 30),
                  Divider(color: Colors.white24,),
                  Text(
                    FirebaseAuth.instance.currentUser?.displayName ??
                        FirebaseAuth.instance.currentUser?.email ??
                        "Kullanıcı",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Divider(color: Colors.white24,),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.white),
              title: Text(
                "Şifre Değiştir",
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.white),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminPasswordChange()));
              },
            ),
            Divider(color: Colors.white24),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.redAccent),
              title: Text(
                "Çıkış Yap",
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () async {
                await context.read<SignUpCubit>().signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

