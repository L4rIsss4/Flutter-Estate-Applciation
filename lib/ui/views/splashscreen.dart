import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emlak_project/ui/views/login.dart';
import 'package:emlak_project/ui/views/pages/MainPage/MainPageGnav.dart';
import 'package:emlak_project/ui/views/pages/AdminPage/AdminPageGnav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/splashscreenCubit.dart';
import 'viewUIsettings/viewUIsettings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      user.reload().then((_) {
        final refreshedUser = FirebaseAuth.instance.currentUser;
        if (refreshedUser != null && refreshedUser.email != null) {
          context.read<SplashScreenCubit>().kullaniciRolGetir(refreshedUser.email!);
        } else {
          _goToLogin();
        }
      }).catchError((e) {
        _goToLogin();
      });
    } else {
      Future.delayed(const Duration(seconds: 2), _goToLogin);
    }
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainThemeColor,
      body: BlocListener<SplashScreenCubit, SplashScreenState>(
        listener: (context, state) {
          if (state is SplashScreenLoaded) {
            if (state.rol == "admin") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AdminPageGnav()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainPageGnav()),
              );
            }
          } else if (state is SplashScreenFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Bir hata oluştu.")),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", width: 150),
              const SizedBox(height: 20),
              CircularProgressIndicator(color: secondaryThemeColor),
            ],
          ),
        ),
      ),
    );
  }
}
