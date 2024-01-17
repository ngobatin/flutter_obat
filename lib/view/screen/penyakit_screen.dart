import 'package:flutter/material.dart';

class PenyakitScreen extends StatefulWidget {
  const PenyakitScreen({super.key});

  @override
  State<PenyakitScreen> createState() => _PenyakitScreenState();
}

class _PenyakitScreenState extends State<PenyakitScreen> {
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
              "Penyakit",
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