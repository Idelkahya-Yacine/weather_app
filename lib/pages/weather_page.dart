import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // api key
  final _weatherService = WeatherService('744c267131ab747db27f9db425514d04');
  Weather? _weather; 

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any error
    catch (e) {
      print(e);
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition){
     if (mainCondition == null) return 'assets/sunny.json';

     switch (mainCondition.toLowerCase()) {
       case 'windy':
       case 'clouds':
          return 'asstes/windy.json';
       case 'rain':
       case 'rainy':
          return 'asstes/rain.json';
       case 'storm':
       case 'thunder':
          return 'assets/storm.json';
       case 'sunny':
          return 'assets/sunny.json';
       default:
          return 'assets/sunny.json';
     }
       
  }

  // init state
  @override
  void initState(){
    super.initState();

    // fetch weather on startup
    _fetchWeather(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? "loading city..."),

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // temperature
            Text('${_weather?.temperature.round()}C')
        ],
        ),
      ),
    );
  }
}