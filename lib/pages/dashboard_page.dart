import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text("Dashboard Page"),
    );
  }
}
