import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Psikofarmaka",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildCreatorProfile(
                "Creator 1",
                "Dirga Febrian",
                "1214039",
                "@febriand_1",
                "Live life to the fullest",
                "BukitTinggi",
                "assets/images/dirga.png"),
            const SizedBox(height: 20),
            _buildCreatorProfile(
                "Creator 2",
                "Juwita Stefany",
                "1214026",
                "@wops1e_",
                "Be yourself; everyone else is already taken",
                "Medan",
                "assets/images/juwitas.png"),
          ],
        ),
      ),
    );
  }

  Widget _buildCreatorProfile(String title, String fullName, String npm,
      String socialMedia, String motto, String tempatlahir, String imagePath) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama: $fullName"),
            Text("NPM: $npm"),
            Text("Instagram: $socialMedia"),
            Text("Motto: $motto"),
            Text("Tempat Lahir: $tempatlahir"),
          ],
        ),
      ),
    );
  }
}
