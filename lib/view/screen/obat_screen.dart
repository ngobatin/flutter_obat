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
        title: const Text("Obat"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade900,
      ),
      body: const Center(
        child: Text("Obat Screen"),
      ),
    );
  }
}