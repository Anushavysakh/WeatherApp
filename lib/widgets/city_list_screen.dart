import 'package:flutter/material.dart';

import '../screens/add_city_screen.dart';

class CityListPage extends StatefulWidget {
  const CityListPage({super.key});

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  List<String> cityList = [];

  getLocation() {}

  @override
  Widget build(BuildContext context) {
    TextEditingController cityNameController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        title: const Text("City Management"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddCityScreen(),
                ));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.white12,
                contentPadding: EdgeInsets.all(12),
                style: ListTileStyle.list,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Text(
                  "Varthur",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                trailing: Text("29"),
              ),
            );
          },
        ),
      ),
    );
  }

// addCity(){
//   return showDialog(context: context, builder: (context) {
//     Container(child: Column(),);
//   },);
// }
}
