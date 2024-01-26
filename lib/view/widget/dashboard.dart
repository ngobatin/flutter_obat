import 'package:flutter/material.dart';

class DashboardCard extends StatefulWidget {
  const DashboardCard({
    Key? key,
    required this.image,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String image, text;
  final GestureTapCallback press;

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.image,
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 10),
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
