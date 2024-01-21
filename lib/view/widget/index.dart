import 'package:flutter/material.dart';

class IndexContent extends StatefulWidget {
  const IndexContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  State<IndexContent> createState() => _IndexContentState();
}

class _IndexContentState extends State<IndexContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // const Spacer(),
        // const Text(
        //   "Psikofarmaka",
        //   style: TextStyle(
        //     fontSize: 32,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        const SizedBox(height: 10),
        Text(
          widget.text!,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 2),
        Image.asset(
          widget.image!,
          height: 265,
          width: 235,
        ),
      ],
    );
  }
}
