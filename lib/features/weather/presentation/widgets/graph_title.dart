import 'package:flutter/material.dart';

class GraphTitle extends StatelessWidget {
  final String title;
  const GraphTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    );
  }
}
