import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyShared extends StatefulWidget {
  const MyShared({Key? key});

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
        backgroundColor: Colors.purple,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'About Application',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Aplikasi ini menyimpan informasi tentang obat-obatan psikofarmasi. '
                      'Psikofarmasi adalah obat yang mempengaruhi fungsi mental dan emosional otak. '
                      'Obat-obat ini digunakan untuk mengelola berbagai kondisi kesehatan mental.',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Purpose of Application:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Aplikasi ini bertujuan untuk memudahkan para pengguna mengetahui obat apa saja yang dibutuhkan untuk kesehatan mental '
                      'dan mengetahui jenis penyakit kesehatan mental.',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'App Creators:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Juwita Stefany Hutapea '
                      '\nDirga Febrian',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                        labelText: 'Enter additional information',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          loginData = await SharedPreferences.getInstance();
                          String text = textController.text;
                          loginData.setString('additionalInfo', text);
                          textController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: textController2,
                      decoration: const InputDecoration(
                        labelText: 'Stored Information',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          loginData = await SharedPreferences.getInstance();
                          String text =
                              loginData.getString('additionalInfo') ?? '';
                          setState(() {
                            textController2.text = text;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Get Additional Info',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          textController2.clear();
                          loginData.remove('additionalInfo');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Delete Additional Info',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
