import 'package:emlak_project/ui/cubit/signUpCubit.dart';
import 'package:emlak_project/ui/views/login.dart';
import 'package:emlak_project/ui/views/viewUIsettings/signButtons.dart';
import 'package:emlak_project/ui/views/viewUIsettings/viewUIsettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _telnoController = TextEditingController();
  final TextEditingController _epostaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.sizeOf(context).width;
    final double deviceHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Melek Demir Gayrimenkul",
          style: TextStyle(
            color: mainWriteColor,
            fontFamily: "Pacifico",
            fontSize: 25,
          ),
        ),
        backgroundColor: mainThemeColor,
        iconTheme: IconThemeData(
          color: secondaryThemeColor,
        ),
      ),
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Kayıt başarılı! Giriş ekranına yönlendiriliyorsunuz.")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          } else if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Kayıt başarısız! Lütfen tekrar deneyin.")),
            );
          }
        },
        builder: (context, state) {
          return Container(
            width: deviceWidth,
            height: deviceHeight,
            color: lightTheme,
            child: Padding(
              padding: EdgeInsets.only(bottom: deviceHeight * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: deviceWidth / 3,
                    height: deviceHeight / 4,
                    child: Image.asset('assets/images/blacklogo.png'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SignTextField(
                          labelText: "Ad",
                          hintText: "",
                          controller: _nameController,
                          anaYaziRengi: secondaryWriteColor,
                          borderColor: mainThemeColor,
                        ),
                      ),
                      Expanded(
                        child: SignTextField(
                          labelText: "Soyad",
                          hintText: "",
                          controller: _surnameController,
                          anaYaziRengi: secondaryWriteColor,
                          borderColor: mainThemeColor,
                        ),
                      ),
                    ],
                  ),
                  SignTextField(
                    labelText: "E-Posta",
                    hintText: "",
                    controller: _epostaController,
                    anaYaziRengi: secondaryWriteColor,
                    borderColor: mainThemeColor,
                  ),
                  SignTextField(
                    labelText: "Telefon",
                    hintText: "",
                    controller: _telnoController,
                    anaYaziRengi: secondaryWriteColor,
                    borderColor: mainThemeColor,
                  ),
                  SignTextField(
                    labelText: "Şifre",
                    hintText: "",
                    controller: _passwordController,
                    anaYaziRengi: secondaryWriteColor,
                    borderColor: mainThemeColor,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SignUpCubit>().signUp(
                        _nameController.text.trim(),
                        _surnameController.text.trim(),
                        _epostaController.text.trim(),
                        _passwordController.text.trim(),
                        _telnoController.text.trim(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryThemeColor,
                      foregroundColor: mainThemeColor,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: mainThemeColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text("Kayıt Ol", style: TextStyle(color: mainThemeColor)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

  }
}
