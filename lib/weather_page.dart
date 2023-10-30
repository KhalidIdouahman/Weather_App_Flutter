import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              print("refresh btn clicked");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // main card
          const Placeholder(fallbackHeight: 250,),
          SizedBox(height: 20,),
          // weather forecast card
          const Placeholder(fallbackHeight: 150,),
          SizedBox(height: 20,),
          // additionall informations
          const Placeholder(fallbackHeight: 150,),
        ],
      ),
    );
  }
}
