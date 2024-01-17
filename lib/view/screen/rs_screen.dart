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
        title: const Text("Rumah Sakit"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade900,
      ),
      body: const Center(
        child: Text("Rumah Sakit Screen"),
      ),
    );
  }
}