import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String tempeture;
  const HourlyForecastItem(this.time , this.icon , this.tempeture ,{super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Icon(
                icon,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(tempeture),
            ],
          ),
        ),
      ),
    );
  }
}
