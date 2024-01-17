import 'package:flutter/material.dart';

class RsScreen extends StatefulWidget {
  const RsScreen({super.key});

  @override
  State<RsScreen> createState() => _RsScreenState();
}

class _RsScreenState extends State<RsScreen> {
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
              "Rumah Sakit",
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
