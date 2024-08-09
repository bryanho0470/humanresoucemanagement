import 'package:flutter/material.dart';

class DetailedQuestion extends StatelessWidget {
  const DetailedQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detailed "),
      ),
      body: const Material(
        child: Text("Body"),
      ),
    );
  }
}
