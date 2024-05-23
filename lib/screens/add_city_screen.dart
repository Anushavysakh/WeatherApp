import 'package:flutter/material.dart';

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({super.key});

  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          TextField(
            controller: cityController,
            decoration: const InputDecoration(
                hintText: 'City name',
                prefixIcon: Icon(Icons.arrow_back_ios_new)),
          ),
        ],
      ),
    );
  }
}
