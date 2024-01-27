import 'package:flutter/material.dart';
import 'package:flutter_obat/view/widget/category.dart';
import 'package:flutter_obat/view/screen/admin/list_user.dart';
import 'package:flutter_obat/service/auth_manager.dart';
import 'package:flutter_obat/view/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_obat/view/widget/bottom_obat.dart';
import 'package:flutter_obat/view/widget/bottom_penyakit.dart';
import 'package:flutter_obat/view/widget/bottom_rs.dart';

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
      "data": "10",
      "screen": const DynamicBottomNavBarObat()
    },
    {
      "icon": "assets/icons/penyakit.svg",
      "text": "Penyakit",
      "data": "10",
      "screen": const DynamicBottomNavBarPenyakit()
    },
    {
      "icon": "assets/icons/rs.svg",
      "text": "Rumah Sakit",
      "data": "10",
      "screen": const DynamicBottomNavBarRS()
    },
    {
      "icon": "assets/icons/profile.svg",
      "text": "User",
      "data": "10",
      "screen": const ListUser()
    },
  ];

  late SharedPreferences loginData;
  String username = '';

  @override
  void initState() {
    super.initState();
    inital();
  }

  void inital() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('username').toString();
    });
  }

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
              color: Colors.white,
            ),
          ),
          // centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.orange.shade800,
          actions: [
            IconButton(
              onPressed: () {
                _showLogoutConfirmationDialog(context);
              },
              icon: const Icon(Icons.logout),
              color: Colors.white,
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade300,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage("assets/images/avatar.png"),
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hai, Welcome',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    categories.length,
                    (index) => InkWell(
                      child: DataCard(
                        text: categories[index]["text"],
                        data: categories[index]["data"],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
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
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                await AuthManager.logout();
// ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                  dialogContext,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
