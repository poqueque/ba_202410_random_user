import 'package:flutter/material.dart';
import 'package:random_user/screens/random_user.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RandomUserScreen(),
    );
  }
}
