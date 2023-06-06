import 'package:d_locker/Screens/addCard_screen.dart';
import 'package:d_locker/Screens/display_file_screen.dart';
import 'package:d_locker/Screens/main_screen.dart';
import 'package:d_locker/Screens/menuCard_screen.dart';
import 'package:d_locker/Screens/nav_screen.dart';
import 'package:d_locker/Screens/digiWallet.dart';
import 'package:d_locker/Screens/payment_screen.dart';
import 'package:d_locker/Screens/zDrawer.dart';
import 'package:d_locker/cardpart/cardmainscreen.dart';
import 'package:d_locker/home_page/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'Screens/Signup_page.dart';
import 'Modals/google_signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await dotenv.load(fileName: ".env"); // get the private key
  runApp(ProviderScope(
      child: MyApp())); // For accessing riverpod variables globally
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'D-Locker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.idScreen,
      routes: {
        HomePage.idScreen: (context) => HomePage(), 
        DigiWallet.idScreen: (context) => DigiWallet(),
        SignUp_page.idScreen: (context) => SignUp_page(),
        AddCardDetails.idScreen: (context) => AddCardDetails(),
        MenuCard.idScreen: (context) => MenuCard(),
        NavScreen.idScreen: (context) => NavScreen(),
        CardSave.idScreen: (context) => CardSave(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
