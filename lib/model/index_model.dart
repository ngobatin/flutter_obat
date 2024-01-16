class IndexModel {
  final String? text;
  final String? image;

  IndexModel({
    this.text,
    this.image,
  });

  List<Map<String, String>> indexData = [
    {
      "text": "Welcome to SmartMeds, Let’s find out!",
      "image": "images/splash_obat1.png"
    },
    {
      "text":
          "We help people to know about various kinds of drugs, \nespecially psychopharmaceuticals",
      "image": "images/splash_obat2.png"
    },
    {
      "text":
          "We show the types of mental illnesses and \nhospitals that provide mental health services",
      "image": "images/splash_obat3.png"
    },
  ];
}
