import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:humanresoucemanagement/firebase_options.dart';
import 'package:humanresoucemanagement/pages/landing_page.dart';
import 'package:humanresoucemanagement/pages/login_page.dart';
import 'package:humanresoucemanagement/pages/signup_page.dart';
import 'package:humanresoucemanagement/screens/splash_screen.dart';

void main() async {
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
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xff0179bd),
        secondaryHeaderColor: const Color(0xff85D5FF),
      ),
      debugShowCheckedModeBanner: false,
      title: "Shake Your Skills",
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(
              child: LoginPage(),
            ),
        "/home": (context) => const LandingPage(
              passedtoken: "no_token",
            ),
        "/login": (context) => const LoginPage(),
        "/signup": (context) => const SignUpPage(),
      },
    );
  }
}
