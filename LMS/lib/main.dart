import 'package:flutter/material.dart';

void main() {
  runApp(const MyLMS());
}

class MyLMS extends StatelessWidget {
  const MyLMS({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
