import 'package:flutter/material.dart';
import 'package:flutter_obat/model/rs_model.dart';

class RSCard extends StatelessWidget {
  final RSResponse rsRes;
  final Function() onDismissed;

  const RSCard({Key? key, required this.rsRes, required this.onDismissed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(rsRes.message),
      onDismissed: (direction) {
        onDismissed();
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.lightBlue[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (rsRes.insertedId != null) _buildDataRow("ID", rsRes.insertedId),
            _buildDataRow("Message", rsRes.message),
            _buildDataRow("Status", rsRes.status),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, dynamic value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10), // Jarak antara label dan titik dua
        Expanded(
          child: Text(
            ': $value',
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
