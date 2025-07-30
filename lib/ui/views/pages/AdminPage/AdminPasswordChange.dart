import 'package:emlak_project/ui/views/login.dart';
import 'package:emlak_project/ui/views/viewUIsettings/viewUIsettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/ResetPasswordCubit.dart';
import '../../viewUIsettings/signButtons.dart';

class AdminPasswordChange extends StatefulWidget {
  const AdminPasswordChange({super.key});

  @override
  State<AdminPasswordChange> createState() => _AdminPasswordChangeState();
}

class _AdminPasswordChangeState extends State<AdminPasswordChange> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _mailController = TextEditingController();
    final double deviceWidth = MediaQuery.sizeOf(context).width;
    final double deviceHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: mainThemeColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: secondaryThemeColor),
        backgroundColor: mainThemeColor,
        centerTitle: true,
        title: Text(
          "Şifre Sıfırlama",
          style: TextStyle(fontFamily: "Pacifico", color: mainWriteColor),
        ),
      ),
      body: BlocListener<PasswordResetCubit, PasswordReset>(
        listener: (context, state) {
          if (state is PasswordResetEmailSended) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Bağlantı Gönderildi.")),
            );
          } else if (state is PasswordResetEmaiNotFounded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Girilen Mail İle Bağlantılı Hesap Bulunamadı")),
            );
          } else  {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Bir Hata Oluştu.")),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: deviceWidth / 3,
                height: deviceHeight / 4,
                child: Image.asset("assets/images/logo.png"),
              ),
              SignTextField(
                labelText: "Şifrenizi Göndermek İstediğiniz E posta: ",
                hintText: "",
                controller: _mailController,
                anaYaziRengi: mainWriteColor,
                borderColor: secondaryThemeColor,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<PasswordResetCubit>().sendPasswordResetEmail(
                    _mailController.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryThemeColor,
                  foregroundColor: mainThemeColor,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: mainThemeColor, width: 1),
                  ),
                ),
                child: Text("Gönder ", style: TextStyle(color: mainThemeColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
