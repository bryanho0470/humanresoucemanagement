import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hero Example',
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Navigate to the second screen
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SecondScreen()));
          },
          child: Hero(
            tag: 'imageHero', // heroTag
            child: Image.network(
              'https://yt3.ggpht.com/yti/ANjgQV_zjBNPQmlERoZ8QA5N5yChZGkAVUAEX8GED0KN6Apf7Q=s88-c-k-c0x00ffffff-no-rj',
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: Hero(
          tag: 'imageHero', // Same heroTag as in FirstScreen
          child: Image.network(
            'https://yt3.ggpht.com/yti/ANjgQV_zjBNPQmlERoZ8QA5N5yChZGkAVUAEX8GED0KN6Apf7Q=s88-c-k-c0x00ffffff-no-rj',
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}
