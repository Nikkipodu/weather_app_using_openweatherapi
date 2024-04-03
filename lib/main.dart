import 'package:flutter/material.dart';
import 'package:weather_app_using_openweatherapi/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      title: 'Weather',
      theme:ThemeData(
        scaffoldBackgroundColor: const Color(0xFF303030),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home:const HomePage(),
      );



  }
}


