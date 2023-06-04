import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:raifurogu/app/pages/authentication/login_page.dart';
import 'package:raifurogu/app/pages/authentication/signup_page.dart';
import 'package:raifurogu/app/pages/crud/add_page.dart';
import 'package:raifurogu/app/pages/crud/edit_page.dart';
import 'package:raifurogu/app/pages/home/home_page.dart';
import 'package:raifurogu/app/pages/profile/profile_page.dart';
import 'package:raifurogu/app/styles/pallets.dart';
import 'package:raifurogu/firebase_options.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Raifurogu',
      theme: customTheme,
      initialRoute: LoginPage.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case LoginPage.routeName:
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case SignupPage.routeName:
            return MaterialPageRoute(builder: (_) => const SignupPage());
          case HomePage.routeName:
            return MaterialPageRoute(builder: (_) => const HomePage());
          case AddPage.routeName:
            return MaterialPageRoute(builder: (_) => const AddPage());
          case EditPage.routeName:
            final id = settings.arguments as String;
            return MaterialPageRoute(builder: (_) => EditPage(id: id));
          case ProfilePage.routeName:
            return MaterialPageRoute(builder: (_) => const ProfilePage());
          default:
            return null;
        }
      },
    );
  }
}
