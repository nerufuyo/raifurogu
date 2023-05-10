import 'package:flutter/material.dart';
import 'package:raifurogu/app/pages/home/home_page.dart';
import 'package:raifurogu/app/styles/pallets.dart';

void main() {
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
        initialRoute: HomePage.routeName,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomePage());
            default:
              return null;
          }
        }
    );
  }
}
