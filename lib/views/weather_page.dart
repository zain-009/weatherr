import 'package:flutter/material.dart';
import 'package:weatherr/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherService = WeatherService('db104413cac435153be999e70c6169c8');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();
    try{
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

        ],
      ),
    );
  }
}
