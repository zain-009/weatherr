import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherr/models/weather_model.dart';
import 'package:weatherr/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool isLoading = true;
  final weatherService = WeatherService('db104413cac435153be999e70c6169c8');
  WeatherModel? _weather;

  _fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();
    try {
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny.json';
    }
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloudy.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
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
      backgroundColor: Colors.grey[900],
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 48,
                    color: Colors.grey[300],
                  ),
                  Text(
                    _weather?.cityName ?? "Loading City!",
                    style: GoogleFonts.quicksand(
                        fontSize: 48, color: Colors.grey[500]),
                  ),
                  Lottie.asset(getWeatherAnimation(_weather?.condition)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          _weather?.temperature.round().toString() ??
                              "Temperature Loading!",
                          style: GoogleFonts.quicksand(
                              fontSize: 48, color: Colors.grey[500])),
                      Text("°C",
                          style: GoogleFonts.quicksand(
                              fontSize: 48, color: Colors.grey[500])),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
