import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/forecast_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/weather_api_key.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  double temp = 0;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    String cityName = "London";

    try {
      final url = Uri.parse(
          "https://api.weatherapi.com/v1/forecast.json?key=$secret_weather_api_key&q=$cityName&days=1&aqi=no&alerts=no");

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw "Some Error is occured !";
      }

      final data = jsonDecode(response.body);

      return data;

      // setState(() {
      //   temp = data['current']['temp_c'];
      // });

      // print(response.statusCode);
      // print(response.body);
    } catch (e) {
      throw e.toString();
    }
    // print(data);
  }

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

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
              // print("refresh btn clicked");
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text(
              snapshot.error.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ));
          }

          final data = snapshot.data!;

          final dataRoot = data['current'];

          String currentTemp = dataRoot['temp_c'].toString();
          String currentCondition = dataRoot['condition']['text'];

          String humidity = dataRoot['humidity'].toString();
          String wind = dataRoot['wind_kph'].toString();
          String pressure = dataRoot['pressure_in'].toString();

          final forecastList = data['forecast']['forecastday'][0]['hour'];
          List<Widget> hourlyForecastWidgets = [];

          for (final hourForcast in forecastList) {
            final dateTime = hourForcast['time'].toString();
            final time = dateTime.split(' ')[1];
            final hourTemp = hourForcast['temp_c'].toString();

            hourlyForecastWidgets.add(HourlyForecastItem(time, Icons.cloud, "$hourTemp℃"));
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    // color: Color.fromARGB(255, 189, 189, 189),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            "$currentTemp℃",
                            style: const TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          const Icon(
                            Icons.sunny_snowing,
                            size: 64,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            currentCondition,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // weather forecast card
                const Text(
                  "Weather Forecast",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: hourlyForecastWidgets,
                  ),
                ),
                const SizedBox(height: 20),
                // additional informations
                const Text(
                  "Additional Information",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AdditionalInfoItem(Icons.water_drop, "Humidity", humidity),
                    AdditionalInfoItem(Icons.air, "Wind Speed", wind),
                    AdditionalInfoItem(
                        Icons.beach_access, "Pressure", pressure),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
