import 'package:emlak_project/ui/cubit/signUpCubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewUIsettings/viewUIsettings.dart';

class AdminPageProfilePhoto extends StatefulWidget {
  const AdminPageProfilePhoto({super.key});

  @override
  State<AdminPageProfilePhoto> createState() => _AdminPageProfilePhotoState();
}

class _AdminPageProfilePhotoState extends State<AdminPageProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: mainThemeColor,
      appBar: AppBar(
        backgroundColor: mainThemeColor,
        iconTheme: IconThemeData(color: secondaryThemeColor),
        title: Image.asset("assets/images/logo.png", scale: 15),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: secondaryThemeColor.withValues(alpha: 0.2),
                child: Icon(Icons.person, size: 60, color: secondaryThemeColor),
              ),
            ),
            const SizedBox(height: 40),

            Divider(color: Colors.white24),
          ],
        ),
      ),
    );
  }
}
