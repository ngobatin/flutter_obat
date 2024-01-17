import 'package:flutter/material.dart';
import 'package:flutter_obat/view/widget/category.dart';
import 'package:flutter_obat/view/screen/obat_screen.dart';
import 'package:flutter_obat/view/screen/penyakit_screen.dart';
import 'package:flutter_obat/view/screen/rs_screen.dart';
import 'package:flutter_obat/view/screen/profile_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Map<String, dynamic>> categories = [
    {
      "icon": "assets/icons/obat.svg",
      "text": "Obat",
      "screen": const ObatScreen()
    },
    {
      "icon": "assets/icons/penyakit.svg",
      "text": "Penyakit",
      "screen": const PenyakitScreen()
    },
    {
      "icon": "assets/icons/rs.svg",
      "text": "Rumah Sakit",
      "screen": const RsScreen()
    },
    {
      "icon": "assets/icons/profile.svg",
      "text": "Profile",
      "screen": const ProfileScreen()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categories.length,
              (index) => InkWell(
                child: CategoryCard(
                  icon: categories[index]["icon"],
                  text: categories[index]["text"],
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => categories[index]["screen"],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
