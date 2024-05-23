class WeatherModel {
  final String? cityName;
  final String? countryName;
  final double temperature;
  final double feelsLike;
  final String? description;
  final int humidity;
  final int clouds;
  final double airPressure;

  final double? latitude;
  final double? longitude;
  final int visibility;

  WeatherModel({
    this.cityName,
    this.countryName,
    this.description,
    required this.temperature,
    required this.visibility,
    required this.feelsLike,
    required this.airPressure,
    required this.humidity,
    required this.clouds,
    //   required this.rain,
    this.latitude,
    this.longitude,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      countryName: json['sys']['country'],
      temperature: json['main']['temp'] - 273.15.toDouble(),
      feelsLike: json['main']['feels_like'] - 273.15.toDouble(),
      humidity: json['main']['humidity'],
      visibility: json['visibility'],
      clouds: json['clouds']['all'],
      airPressure: json['main']['pressure'].toDouble(),
      description: json['weather'][0]['description'],
      latitude: json['coord']['lat'].toDouble(),
      longitude: json['coord']['lon'].toDouble(),
    );
  }
}
