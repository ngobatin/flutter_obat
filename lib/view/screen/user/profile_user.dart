import 'package:flutter/material.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({super.key});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
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
            const SizedBox(height: 10),
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
            Card(
              elevation: 10,
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/avatar.png"),
                ),
                title: Text(
                  "Username",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("phone number"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
