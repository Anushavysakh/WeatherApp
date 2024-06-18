import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task/screens/weather_home_screen.dart';
import 'package:task/services/auth_service.dart';
import '../widgets/input_text_field_widget.dart';

class LoginRegistrationScreen extends StatefulWidget {
  const LoginRegistrationScreen({super.key});

  @override
  State<LoginRegistrationScreen> createState() =>
      _LoginRegistrationScreenState();
}

class _LoginRegistrationScreenState extends State<LoginRegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool isLogin = false;
  AuthService authService = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 100,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              const Text(
                "Weather App",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              isLogin
                  ? InputTextFieldWidget(
                      controller: userNameController,
                      hintText: 'Username',
                      icon: const Icon(Icons.person),
                      textInputType: TextInputType.text,
                    )
                  : const SizedBox(height: 10),
              const SizedBox(
                height: 15,
              ),
              InputTextFieldWidget(
                controller: emailController,
                hintText: 'Email',
                icon: const Icon(Icons.email),
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              InputTextFieldWidget(
                controller: passwordController,
                hintText: 'Password',
                icon: const Icon(Icons.password),
                textInputType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  isLogin ? registerUser() : loginUser();
                },
                child: Text(isLogin ? 'Register' : 'Login'),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isLogin
                      ? 'Already have an account'
                      : 'Don\'t have an account?'),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                          emailController.clear();
                          passwordController.clear();
                        });
                        if (!isLogin) {
                          userNameController.clear();
                        }
                      },
                      child: Text(isLogin ? 'login' : 'Register'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    try {
      String firebaseResponse = await authService!.loginUser(
          email: emailController.text, password: passwordController.text);
      if (firebaseResponse == 'success') {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const WeatherHomeScreen(),
        ));
      } else {
        _buildShowDialog('Login Failed',
            'The user could not be registered. Please check your credentials and try again.');
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  _buildShowDialog(String title, String content) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(title),
          content:  Text(content),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void registerUser() async {
    print("RegisterUser");
    String userResponse = await authService.registerUser(
      email: emailController.text,
      userName: userNameController.text,
      password: passwordController.text,
    );
    if (userResponse == 'success') {
      setState(() {
        isLogin = !isLogin;
      });
    } else {
       _buildShowDialog('Registration Failed', "Try again..");
    }
  }
}
