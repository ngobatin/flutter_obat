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
        title: const Text("Penyakit"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade900,
      ),
      body: const Center(
        child: Text("Penyakit Screen"),
      ),
    );
  }
}