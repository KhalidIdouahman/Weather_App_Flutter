import 'package:flutter/material.dart';
import 'package:weather_app/weather_page.dart';

void main() {
  runApp(const MyWeaterApp());
}

class MyWeaterApp extends StatelessWidget {
  const MyWeaterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const WeatherPage(),
    );
  }
}
