import 'package:emlak_project/ui/cubit/AdminPageNewBuildCubit.dart';
import 'package:emlak_project/ui/cubit/ResetPasswordCubit.dart';
import 'package:emlak_project/ui/cubit/adminpageCubit.dart';
import 'package:emlak_project/ui/cubit/loginpageCubit.dart';
import 'package:emlak_project/ui/cubit/mainPageCubit.dart';
import 'package:emlak_project/ui/cubit/signUpCubit.dart';
import 'package:emlak_project/ui/cubit/splashscreenCubit.dart';


import 'package:emlak_project/ui/views/login.dart';
import 'package:emlak_project/ui/views/pages/MainPage/mainPage.dart';
import 'package:emlak_project/ui/views/pages/AdminPage/AdminPageGnav.dart';
import 'package:emlak_project/ui/views/splashscreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (_) => mainPageCubit()),
        BlocProvider(create: (_) => SignUpCubit()),
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => AdminPageCubit()),
        BlocProvider(create: (_) => PasswordResetCubit()),
        BlocProvider(create: (_) => SplashScreenCubit()),
        BlocProvider(create: (_) => AdminPageNewBuildCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ITShop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        // Splash ekranı başlangıçta yüklenecek
        initialRoute: '/',
        routes: {
          '/': (context) =>  SplashScreen(),
          '/login': (context) =>  Login(),
          '/home': (context) =>  Mainpage(),
          '/admin': (context) =>  AdminPageGnav(),
        },

      ),
    );
  }
}
