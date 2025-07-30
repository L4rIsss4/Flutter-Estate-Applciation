import 'package:emlak_project/ui/cubit/loginpageCubit.dart';
import 'package:emlak_project/ui/views/pages/AdminPage/AdminPageGnav.dart';
import 'package:emlak_project/ui/views/pages/MainPage/MainPageGnav.dart';
import 'package:emlak_project/ui/views/resetPassword.dart';
import 'package:emlak_project/ui/views/signUp.dart';
import 'package:emlak_project/ui/views/viewUIsettings/signButtons.dart';
import 'package:emlak_project/ui/views/viewUIsettings/viewUIsettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/AdminPage/adminPage.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.sizeOf(context).width;
    final double deviceHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Giriş Sayfası",
          style: TextStyle(
            color: mainWriteColor,
            fontFamily: "Pacifico",
            fontSize: 25,
          ),
        ),
        backgroundColor: mainThemeColor,
      ),
      body: BlocListener<LoginCubit, String?>(
        listener: (context, state) {

          if (state == "admin") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  AdminPageGnav()),
            );
          } else if (state == "kullanici") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  MainPageGnav()),
            );
          } else if (state == "hata") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Giriş başarısız. E-Posta veya şifre hatalı."),
              ),

            );
          }
        },
        child: Container(
          width: deviceWidth,
          height: deviceHeight,
          color: lightTheme,

          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/blacklogo.png",
                  width: deviceWidth / 3, height: deviceHeight / 4),
              const SizedBox(height: 16),
              SignTextField(
                labelText: "E-Posta",
                hintText: "example@gmail.com",
                controller: _emailController,

                anaYaziRengi: secondaryWriteColor,
                borderColor: mainThemeColor,
              ),
              SignTextField(
                labelText: "Şifre",

                hintText: "••••••••",

                controller: _passwordController,
                anaYaziRengi: secondaryWriteColor,
                borderColor: mainThemeColor,
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();
                  context.read<LoginCubit>().login(email, password);

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryThemeColor,
                  foregroundColor: mainThemeColor,

                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: mainThemeColor, width: 1),
                  ),
                ),
                child: const Text("Giriş Yap"),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "Hesabınız mı yok?",
                    style: TextStyle(
                      color: secondaryWriteColor,
                      fontSize: 14,

                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(builder: (context) => const signUp()),
                      );
                    },
                    child: const Text(
                      "Kayıt Olun",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),

                ],
              ),
              TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>ResetPassword()));
              }, child: Text("Şifrenizi Mi Unuttunuz?", style: TextStyle(color: secondaryWriteColor),))

            ],
          ),
        ),
      ),
    );
  }
}
