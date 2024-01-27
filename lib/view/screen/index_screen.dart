import 'package:flutter/material.dart';
import 'package:flutter_obat/view/screen/register_screen.dart';
import 'package:flutter_obat/view/screen/login_screen.dart';
import 'package:flutter_obat/view/widget/index.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int currentPage = 0;
  List<Map<String, String>> indexData = [
    {
      "text": "Welcome to Psikofarmaka, Let’s find out!",
      "image": "assets/images/splash_obat1.png"
    },
    {
      "text":
          "We help people to know about various kinds of drugs, \nespecially psychopharmaceuticals",
      "image": "assets/images/splash_obat2.png"
    },
    {
      "text":
          "We show the types of mental illnesses and \nhospitals that provide mental health services",
      "image": "assets/images/splash_obat3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 60),
              const Text(
                "Psikofarmaka",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: indexData.length,
                  itemBuilder: (context, index) => IndexContent(
                    text: indexData[index]['text'],
                    image: indexData[index]["image"],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          indexData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: currentPage == index ? 20 : 6,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? Colors.blue
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                                // builder: (context) =>
                                //     const DynamicBottomNavBar(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade900,
                          ),
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                                // builder: (context) =>
                                //     const DynamicBottomNavBar(),
                              ),
                            );
                          },
                          child: const Text("Login"),
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPage(String text, String image) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 15.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          Image.asset(
            image,
            height: 250.0,
            width: 250.0,
          ),
        ],
      ),
    );
  }
}
