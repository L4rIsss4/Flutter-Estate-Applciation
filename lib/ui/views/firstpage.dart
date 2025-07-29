// uygulamaya ilk defa girildiğinde açılacak hoşgeldiniz ekranı

import 'package:emlak_project/ui/views/login.dart';
import 'package:emlak_project/ui/views/viewUIsettings/viewUIsettings.dart';


import 'package:flutter/material.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.sizeOf(context).width;
    final double deviceHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainThemeColor,
        title: Text(
          "Hoşgeldiniz!",
          style: TextStyle(
            fontFamily: "Pacifico",
            fontSize: 30,
            color: mainWriteColor,
          ),
        ),
      ),

      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        color: lightTheme,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                child: Column(
                children: [
                  Image.asset(
                    "assets/images/buy.png",
                    height: deviceHeight / 3,
                    width: deviceWidth / 3,
                  ),
                  Text(
                    "Melek Gayrimenkul ",
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 30,
                      color: secondaryWriteColor,
                    ),
                  ),
                ],
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text(
                "Giriş İçin Tıklayınız..",
                style: TextStyle(
                  color: secondaryWriteColor,
                  fontFamily: "NotoSerif",
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
