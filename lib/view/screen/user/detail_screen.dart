import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final List<String> data;
  final String title;

  const DetailScreen({Key? key, required this.data, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.8, // Adjust the aspect ratio as needed
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                onTap: () {
                  // Add your onTap action here if needed
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.local_hospital, // Add your desired icon
                        size: 30, // Adjust the icon size
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      data[index],
                      style: TextStyle(
                        fontSize: 14, // Adjust the font size
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // You can add more elements or customize further
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DetailScreen(
      title: "Detail Screen",
      data: ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"],
    ),
  ));
}
