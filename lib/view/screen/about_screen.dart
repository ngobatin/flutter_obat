import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyShared extends StatefulWidget {
  const MyShared({Key? key}) : super(key: key);

  @override
  State<MyShared> createState() => _MySharedState();
}

class _MySharedState extends State<MyShared> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  late SharedPreferences loginData;

  @override
  void dispose() {
    textController.dispose();
    textController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Psikofarmaka'),
        backgroundColor: Colors.orange.shade900,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildCard(
                  'About Application',
                  'Aplikasi Psikofarmaka adalah platform yang menyediakan solusi komprehensif untuk administrasi data obat, penyakit, dan rumah sakit.Aplikasi ini memberikan pengalaman pengguna yang baik, mendukung tugas administratif, dan menyediakan akses yang mudah ke data kesehatan.',
                  Icons.info_outline,
                  Colors.blue.shade700,
                ),
                const SizedBox(height: 16),
                _buildCard(
                  'Purpose of Application',
                  '1. Memberikan solusi untuk admin dalam melakukan tugas CRUD terkait obat, penyakit, dan rumah sakit, sehingga memperoleh manajemen data yang efisien.\n'
                      '2. Menyediakan akses yang mudah bagi pengguna untuk melihat informasi terkait obat, penyakit, dan rumah sakit, mendukung pemahaman yang lebih baik tentang kesehatan.\n'
                      '3. Memungkinkan admin untuk dengan mudah menambah, memperbarui, dan mengahpus data obat, penyakit, dan rumah sakit, meningkatkan produktivitas dalam administrasi informasi kesehatan.\n'
                      '4. Menyelenggarakan sistem keamanan yang terintegrasi untuk memastikan bahwa hanya admin yang memiliki hak akses penuh terhadap fungsi CRUD, sementara pengguna hanya dapat melihat data yang tersedia.',
                  Icons.assignment,
                  Colors.green.shade700,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      String title, String content, IconData iconData, Color cardColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cardColor, cardColor.withOpacity(0.8)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  iconData,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
