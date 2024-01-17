import 'package:flutter/material.dart';

class ObatScreen extends StatefulWidget {
  const ObatScreen({super.key});

  @override
  State<ObatScreen> createState() => _ObatScreenState();
}

class _ObatScreenState extends State<ObatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Psikofarmaka",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
        ),
        // centerTitle: true,
        backgroundColor: Colors.orange.shade900,
      ),
      body: const Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Obat",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
