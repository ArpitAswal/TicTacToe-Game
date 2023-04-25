import 'package:flutter/material.dart';
import 'dart:async';

import 'package:tictactoe_game/tictactoe.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 7),
            () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TicTacToe())));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
          'assets/images/images.jpg',
          fit: BoxFit.contain,
        ));
  }
}

