import 'package:tempo_template/models/weather_data.dart';
import 'package:tempo_template/utilities/constants.dart';

import 'location_service.dart';
import 'networking.dart';

class WeatherService {
  Future<WeatherData> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';

    var networkHelper = NetworkHelper(url);
    var networkData = await networkHelper.getData();

    return WeatherData.fromJson(networkData);
  }

  Future<WeatherData> getLocationWeather() async {
    var locationService = LocationService();
    var location = await locationService.getCurrentLocation();

    var url = '$openWeatherMapURL?'
        'lat=${location.latitude}&lon=${location.longitude}'
        '&units=metric&appid=$apiKey';

    var networkHelper = NetworkHelper(url);
    var networkData = await networkHelper.getData();

    return WeatherData.fromJson(networkData);
  }
}
