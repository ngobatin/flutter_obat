import 'package:flutter/material.dart';
import 'package:flutter_obat/view/widget/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Map<String, dynamic>> categories = [
    {"icon": "assets/icons/obat.svg", "text": "Obat"},
    {"icon": "assets/icons/penyakit.svg", "text": "Penyakit"},
    {"icon": "assets/icons/rs.svg", "text": "Rumah Sakit"},
    {"icon": "assets/icons/profile.svg", "text": "Profile"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Psikofarmaka"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            categories.length,
            (index) => CategoryCard(
              icon: categories[index]["icon"],
              text: categories[index]["text"],
              press: () {},
            ),
          ),
        ),
      ),
    );
  }
}
