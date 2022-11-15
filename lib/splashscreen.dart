import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/tictactoe.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 7),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => const TicTacToe()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset('assets/images/images.jpg'));
  }
}

