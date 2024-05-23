import 'package:flutter/material.dart';
class ImageData extends StatelessWidget {
  String path;
  String data;
  String identifiedData;

  ImageData(this.path, this.data, this.identifiedData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          path,
          semanticLabel: data,
          width: 40,
          height: 30,
          color: Colors.black,
          filterQuality: FilterQuality.high,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          identifiedData,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          data,
          style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
