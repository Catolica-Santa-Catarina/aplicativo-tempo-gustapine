import 'package:flutter/material.dart';
import 'package:tempo_template/models/weather_data.dart';
import 'package:tempo_template/screens/city_screen.dart';
import 'package:tempo_template/services/weather.dart';
import 'package:tempo_template/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({required this.weatherData, Key? key}) : super(key: key);

  final WeatherData weatherData;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late WeatherData weatherData;
  late String message;
  late String weatherIcon;

  void updateUI(WeatherData weatherData) {
    setState(() {
      this.weatherData = weatherData;
      message = weatherData.getMessage();
      weatherIcon = weatherData.getWeatherIcon();
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      weatherData = await WeatherService().getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CityScreen()));

                      var weatherData = await WeatherService()
                          .getCityWeather(cityName.toString());
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '${weatherData.temp}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message em ${weatherData.cityName}',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
