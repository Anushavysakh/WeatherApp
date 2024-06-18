import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:task/screens/login_register_screen.dart';
import 'package:task/services/auth_service.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../widgets/city_list_screen.dart';
import '../widgets/image_data.dart';
import '../widgets/weather_data_container.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WeatherHomeScreen> {
  WeatherService? _weatherService;
  Future<WeatherModel>? defaultCityData;
  WeatherModel? weatherModel;
  AuthService authService = AuthService();

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    _weatherService = WeatherService();
    //  getCurrentLocation();
    //   setState(() {
    //     defaultCityData = getCurrentLocation();
    //   });
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,
    );

    if (position != null) {
      try {
        //   final data = await _weatherService?.getCurrentCity(position, '');
        return await _weatherService?.getCurrentCity(position, '');
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(defaultCityData);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding:
              const EdgeInsets.only(top: 2, right: 10, left: 10, bottom: 100),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover)),
          child: FutureBuilder(
              future: getCurrentLocation(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error.toString()} occurred',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                  else if (snapshot.hasData) {
                    final data = snapshot.data as WeatherModel;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(flex: 2,
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  data.countryName.toString() ?? '',
                                  style: const TextStyle(
                                      fontSize: 29,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              IconButton(
                                icon: const Icon(Icons.maps_home_work_sharp),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CityListPage(),
                                  ));
                                },
                              ),
                              IconButton(
                                  onPressed: signOut,
                                  icon: Icon(Icons.logout),color: Colors.white,),

                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        WeatherDataContainer(weatherModel: data),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(12),
                          width: 400,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ImageData(
                                      'assets/thermometer.png',
                                      'Feels like ',
                                      '${data.temperature.toStringAsFixed(2)}\u00B0C'),
                                  //  ImageData('assets/fan.png', 'SE', 'Force 3'),
                                  ImageData(
                                      'assets/barometer.png',
                                      'Air pressure',
                                      data.airPressure.toString() ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ImageData('assets/humidity.png', 'Humidity',
                                      '${data.humidity}%'),

                                  ImageData('assets/visibility.png',
                                      'Visibility', '${data.visibility}km'),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  // else if (snapshot.connectionState ==
                  //     ConnectionState.waiting) {
                  //   return const Center(child: CircularProgressIndicator());
                  // }
                  else {
                    return Center(
                      child: Text("${snapshot.connectionState} occurred"),
                    );
                  }
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }

  signOut() async {
    await authService.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginRegistrationScreen()));
  }

  List imageData = [
    {'assets/thermometer.png', 'Feels like'},
    {'assets/barometer.png', 'Air pressure'},
    {'assets/fan.png', 'SE'},
    {'assets/humidity.png', 'Humidity'},
    {'assets/protection.png', 'UV'},
    {'assets/visibility.png', 'Visibility'},
  ];
}

