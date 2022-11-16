import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:menu/Screens/ViewScreens/view_offer_screen.dart';
import 'package:menu/Screens/order_screen.dart';
import 'package:menu/Themes/colors_themes.dart';
import 'package:menu/screens/home_screen.dart';
import 'package:menu/screens/instructions_screen.dart';
import 'package:menu/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'نأنأة',
      theme: ThemeData(
        primaryColor: ThemesColor().getColor(6),
      ),
      routes: {
        '/' : (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        InstructionsScreen.routeName: (context) => const InstructionsScreen(),
        OrderScreen.routeName: (context) => const OrderScreen(),
        ViewOfferScreen.routeName: (context) => const ViewOfferScreen(),
      },
    );
  }
}
