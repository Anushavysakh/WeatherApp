import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/weather_model.dart';

class WeatherDataContainer extends StatelessWidget {
  const WeatherDataContainer({
    super.key,
    required WeatherModel? weatherModel,
  }) : _weatherModel = weatherModel;

  final WeatherModel? _weatherModel;

  @override
  Widget build(BuildContext context) {
    log('WeatherdataContainer');
    print(_weatherModel?.cityName);
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${_weatherModel?.temperature.toStringAsFixed(2)}\u00B0\C",

            style:  const TextStyle(
              color: Colors.white,
              fontSize: 80,
              fontWeight: FontWeight.w800,
            ),
          ),

          Text(
            "${_weatherModel?.description} ${_weatherModel?.feelsLike.toStringAsFixed(2)}\u00B0\C" ??
                '',
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
