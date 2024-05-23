import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/login_register_screen.dart';
import 'package:task/screens/weather_home_screen.dart';

class AuthState extends StatefulWidget {
  const AuthState({super.key});

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
          if(snapshot.hasData){
            return const WeatherHomeScreen();
          }
          else if(snapshot.hasError){
            return Center(child: Text('${snapshot.error}'),);
          }
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        return const LoginRegistrationScreen();
      },
    );
  }
}
