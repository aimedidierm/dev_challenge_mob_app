import 'dart:async';

import 'package:dev_challenge/constants.dart';
import 'package:dev_challenge/screens/load.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Load(),
          ),
          (route) => false),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: themColor,
      ),
      home: Scaffold(
        backgroundColor: primaryColor,
        body: const Center(
          child: Text(
            'Dev challenge app',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
